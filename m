Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263163AbUKTTcf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263163AbUKTTcf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 14:32:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263165AbUKTTcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 14:32:35 -0500
Received: from umail.ru ([195.34.32.101]:2760 "EHLO umail.ru")
	by vger.kernel.org with ESMTP id S263163AbUKTTcd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 14:32:33 -0500
From: "Nikita V. Youshchenko" <yoush@cs.msu.su>
To: linux-kernel@vger.kernel.org
Subject: Strange in_atomic() definition in include/linux/hardirq.h
Date: Sat, 20 Nov 2004 22:32:11 +0300
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200411202232.33431@sercond.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello.

In linux 2.6.9, in include/linux/hardirq.h, if CONFIG_PREEMPT is set, 
isw_atomic() is defines as

#define in_atomic() 
 ((preempt_count() & ~PREEMPT_ACTIVE) != kernel_locked())

preempt_count (after PREEMPT_ACTIVE is cleared out) looks to be an integer 
counter, increased in preempt_disable() and increased in preempt_enable().

kernel_locked() is defined in include/linux/smp_lock.h as
#define kernel_locked()  (current->lock_depth >= 0)

So in in_atomic() definition, integer counter is compared with boolean 
value. Looks like a bug.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBn5vOv3x5OskTLdsRAkr1AJ9lqX/U58rahDFAP7v9dIf30ZzPSACfcU4u
4JzBcBAuqdrghmgeRnWfBds=
=E9Hd
-----END PGP SIGNATURE-----
