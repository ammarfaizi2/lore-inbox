Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262901AbVCDM2j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262901AbVCDM2j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 07:28:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262866AbVCDM04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 07:26:56 -0500
Received: from mailfe07.swip.net ([212.247.154.193]:39369 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S262901AbVCDMXT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 07:23:19 -0500
X-T2-Posting-ID: icQHdNe7aEavrnKIz+aKnQ==
Subject: Re: Strange crashes of kernel v2.6.11
From: Alexander Nyberg <alexn@dsv.su.se>
To: Steffen Michalke <StMichalke@web.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1109936036.6712.8.camel@pinky.local>
References: <1109787428.6828.14.camel@pinky.local>
	 <1109799292.15072.9.camel@boxen>  <1109936036.6712.8.camel@pinky.local>
Content-Type: text/plain
Date: Fri, 04 Mar 2005 13:23:13 +0100
Message-Id: <1109938993.2285.13.camel@boxen>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > I recently upgraded from linux kernel v2.6.10 to v2.6.11.
> > > Some programs like evolution 2.0 and leafnode2 crash the whole system
> > > immediatedly now.
> > 
> > You mean when you run evolution the box hangs up completely? (you can't
> > kill X, switch to another console etc.)
> 
> Thank you for your hints.
> 
> When I looked into that problem recently, I remarked that the system
> does not actually crash but is locked totally:
> 
> I use the device-mapper modules for encrypting files (loopback devices
> with aes-i586-encryption). They can be set up in the usual manner, but
> filesystem operations now lock the accessing processes, which cannot be
> killed afterwards.
> If the kernel has been compiled with preemption the system slows down
> considerably after those operations; enabling prempting The Big Kernel
> Lock locks the whole system at filesystem access (that looked like a
> system crash). That's why I could not find any messages in the logs.
>
> If I use a non-preemptive v2.6.11-kernel (vanilla, by the way) the
> system keeps on running the normal way, but every process which tries to
> work with files in device-mapped directories is unkillable locked.
> 
> It seems to be a problem with the dm-*- or loop-modules.

Ok, let's try without preempt. Under the kernel config make sure you
select the following:
kernel hacking => kernel debugging => magic sysrq key

Also increase the kernel log buffer at, set it to 17 just to be safe
general setup => kernel log buffer size

Do what you do so that the processes become unkillable, then press 
AltGr+SysRq+t  2-3 times and send the dmesg over here.
(sysrq normally being on the same key as 'print screen', at least on my
keyboards).

This should tell us what is going on.

Thanks!

