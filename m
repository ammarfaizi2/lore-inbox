Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290946AbSBLRfA>; Tue, 12 Feb 2002 12:35:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290968AbSBLRen>; Tue, 12 Feb 2002 12:34:43 -0500
Received: from [203.199.93.15] ([203.199.93.15]:43273 "EHLO
	WS0005.indiatimes.com") by vger.kernel.org with ESMTP
	id <S290946AbSBLRea>; Tue, 12 Feb 2002 12:34:30 -0500
From: "prodyuth" <prodyuth@indiatimes.com>
Message-Id: <200202121720.WAA24238@WS0005.indiatimes.com>
To: <linux-kernel@vger.kernel.org>
Reply-To: "prodyuth" <prodyuth@indiatimes.com>
Subject: Accessing memory above linux kernel load address
Date: Tue, 12 Feb 2002 22:47:49 +0530
X-URL: http://indiatimes.com
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I am running linux on a MIPS board that has 16Mb of memory. The memory map starts from 0x8000 0000 to 0x8100 0000 ( 16MB . This space is KSEG0 in MIPS terminology)

I use a bootloader to bring up the linux kernel. The boot loader sits in address 0x8020 0000 to 0x8040 0000. The bootloader loads the Linux Kernel in physical address 0x8090 0000.

I have setup the RAM space available for Linux kernel as 16MB, starting from PAGE_OFFSET (0x8000 0000). But since the kernel is loaded at 0x8090 0000 it is unable to access the region which the bootloader was using earlier. (0x8000 0000 to 0x8090 0000) after the Linux kernel is up and running. How do I access that region?

I tried to open ("/dev/kmem") after the Linux kernel came up. When I did a read on /dev/kmem after opening it, the linux kernel just hanged.

When I did an lseek to 0x200000 and then tried to read /dev/kmem, the kernel crashed. 

I did an lseek to 0x200000 because I want to access the memory region starting from 0x80200000.

The memory map is drawn here for clarification.



-------------------------  <--- Address 0x8000 0000 
|    Bootloader memory  |   
-------------------------  <--- Address 0x8090 0000

|  Linux kernel memory  |

------------------------   <---  Address 0x8100 0000



I cannot change the memory map.



Any pointers to help me will be greatly appreciated.



Thanks & regards,

Prodyut.






Get Your Private, Free E-mail from Indiatimes at http://email.indiatimes.com

 Buy Music, Video, CD-ROM, Audio-Books and Music Accessories from http://www.planetm.co.in

