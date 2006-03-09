Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751124AbWCITx7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbWCITx7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 14:53:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750928AbWCITx7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 14:53:59 -0500
Received: from smtp.osdl.org ([65.172.181.4]:39553 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751116AbWCITx7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 14:53:59 -0500
Date: Thu, 9 Mar 2006 11:49:55 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Tomasz Torcz <zdzichu@irc.pl>
cc: Greg KH <gregkh@suse.de>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       pcihpd-discuss@lists.sourceforge.net,
       Ben Collins <ben.collins@ubuntu.com>
Subject: Re: State of the Linux PCI and PCI Hotplug Subsystems for 2.6.16-rc5
In-Reply-To: <20060309184010.GA4639@irc.pl>
Message-ID: <Pine.LNX.4.64.0603091137180.18022@g5.osdl.org>
References: <20060306223545.GA20885@kroah.com> <20060308222652.GR4006@stusta.de>
 <20060308225029.GA26117@suse.de> <Pine.LNX.4.64.0603081502350.32577@g5.osdl.org>
 <20060308231851.GA26666@suse.de> <Pine.LNX.4.64.0603081528040.32577@g5.osdl.org>
 <20060309184010.GA4639@irc.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 9 Mar 2006, Tomasz Torcz wrote:
> > 
> >   "Fedora rawhide kernel stopped booting for a bunch of people, all with 
> >    686-SMP boxes. I saw it myself too, it hung just after the 'write 
> >    protecting kernel rodata'.
> > 
> 
>   Ubuntu has similar problem:
> https://launchpad.net/distros/ubuntu/+source/linux-source-2.6.15/+bug/29601
>  I believe Ubuntu's 2.6.15 source is vanilla+git patches.

Interesting. He also apparently boots with "noapic nolapic" on the "386" 
kernel, but not the "686" kernel. I wonder what the differences in Kubuntu 
kernels are between 386/686 kernels. Is it _just_ the CPU type? If so, the 
largest difference is probably just compiler instruction usage/scheduling.

Ben?

Also, the 686 one apparently boots with "acpi=off" or "pci=noacpi" 
(although then some interrupts don't work, which I guess shouldn't be a 
huge surprise). I do wonder if maybe we have a miscompile issue.

There are a few (but really not very many) other differences between M386 
and M686 kernels too. Notably CMPXCHG/XADD isn't used unconditionally on 
the M386 kernel. That impacts the new mutex code (it adds a few 
conditional jumps, but still ends up using XADD since the CPU actually 
supports it).

		Linus
