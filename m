Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261491AbVCWKRZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261491AbVCWKRZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 05:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261496AbVCWKRZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 05:17:25 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:41685 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261491AbVCWKRV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 05:17:21 -0500
Date: Wed, 23 Mar 2005 11:17:06 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Jim Carter <jimc@math.ucla.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Disc driver is module, software suspend fails
Message-ID: <20050323101706.GB1407@elf.ucw.cz>
References: <Pine.LNX.4.61.0503222212210.7671@xena.cft.ca.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0503222212210.7671@xena.cft.ca.us>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Distro:		SuSE Linux 9.2
> Kernel:		2.6.8 (kernel-default-2.6.8-24.11), also 2.6.11.5
> Hardware:	Dell Inspiron 6000d, Intel Pentium-M, 915PM chipset,
> 		disc is Fujitsu MHT2040AH, SATA via ata_piix driver
> Kernel cmdline:	root=/dev/sda3 vga=0x317 selinux=0 resume=/dev/sda5 \
> 		desktop elevator=as showopts
> 
> I have the same symptoms as seen in numerous complaints on the web: I do
> "echo disk > /sys/power/state" or run /sbin/swsusp or powersave -U. The
> kernel suspends all the way, then immediately wakes up, having
> accomplished nothing.  On 2.6.11.5 I can read an error message: "swsusp:
> FATAL: cannot find swap device, try swapon -a!"  Yes, the swap device is
> recognized in /proc/swaps.
> 
> I put some printk's into 2.6.11.5 and found out the reason for this
> behavior: in kernel/power/swsusp.c, static resume_device == 0.  The
> reason it's 0 is that swsusp_read uses name_to_dev_t to interpret
> resume=/dev/sda5, a bogus block device name.  The reason it's bogus
> is
...
> So I'm hoping someone has an idea how to make software_resume happen
> _after_ the initrd has been run and its modules are in place, which
> might make it into whatever kernel is being used in SuSE 9.3.

This is WONTFIX for 2.6.11, but you can be pretty sure it is going to
be fixed for SuSE 9.3, and patch is already in 2.6.12-rc1. Feel free
to betatest SuSE 9.3 ;-).
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
