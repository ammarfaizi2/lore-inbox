Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276335AbRJHFB2>; Mon, 8 Oct 2001 01:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276347AbRJHFBT>; Mon, 8 Oct 2001 01:01:19 -0400
Received: from [209.250.53.96] ([209.250.53.96]:51974 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S276335AbRJHFBK>; Mon, 8 Oct 2001 01:01:10 -0400
Date: Mon, 8 Oct 2001 00:01:36 -0500
From: Steven Walter <srwalter@yahoo.com>
To: linux-kernel@vger.kernel.org
Subject: Freeze with 2.4.10 and xcdroast
Message-ID: <20011008000136.A8926@hapablap.dyn.dhs.org>
Mail-Followup-To: Steven Walter <srwalter@yahoo.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Uptime: 11:52pm  up 1 day, 28 min,  0 users,  load average: 1.05, 1.05, 1.01
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Running xcdroast version 0.98alpha9, and going to either "Duplicate CD"
or "Create CD" causes the system to freeze for 45-60 sec.  Numlock
doesn't toggle, but I can drop into kdb.

Attached is a backtrace of whatever is going on, obtained from kdb via
serial console.  Before entering kdb, I was getting floods of messages;
this is the second block.

Relevant information about my system:  Kernel 2.4.10, using ide-scsi
emulation for both of my ATAPI drives, one a DVD-ROM, one a CD burner.
I've had this trouble for a few kernel versions; I don't believe 2.4.9
showed it, but I'm not for sure.

Hopefully the backtrace is enough to get someone started, but if you
need any more information, I'll be glad to help in any way I can.  I am
subscribed to the list.

Thanks.
-- 
-Steven
In a time of universal deceit, telling the truth is a revolutionary act.
			-- George Orwell
Freedom is slavery. Ignorance is strength. War is peace.
			-- George Orwell
Those that would give up a necessary freedom for temporary safety
deserver neither freedom nor safety.
			-- Ben Franklin

kdb> bt
    EBP       EIP         Function(args)
0xc030eb6e 0xc018a353 serial_in+0x13 (0xc0321fa0, 0x5)
                               kernel .text 0xc0100000 0xc018a340 0xc018a370
           0xc018e73b serial_console_write+0x5b (0xc02bf0e0, 0xc030eb40, 0x44)
                               kernel .text 0xc0100000 0xc018e6e0 0xc018e870
           0xc0114c59 __call_console_drivers+0x39 (0x42ee0, 0x42f24)
                               kernel .text 0xc0100000 0xc0114c20 0xc0114c70
           0xc0114cc7 _call_console_drivers+0x57 (0x42ee0, 0x42f24, 0x5)
                               kernel .text 0xc0100000 0xc0114c70 0xc0114cd0
           0xc0114d7d call_console_drivers+0xad (0x42edd, 0x42f24)
                               kernel .text 0xc0100000 0xc0114cd0 0xc0114db0
           0xc0114f8e release_console_sem+0x2e
                               kernel .text 0xc0100000 0xc0114f60 0xc0114fe0
           0xc0114f24 printk+0x104 (0xc02111a0, 0x1, 0x20, 0x0, 0xc012b276)
                               kernel .text 0xc0100000 0xc0114e20 0xc0114f30
           0xc012b610 __alloc_pages+0x1f0
                               kernel .text 0xc0100000 0xc012b420 0xc012b620
           0xc012b276 _alloc_pages+0x16
                               kernel .text 0xc0100000 0xc012b260 0xc012b280
           0xc012b62a __get_free_pages+0xa
                               kernel .text 0xc0100000 0xc012b620 0xc012b640
           0xc01b263f sg_low_malloc+0x14f (0x8000, 0x0, 0x1, 0xc2f7dda4)
                               kernel .text 0xc0100000 0xc01b24f0 0xc01b2680
           0xc01b2703 sg_malloc+0x83 (0xc6eaf000, 0x8000, 0xc2f7ddd4, 0xc2f7ddd8)
                               kernel .text 0xc0100000 0xc01b2680 0xc01b27a0
0xc2f7dddc 0xc01b1657 sg_build_indi+0x177 (0xc6eaf01c, 0xc6eaf000, 0x6400000)
                               kernel .text 0xc0100000 0xc01b14e0 0xc01b1690
           0xc01b1fa5 sg_build_reserve+0x25 (0xc6eaf000, 0x6400000, 0xc6eaf01c)
                               kernel .text 0xc0100000 0xc01b1f80 0xc01b1fd0
           0xc01b044d sg_ioctl+0x64d (0xc19063c0, 0xc1e6d2c0, 0x2275, 0xbffff7b4)
                               kernel .text 0xc0100000 0xc01afe00 0xc01b08a0
           0xc013e417 sys_ioctl+0x167 (0x3, 0x2275, 0xbffff7b4, 0x0, 0x0)
                               kernel .text 0xc0100000 0xc013e2b0 0xc013e430
           0xc0106c6f system_call+0x33
                               kernel .text 0xc0100000 0xc0106c3c 0xc0106c74


__alloc_pages: 2-order allocation failed (gfp=0x20/0) from c012b276
__alloc_pages: 1-order allocation failed (gfp=0x20/0) from c012b276
__alloc_pages: 3-order allocation failed (gfp=0x20/0) from c012b276
__alloc_pages: 3-order allocation failed (gfp=0x20/0) from c012b276
__alloc_pages: 2-order allocation failed (gfp=0x20/0) from c012b276
__alloc_pages: 1-order allocation failed (gfp=0x20/0) from c012b276
__alloc_pages: 3-order allocation failed (gfp=0x20/0) from c012b276
__alloc_pages: 3-order allocation failed (gfp=0x20/0) from c012b276
__alloc_pages: 2-order allocation failed (gfp=0x20/0) from c012b276
