Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261485AbUCAXfv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 18:35:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261486AbUCAXfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 18:35:51 -0500
Received: from illuminari.org ([65.192.43.17]:5249 "EHLO illuminari.org")
	by vger.kernel.org with ESMTP id S261485AbUCAXfs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 18:35:48 -0500
Date: Mon, 1 Mar 2004 18:49:29 -0500 (EST)
From: Chris Lalancette <clalancette@illuminari.org>
To: linux-kernel@vger.kernel.org
Subject: SunPCi / Intel 21555 drivers
Message-ID: <Pine.LNX.4.44.0403011848490.15323-100000@illuminari.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We are trying to develop a linux driver (and related software) to use a 
SunPCi 3 (or SunPCi 2 or even 1, for that matter) card inside a Linux x86 
box rather than a Solaris/Sparc box.

SunPCi cards are PCI cards developed by Sun (duh) that contain an almost 
fully functional x86 pc. The PCI card has a cpu, ram, northbridge, 
southbridge, serial, parallel, external video, usb, firewire, etc. It 
connects to the PCI bus of the host computer through an Intel 21555 
non-transparent PCI bridge.

On the Solaris side, Sun keeps diskimage files which act as the hard 
drives for the guest OS. There is an additional 1024 bytes at the front of 
the file that contains the CMOS required to boot the system and some other 
(unknown) stuff.

#losetup -o 1024 foo.diskimage /dev/loop0
will give you a loopback mounted drive from one of their files.

The OS running on the guest has Sun provided block device drivers that 
interact with the 21555 to present the files on the host side of the 
bridge as disks. These specialized guest OS drivers allow the guest system 
to run Linux (redhat 9 based installer), DOS, and a number of flavors of 
Windows. Mouse and keyboard also come up through the 21555.

All of this is tied together to act like a hardware virtual machine.
It feels a lot like VMware in some ways. By running the "sunpci" 
application on Solaris, a window pops up with a different OS running 
inside it. When you click on the window, the keyboard device goes through 
the bridge as the guest OS's keyboard. Video comes back down through the 
bridge to an X application running on solaris (unless you use the -v flag 
which tells video to go out the external video on the back of the card 
instead).

We have a PCI bus analyzer from Silicon Control to help figure out what is 
going on on the Solaris side of things. We can also use the "debug" 
program on DOS and "lspci" (and other tools) on Linux on the guest side to 
more easily see what is going on from a hardware standpoint there. We are 
in the beginning stages of developing a Linux driver for the host side.

Has anyone attempted a driver for these cards?
Is there any existing code out there for these cards or for the Intel 
21555 chip? Code for the Intel 21554 (previously DEC) chip would also be 
useful as it was used in SunPCi generations 1 and 2 cards. Any additional 
tools, resources, or suggestions on how to proceed are most welcome.

Thanks in advance,
Dan Sturtevant and Chris Lalancette

