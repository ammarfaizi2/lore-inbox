Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750815AbVLYKrx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbVLYKrx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Dec 2005 05:47:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbVLYKrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Dec 2005 05:47:53 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:40361 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750815AbVLYKrx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Dec 2005 05:47:53 -0500
Date: Sun, 25 Dec 2005 11:47:50 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [solved] 2.6.15-rc5-rt4 fails to compile
In-Reply-To: <Pine.LNX.4.61.0512251041070.27576@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.61.0512251144540.14202@yvahk01.tjqt.qr>
References: <20051222231153.GA4316@localhost.localdomain>
 <Pine.LNX.4.61.0512251041070.27576@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>CONFIG_RWSEM_GENERIC_SPINLOCK is always y when PREEMPT_RT=y, but (see 
>linux/rwsem.h) in this case, <linux/rwsem-semaphore.h> is included, which 
>lacks macros like RWSEM_ACTIVE_BIAS used in lib/rwsem.c.

Hm this is the same as the other "2.6.15-rc5-rt4 fails to compile". rwsem.c 
should not even be in there.
Is this a Kconfig bug then?

config RWSEM_GENERIC_SPINLOCK
        bool
        depends on M386 || PREEMPT_RT
        default y
config RWSEM_XCHGADD_ALGORITHM
        bool
        default y if !RWSEM_GENERIC_SPINLOCK

PREEMPT_RT=y, but the .config file has RWSEM_XCHGADD_ALGORITHM=y!
Maybe the "default y if !RWSEM..." is not evaluated and we need something 
like this?

	default y if !RWSEM_GENERIC_SPINLOCK
	default n if RWSEM_GENERIC_SPINLOCK


Jan Engelhardt
-- 
