Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262609AbTCNARU>; Thu, 13 Mar 2003 19:17:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262774AbTCNARU>; Thu, 13 Mar 2003 19:17:20 -0500
Received: from sdfw-ext.castandcrew.com ([63.113.17.130]:7923 "EHLO
	sddev.castandcrew.com") by vger.kernel.org with ESMTP
	id <S262609AbTCNARS>; Thu, 13 Mar 2003 19:17:18 -0500
From: "Gregory K. Ruiz-Ade" <gregory@castandcrew.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.20 instability on bigmem systems?
Date: Thu, 13 Mar 2003 16:27:22 -0800
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303131627.22572.gregory@castandcrew.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This started out as my asking about random crashes on 2.4.19, but in the 
course of me trying to figure out what was going on, I got to experience 
first-hand the increadibly poor performance of 2.4.x (notably 2.4.20) on a 
system with >4GB of memory (8GB).

So, I'm looking for a solution, preferrably a set of patches, to help with 
the problems described below.

On Monday, I installed a 2.4.20 kernel on our Dell PowerEdge 6600.  This 
machine is configured as follows:

	4x 1.6Ghz Xeon CPUs
	8GB RAM
	Built-in:
		ATI Rage 128 graphics
		dual Broadcomm Gigabit Ethernet
		serial/parallel/usb
		Adaptec SCSI
	Dell PERC3/DC (AMI/LSI MegaRAID) dual-channel

The kernel was built from the linux-2.4.20.tar.bz2 from kernel.org, and 
patched with only the lvm-1.0.7 and linux-2.4.20 VFS locking patches from 
Sistina's LVM-1.0.7 package.

The primary problem:  Whenever any process (or set of processes) initiates 
intensive disk I/O, the system grinds to a halt, kswapd and kupdated 
consume upwards of 40% to 60% CPU each, and system load averages can jump 
upwards of 21.00.  The problem can be replicated with a simple find command 
("find / -print" seems to do it nicely).

I have had two rather painful nights dealing with this (Monday and Tuesday 
nights).  Luckily, I have a serial null-modem cable rigged up between the 
troubled server and another server, and was able to capture all the info 
from the Magic Sysrq commands that I could.

Full details are at http://castandcrew.com/~gregory/lkmlstuff/burpr/2.4.20

I've included the kernel config, the kernel and initrd images, the system 
map file, output from "ps auxfww" and a couple screen scrapings from top, 
and captures from magic sysrq commands from both crashes.

I had problems like this with 2.4.19, and was directed to apply a patch to 
inode.c, which appears to be part of a patch set for 2.4.19pre9aa2.  I've 
archived it at:
 
http://castandcrew.com/~gregory/lkmlstuff/burpr/2.4.19/patches/10_inode-highmem-2

For 2.4.19, this solves _most_ of the stability issues, but I still have to 
work with the LVM people and possibly whomever is responsible for the VM in 
2.4.19/2.4.20 to track down some kernel oopses (possibly a seperate 
problem.)

I will happily provide whatever other information is needed, though my 
opportunities to test things on the machine in question is limited by the 
fact that it's a production server.

Thanks in advance,
Gregory

-- 
Gregory K. Ruiz-Ade <gregory@castandcrew.com>
Sr. Systems Administrator
Cast & Crew Entertainment Services, Inc.

