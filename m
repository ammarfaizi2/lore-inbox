Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262052AbUCIQ4a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 11:56:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261959AbUCIQ4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 11:56:30 -0500
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:2042 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S261983AbUCIQ4Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 11:56:25 -0500
Content-Type: text/plain;
  charset="CP 1252"
From: Jesse Pollard <jesse@cats-chateau.net>
To: Timothy Miller <miller@techsource.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: HELP: Linux replacement for "DOS diagnostic" station
Date: Tue, 9 Mar 2004 10:56:01 -0600
X-Mailer: KMail [version 1.2]
References: <404CFF03.1090601@techsource.com>
In-Reply-To: <404CFF03.1090601@techsource.com>
MIME-Version: 1.0
Message-Id: <04030910560101.32521@tabby>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 08 March 2004 17:17, Timothy Miller wrote:
> Like many companies that do hardware development (PCI cards, etc.), when
> we here first produce a board, the first things we do is put it into a
> DOS machine and run our diagnostic tools on it.  We're running the DOS
> version that came with Windows 3.11, and we use the Watcom C compiler
> that lets us run our software in protected mode, so we have access to
> 32-bit address space.
>
> Some advantages of this approach:
> - Single-tasking environment, so we can do polling on devices in real-time
> - No memory protection, so we can access all device memory directly
> - No instruction set restrictions, so we can execute I/O instructions
> directly
> - Access to PCI config space (via I/O instructions)
> - The computer boots up in seconds
>
> Disadvantages include:
> - No modern compiler
> - No debugging tools
> - DOS command shell is a lousy working environment
> - Dwindling support for DOS NIC drivers from motherboard manufacturers
>
>
> We are doing some forward-looking thinking about how we're going to
> replace this environment in the not-to-distant future.  We are looking
> at Linux as the environment we want to use.  Some of the features we're
> thinking of include:
>
> - Kernel support for basically nothing but Ethernet, text-mode console,
> and USB (ie. IDE and floppy not necessarily supported).
> - Boot from USB flash dongle.
> - Hand-code init so that services are loaded in parallel
> - Fill the rest of the USB dongle with development tools
> - Put the rest of the tools on NFS.
>
>
> There are a number of issues that we have to cover (such as what
> filesystem to use on the flash and how to make the flash bootable), but
> the biggest concern is that we absolutely MUST have un restricted access
> to physical memory, I/O space, and config space from user-space programs.
>
> So, first of all, we need to make /dev/mem accessible to all users.
> Secondly, we need some mechanism to access I/O and config space, but it
> can be indirect through ioctl.
>
> Is there a driver for Linux which supports I/O and config space access
> for user-space programs in a completely generic way?
>
> Another occurrence is that sometimes, PCI config space on a new device
> is 'broken' and therefore confuses the OS trying to map it.  We'll need
> to be able to override the OS in a way that doesn't interfere with other
> devices.  That is, we need to (a) indicate which device NOT to map, (b)
> query which memory areas have been allocated to other devices, and (c)
> program in our own desired physical addresses into config space.
>
> Does anyone have suggestions?
>
> Thanks!

Just a brief one:

I suggest using one of the embeded kernels. For your purpose it has the 
following advantages:
1. no MMU support - allows your applications to poke at ANYTHING.
2. ramdisk support - eliminates the kernel from interfereing with most PCI
tests you can do. (granted, you MIGHT want a system with two PCI busses, one
for the system to use -disk/keyboard/display/network and one for your target 
interface; but I think you can get away from this using an AGP display, the 
keyboard/mouse and ramdisk)
3. minimal system
4. development on another host
5. safty from inevitable crashes/bus hangs...
