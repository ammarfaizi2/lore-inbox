Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262500AbTCEFWT>; Wed, 5 Mar 2003 00:22:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263039AbTCEFWT>; Wed, 5 Mar 2003 00:22:19 -0500
Received: from franka.aracnet.com ([216.99.193.44]:7876 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262500AbTCEFWS>; Wed, 5 Mar 2003 00:22:18 -0500
Date: Tue, 04 Mar 2003 21:32:45 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 439] New: 2.5.63-bk5-7 IDE disk hangs with multiple disks 
Message-ID: <140840000.1046842365@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=439

           Summary: 2.5.63-bk5-7 IDE disk hangs with multiple disks
    Kernel Version: 2.5.63-bk7
            Status: NEW
          Severity: normal
             Owner: alan@lxorguk.ukuu.org.uk
         Submitter: adam@yggdrasil.com


Hardware Environment: At least two IDE hard disks
Software Environment: linux-2.5.63-bk7
Problem Description:


	If I do "dd if=/dev/zero of=/dev/discs/discN/disc bs=65536"
under linux-2.5.63-bk5 or bk7, dd seems to write to the disk for
a couple of seconds and then hangs.  Oddly, sync will return, but
the process remains stuck in the "D" state and an attempt to strace
the process will hang strace (the strace process can then be killed,
but not the original dd process).

	I have also observed this with other block sizes.  However,
on one of the computers that I tried, a dd with a transfer size of
512 bytes seemed to go on indefinitely (actually, I only let it run
for about a minute, and the computer had 2GB of RAM), but the disk
activity light turned off after about a second, and would not even
flash on when I did a "sync", at least as far as I could tell.

	Also on this system, if I pull a big rsync, the rsync will
hang in a "D" state after transfer about a megabyte if and only if
there is a second IDE disk.  The second disk in this case is on a
different IDE cable, but the same controller.  I have observed this
with three different models of Maxtor IDE hard drives on two different
P4 motherboards from different manufacturers, but both with Via
chipsets (sorry for so much similarity between the two cases).

	I am using IDE in default pio mode because of problems with
IDE modules that I experienced about a month ago (loading the
appropriate DMA-based IDE module would immediately result in a kernel
crash of some kind, but I haven't tried this recently).

	I will investigate this further after I've upgraded to 2.5.64,
but that will probably be tomorrow, so I thought I ought to report
this in the meantime.

Steps to reproduce:

	Let's assume that you have a disk that you want to erase at
/dev/discs/disc1/disc (you must have at least two disks in the system).
You would do:

	dd if=/dev/zero of=/dev/discs/discs1/disc bs=65536

