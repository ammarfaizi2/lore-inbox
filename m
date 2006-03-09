Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751009AbWCIULI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751009AbWCIULI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 15:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751305AbWCIULI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 15:11:08 -0500
Received: from a34-mta02.direcpc.com ([66.82.4.91]:56132 "EHLO
	a34-mta02.direcway.com") by vger.kernel.org with ESMTP
	id S1751009AbWCIULH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 15:11:07 -0500
Date: Thu, 09 Mar 2006 15:10:02 -0500
From: Ben Collins <bcollins@ubuntu.com>
Subject: Re: State of the Linux PCI and PCI Hotplug Subsystems for	2.6.16-rc5
In-reply-to: <Pine.LNX.4.64.0603091137180.18022@g5.osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Tomasz Torcz <zdzichu@irc.pl>, Greg KH <gregkh@suse.de>,
       Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       pcihpd-discuss@lists.sourceforge.net
Message-id: <1141935002.6072.40.camel@grayson>
Organization: Ubuntu
MIME-version: 1.0
X-Mailer: Evolution 2.5.92
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <20060306223545.GA20885@kroah.com>
 <20060308222652.GR4006@stusta.de> <20060308225029.GA26117@suse.de>
 <Pine.LNX.4.64.0603081502350.32577@g5.osdl.org>
 <20060308231851.GA26666@suse.de>
 <Pine.LNX.4.64.0603081528040.32577@g5.osdl.org> <20060309184010.GA4639@irc.pl>
 <Pine.LNX.4.64.0603091137180.18022@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-09 at 11:49 -0800, Linus Torvalds wrote:
> 
> On Thu, 9 Mar 2006, Tomasz Torcz wrote:
> > > 
> > >   "Fedora rawhide kernel stopped booting for a bunch of people, all with 
> > >    686-SMP boxes. I saw it myself too, it hung just after the 'write 
> > >    protecting kernel rodata'.
> > > 
> > 
> >   Ubuntu has similar problem:
> > https://launchpad.net/distros/ubuntu/+source/linux-source-2.6.15/+bug/29601
> >  I believe Ubuntu's 2.6.15 source is vanilla+git patches.
> 
> Interesting. He also apparently boots with "noapic nolapic" on the "386" 
> kernel, but not the "686" kernel. I wonder what the differences in Kubuntu 
> kernels are between 386/686 kernels. Is it _just_ the CPU type? If so, the 
> largest difference is probably just compiler instruction usage/scheduling.
> 
> Ben?

The difference between our 2.6.15 386 and 686 kernels is actually pretty
huge. The 386 is M486, and UP, while our 686 kernel is M686, and SMP.
The SMP is also complicated by our use of the SMP-alternatives patch,
but I believe I had this user test with this disabled (kernel command
line option that leaves all the SMP code intact for testing). It didn't
alter the problem.

So the problem would seem to be narrowed down to between M486 and M686.
Also, we are using gcc 4.0.3, for reference. No special compile options
are added, it's all kbuild generated stuff.

-- 
Ubuntu     - http://www.ubuntu.com/
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
SwissDisk  - http://www.swissdisk.com/

