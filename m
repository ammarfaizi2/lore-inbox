Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277782AbRKIDFF>; Thu, 8 Nov 2001 22:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278807AbRKIDEz>; Thu, 8 Nov 2001 22:04:55 -0500
Received: from f5.law11.hotmail.com ([64.4.17.5]:9477 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S277782AbRKIDEw>;
	Thu, 8 Nov 2001 22:04:52 -0500
X-Originating-IP: [208.253.50.100]
From: "Linux Kernel Developer" <linux_developer@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: CPQARRAY driver horribly broken in 2.4.14
Date: Thu, 08 Nov 2001 22:04:46 -0500
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F5uLCTaogxLDp7mvjkO00000742@hotmail.com>
X-OriginalArrivalTime: 09 Nov 2001 03:04:46.0704 (UTC) FILETIME=[49B08700:01C168CB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

     I'm using the cpqarray driver for a Compaq Smart Arrat 3100ES 
controller on a Compaq Proliant 7000.  Today I tried upgrading the kernel to 
2.4.14.  Soon after the upgrade I though about making a small change in the 
kernel however as soon as I tried doing a "make dep" the system oopsed and 
froze.  This repeated itself a couple of times.  Initially I though it may 
have been the ext3 patch which I had tried and I then tried mounting my 
drives as ext2 to see if that fixed the problem.  It didn't.  After writing 
down the oops and doing a ksymoops on it I noticed that the kernel appeared 
to die in the ida interrupt handler (ida is the device name the cpqarray 
driver uses).  Remembering that the cpqarray driver had been upgraded in 
2.4.14 I decided to try downgrading the cpqarray driver.  So I copied the 
cpqarray.[ch], ida_cmd.h, and ida_ioctl.h file from drivers/block from a 
linux 2.4.13-ac8 source directory I had from the previously working kernel.  
I then recompiled the 2.4.14 linux kernel (with ext3 patch) using the 
downgraded cpqarray driver source files.  The resulting kernel now works 
perfectly on this machine.  Even doing a higher stress test with make -j 10 
didn't cause the crash to occur again.  From my investigate I must conclude 
the the cpqarray driver included in the 2.4.14 source tarball must be broken 
somehow.

    Other fact that might be relevent about this machine.  This system has 
1.5 GB of memory and I am using the 4GB high memory option in the kernel.  I 
also included the latest ext3 patch as I needed this after moving away from 
the ac kernels.

     I've attached the oops (typed out by me), the ksymoops output, and my 
kernel configuration file.  If anyone has anymore questions please ask away, 
though I won't have access to this machine again til after the weekend.

_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com/intl.asp

