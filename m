Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261761AbSJMXEV>; Sun, 13 Oct 2002 19:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261778AbSJMXEV>; Sun, 13 Oct 2002 19:04:21 -0400
Received: from h-64-105-34-19.SNVACAID.covad.net ([64.105.34.19]:1667 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S261761AbSJMXEU>; Sun, 13 Oct 2002 19:04:20 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sun, 13 Oct 2002 16:10:01 -0700
Message-Id: <200210132310.QAA01044@adam.yggdrasil.com>
To: rmk@arm.linux.org.uk
Subject: Re: Patch: linux-2.5.42/kernel/sys.c - warm reboot should not suspend devices
Cc: ebiederm@xmission.com, eblade@blackmagik.dynup.net,
       linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King writes:
>x86, I believe, is one example of such a platform that can leave PCI
>devices jabbering over a warm reboot.

	The standards on pcisig.com are apparently proprietary, so I'm
afraid I can only quote a proprietary book I have handy:

	Reset Signal (RST#):

	When asserted, the reset signal forces all PCI configuration
	registers, master and target state machines and output drivers to an
	initialized state.  RST# may be asserted or deasserted asynchronously
	to the PCI CLK edge.  The assertion of RST# also initializes other,
	device-specific functions, but this subject is beyond the scope of the
	PCI specification.  All PCI output signals must be driver to their
	bening states.  In general, this means they must be tri-stated [...]
	
		Chapter 4, page 37
		_PCI System Architecture, 4th Edition_
		Tom Shanley and Don Anderson


	So, you must be talking about a PC that does not ground RST#
during a warm reboot or out of spec (according to this book) PCI devices,
which would not be specific to x86 unless we're talking about motherboard
chipset devices.

	I understand the benefits of being conservative, but let's not
be taken in by urban legend, or, more likely, some quirkly hardware
that we can set a flag for while we can reboot more quickly with most
other hardware.  Anyhow, if you or anyone can give me specifics about
devices jabbering away after reboot, that would be great

	I have no objection to replacing or supplementing the reboot
notifier chain with a method in struct device_driver, but let's not
overload these methods with ambiguous semantics.  I do not want to
call thirty functions that primarily return memory to various memory
allocators, mark a bunch of inodes as invalid, and otherwise arrange
things so that the kernel can smoothly continue to run user level
programs when, in fact, we just want to pull the reset line on the
computer.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

	
