Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261314AbVFOIee@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261314AbVFOIee (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 04:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261317AbVFOIee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 04:34:34 -0400
Received: from odin2.bull.net ([192.90.70.84]:56232 "EHLO odin2.bull.net")
	by vger.kernel.org with ESMTP id S261314AbVFOIeW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 04:34:22 -0400
Subject: RT :  nvidia driver and perhaps others
From: "Serge Noiraud" <serge.noiraud@bull.net>
To: linux-kernel <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
Content-Type: text/plain
Organization: BTS
Message-Id: <1118823704.10717.129.camel@ibiza.btsn.frna.bull.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-5.1.100mdk 
Date: Wed, 15 Jun 2005 10:21:45 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	I try to compile the nvidia driver for my RT kernel.
It does not work anymore.

I have a great question : Do we need to modify all drivers ?

Isn't there a better way to avoid these modifications ?
for example to have the external fonction the same than non RT kernel.
and have an internal link to the new one or something like that ?

I will have the same problem with PVIC drivers I think.

These drivers are proprietary, so I can't modify them.
I think we should change :

1 - local_irq_* to raw_local_irq_*  : is it always true ?
    I done this and now the driver loads OK
    #  define NV_CLI()                      local_irq_disable()
    #  define NV_SAVE_FLAGS(eflags)         local_save_flags(eflags)
    #  define NV_RESTORE_FLAGS(eflags)      local_irq_restore(eflags)


2 - spin_* to raw_spin_*  ?

   #define nv_init_lock(lock)  spin_lock_init(&lock)
   #define nv_lock(lock)       spin_lock(&lock)
   #define nv_unlock(lock)     spin_unlock(&lock)
   #define nv_lock_irq(lock,flags)    spin_lock_irqsave(&lock,flags)
   #define nv_unlock_irq(lock,flags) spin_unlock_irqrestore(&lock,flags)

and other in two files ... too many modifications.

