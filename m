Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261380AbSIWUyH>; Mon, 23 Sep 2002 16:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261384AbSIWUyH>; Mon, 23 Sep 2002 16:54:07 -0400
Received: from fep06-svc.mail.telepac.pt ([194.65.5.211]:7393 "EHLO
	fep06-svc.mail.telepac.pt") by vger.kernel.org with ESMTP
	id <S261380AbSIWUyG>; Mon, 23 Sep 2002 16:54:06 -0400
Date: Mon, 23 Sep 2002 21:49:17 +0100
From: Nuno Monteiro <nuno@itsari.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Sleeping function called from illegal context at slab.c:1378
Message-ID: <20020923204916.GA915@hobbes.itsari.int>
References: <3D8F5DB2.A3E36E16@digeo.com> <1032811220.28332.24.camel@spc9.esa.lanl.gov> <3D8F77B4.A8B9DDC4@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <3D8F77B4.A8B9DDC4@digeo.com>; from akpm@digeo.com on Mon, Sep 23, 2002 at 21:21:08 +0100
X-Mailer: Balsa 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.09.02 21:21 Andrew Morton wrote:

<snip snip>

I got two more. Its 2.5.38-mm2 too. Just thought I'd throw them in:

Sleeping function called from illegal context at slab.c:1378
c2e73f6c c0110251 c020b800 c020faf0 00000562 000001d0 c0129080 c020faf0
        00000562 00000060 00000008 0000012c c11e3560 c010ac77 00000080 
000001d0
        c2e72000 00000000 0000012c bffff948 00000000 c0106ff7 00000060 
00000008
Call Trace: [<c0110251>] [<c0129080>] [<c010ac77>] [<c0106ff7>]

Trace; c0110251 <__might_sleep+55/64>
Trace; c0129080 <kmalloc+4c/130>
Trace; c010ac77 <sys_ioperm+7f/124>
Trace; c0106ff7 <syscall_call+7/b>

this one happens right after boot, it appears on dmesg right after the 
ethernet driver being loaded (modular, ne2k-pci), but thats probably not 
whats triggering it anyway.

-------------------------------------------

Sleeping function called from illegal context at page_alloc.c:326
c3919eb4 c0110251 c020b800 c0210500 00000146 00000000 c012ba45 c0210500
        00000146 00000000 000001d0 c3eef340 c391fca8 00007fff 000001d0 
ffffffff
        c012bc60 00000000 c3919f68 c0143cb7 c11bfbc0 c391fc00 00000000 
c3919f68
Call Trace: [<c0110251>] [<c012ba45>] [<c012bc60>] [<c0143cb7>] 
[<c4b28deb>]
    [<c0143ec5>] [<c0144342>] [<c0143707>] [<c0106ff7>]

Trace; c0110251 <__might_sleep+55/64>
Trace; c012ba45 <__alloc_pages+25/218>
Trace; c012bc60 <__get_free_pages+28/78>
Trace; c0143cb7 <__pollwait+33/98>
Trace; c4b28deb <[snd-pcm-oss]snd_pcm_oss_poll+47/108>
Trace; c0143ec5 <do_select+101/210>
Trace; c0144342 <sys_select+346/4a0>
Trace; c0143707 <sys_ioctl+23b/294>
Trace; c0106ff7 <syscall_call+7/b>


I got literally hundreds of this last one -- the whole dmesg buffer is 
filled with them. They go on at furious rate while playing mp3.



		Nuno
