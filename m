Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132558AbRD3J7I>; Mon, 30 Apr 2001 05:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133071AbRD3J66>; Mon, 30 Apr 2001 05:58:58 -0400
Received: from mons.uio.no ([129.240.130.14]:30604 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S132558AbRD3J6l>;
	Mon, 30 Apr 2001 05:58:41 -0400
To: Steffen Persvold <sp@scali.no>
CC: lkml <linux-kernel@vger.kernel.org>,
        "nfs@lists.sourceforge.net" <nfs@lists.sourceforge.net>
Subject: Re: Kernel crash using NFSv3 on 2.4.4
In-Reply-To: <3AED12A4.FA869E84@scali.no>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 30 Apr 2001 11:58:32 +0200
In-Reply-To: Steffen Persvold's message of "Mon, 30 Apr 2001 02:22:12 -0500"
Message-ID: <shsitjmd7zr.fsf@charged.uio.no>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Steffen Persvold <sp@scali.no> writes:

     > Hi all, I have compiled a stock 2.4.4 kernel and applied SGI's
     > kdb patch v1.8. Most of the time this runs just fine, but one
     > time when I tried to copy a file from a NFS server I got a
     > kernel fault. Luckily it jumped right into the debugger and I
     > could to some batcktracing (quite useful!) :

     > Unable to handle kernel paging request at virtual address
     > 414478b1
     >  printing eip:
     > c012c826 *pde = 00000000

     > Entering kdb (current=0xca07a000, pid 971) on processor 0 Oops:
     > Oops due to oops @ 0xc012c826 eax = 0x20000000 ebx = 0xc15e4800
     > ecx = 0x00000000 edx = 0xc1447899 esi = 0x00000000 edi =
     > 0xc14477a0 esp = 0xca07ba98 eip = 0xc012c826 ebp = 0xca07baa4
     > xss = 0x00000018 xcs = 0x00000010 eflags = 0x00010046 xds =
     > 0xc1440018 xes = 0x00000018 origeax = 0xffffffff &regs =
     > 0xca07ba64 [0]kdb> bt
     >     EBP EIP Function(args)
     > 0xca07baa4 0xc012c826 kmem_cache_alloc_batch+0x46 (0xc14477a0,
     > 0x7, 0xcb965260)
     >                                kernel .text 0xc0100000
     >                                0xc012c7e0 0xc012c864
     > 0xca07bad0 0xc012ca8e kmalloc+0x82 (0x13c, 0x7, 0xca4ca040,
     > 0x0)

Looks like the IP layer is trying to allocate too much memory. You
wouldn't have set /proc/sys/net/core/{w,r}mem_{max,default} to some
value greater than 256k?

Cheers,
   Trond
