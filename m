Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261397AbUCHXET (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 18:04:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261184AbUCHXET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 18:04:19 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:24324 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S261397AbUCHXEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 18:04:08 -0500
Message-ID: <404CFF03.1090601@techsource.com>
Date: Mon, 08 Mar 2004 18:17:23 -0500
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: HELP: Linux replacement for "DOS diagnostic" station
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Like many companies that do hardware development (PCI cards, etc.), when 
we here first produce a board, the first things we do is put it into a 
DOS machine and run our diagnostic tools on it.  We're running the DOS 
version that came with Windows 3.11, and we use the Watcom C compiler 
that lets us run our software in protected mode, so we have access to 
32-bit address space.

Some advantages of this approach:
- Single-tasking environment, so we can do polling on devices in real-time
- No memory protection, so we can access all device memory directly
- No instruction set restrictions, so we can execute I/O instructions 
directly
- Access to PCI config space (via I/O instructions)
- The computer boots up in seconds

Disadvantages include:
- No modern compiler
- No debugging tools
- DOS command shell is a lousy working environment
- Dwindling support for DOS NIC drivers from motherboard manufacturers


We are doing some forward-looking thinking about how we're going to 
replace this environment in the not-to-distant future.  We are looking 
at Linux as the environment we want to use.  Some of the features we're 
thinking of include:

- Kernel support for basically nothing but Ethernet, text-mode console, 
and USB (ie. IDE and floppy not necessarily supported).
- Boot from USB flash dongle.
- Hand-code init so that services are loaded in parallel
- Fill the rest of the USB dongle with development tools
- Put the rest of the tools on NFS.


There are a number of issues that we have to cover (such as what 
filesystem to use on the flash and how to make the flash bootable), but 
the biggest concern is that we absolutely MUST have un restricted access 
to physical memory, I/O space, and config space from user-space programs.

So, first of all, we need to make /dev/mem accessible to all users. 
Secondly, we need some mechanism to access I/O and config space, but it 
can be indirect through ioctl.

Is there a driver for Linux which supports I/O and config space access 
for user-space programs in a completely generic way?

Another occurrence is that sometimes, PCI config space on a new device 
is 'broken' and therefore confuses the OS trying to map it.  We'll need 
to be able to override the OS in a way that doesn't interfere with other 
devices.  That is, we need to (a) indicate which device NOT to map, (b) 
query which memory areas have been allocated to other devices, and (c) 
program in our own desired physical addresses into config space.

Does anyone have suggestions?

Thanks!

