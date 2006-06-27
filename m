Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932078AbWF0Fwc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbWF0Fwc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 01:52:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932095AbWF0Fwc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 01:52:32 -0400
Received: from www.tglx.de ([213.239.205.147]:60866 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S932078AbWF0Fwb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 01:52:31 -0400
Subject: Re: 2.6.17-mm2 hrtimer code wedges at boot?
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Valdis.Kletnieks@vt.edu
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200606270212.k5R2CIvh005395@turing-police.cc.vt.edu>
References: <20060624061914.202fbfb5.akpm@osdl.org>
	 <200606262141.k5QLf7wi004164@turing-police.cc.vt.edu>
	 <1151364429.25491.462.camel@localhost.localdomain>
	 <200606270212.k5R2CIvh005395@turing-police.cc.vt.edu>
Content-Type: text/plain
Date: Tue, 27 Jun 2006 07:54:25 +0200
Message-Id: <1151387665.25491.475.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-26 at 22:12 -0400, Valdis.Kletnieks@vt.edu wrote:
> On Tue, 27 Jun 2006 01:27:09 +0200, Thomas Gleixner said:
> > On Mon, 2006-06-26 at 17:41 -0400, Valdis.Kletnieks@vt.edu wrote:
> > > On Sat, 24 Jun 2006 06:19:14 PDT, Andrew Morton said:
> > > > 
> > > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.
> 17-mm2/
> > > 
> > > I'm seeing a 2-minute or so hang at system startup, seems to be hrtimer
> > > related.  
> > 
> > hrtimer is not really involved here.
> 
> OK, the fact that it was continually in kernel/hrtimer.c was a red herring? :)

Yup.

> [   24.292902] SELinux: initialized (dev bdev, type bdev), uses genfs_contexts
> [   24.311432] SELinux: initialized (dev rootfs, type rootfs), uses genfs_contexts
> [   24.330082] SELinux: initialized (dev sysfs, type sysfs), uses genfs_contexts
> [   24.351494] audit(1151368041.674:2): policy loaded auid=4294967295
> [   24.370664] audit(1151368041.666:3): avc:  granted  { load_policy } for  pid=1 comm="init" scontext=system_u:system_r:kernel_t:s0 tcontext=system_u:object_r:security_t:s0 tclass=security

<snip>

> [   88.467114]  <c01006c5> kernel_thread_helper+0x5/0xb 
> [   89.913214] Real Time Clock Driver v1.12ac
> [   90.489593] audit(1151368108.794:4): avc:  denied  { dac_override } for  pid=452 comm="dmesg" capability=1 scontext=system_u:system_r:dmesg_t:s0 tcontext=system_u:system_r:dmesg_t:s0 tclass=capability
> 
> And after that, things move along OK.

Hmm, does not help much. Wild guess: Can you turn off CONFIG_RTC and try
again ?

	tglx


