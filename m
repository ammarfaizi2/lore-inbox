Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316635AbSE0O0V>; Mon, 27 May 2002 10:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316637AbSE0O0V>; Mon, 27 May 2002 10:26:21 -0400
Received: from nick.dcs.qmul.ac.uk ([138.37.88.61]:34782 "EHLO
	nick.dcs.qmul.ac.uk") by vger.kernel.org with ESMTP
	id <S316635AbSE0O0T>; Mon, 27 May 2002 10:26:19 -0400
Date: Mon, 27 May 2002 15:26:18 +0100 (BST)
From: Matt Bernstein <matt@theBachChoir.org.uk>
To: linux-kernel@vger.kernel.org
Subject: VM oops in RH7.3 2.4.18-3
Message-ID: <Pine.LNX.4.44.0205271518270.5065-100000@nick.dcs.qmul.ac.uk>
X-URL: http://www.theBachChoir.org.uk/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-uvscan-result: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a dual Athlon, 1 gig registered ECC DDR RAM, will try 2.4.18-4 but
it doesn't look ext3-related (the only big local filesystem is reiserfs
over s/w raid0).

I do suspect the hardware on this machine. If someone could tell me "that
looks like a bad x", I'd be very grateful. More details on request :-/

Unable to handle kernel paging request at virtual address 0200f82b
 printing eip:
c0137dc0
*pde = 00000000
Oops: 0000
nls_iso8859-1 nls_cp437 vfat fat soundcore nfs tuner tvaudio bttv videodev i2c
CPU:    0
EIP:    0010:[<c0137dc0>]    Not tainted
EFLAGS: 00010206

EIP is at page_remove_rmap [kernel] 0x50 (2.4.18-3)
eax: 0200f827   ebx: c1df9c38   ecx: c1000030   edx: c3a19168
esi: c3a19168   edi: c33bc618   ebp: 3fe37025   esp: c6b87eb0
ds: 0018   es: 0018   ss: 0018
Process crond (pid: 7463, stackpage=c6b87000)
Stack: 00100000 c3a19168 0005a000 c0126ab1 00000020 00000000 42100000 c6b85420
       42000000 00000000 42100000 c6b85420 c011c6e6 00000000 c6b86000 00000000
       00000000 00000000 c6b86000 c6b860b4 00100000 0012c000 42000000 00000001
Call Trace: [<c0126ab1>] do_zap_page_range [kernel] 0x181
[<c011c6e6>] sys_wait4 [kernel] 0x396
[<c0127010>] zap_page_range [kernel] 0x50
[<c01297da>] exit_mmap [kernel] 0xca
[<c0117e36>] mmput [kernel] 0x26
[<c011c183>] do_exit [kernel] 0xb3
[<c011c6e6>] sys_wait4 [kernel] 0x396
[<c0108913>] system_call [kernel] 0x33


Code: 39 70 04 75 0d 53 57 50 e8 a3 02 00 00 83 c4 0c eb 08 89 c7

$ mount
/dev/sda3 on / type ext3 (rw)
none on /proc type proc (rw)
usbdevfs on /proc/bus/usb type usbdevfs (rw)
/dev/sda2 on /boot type ext3 (rw)
none on /dev/pts type devpts (rw,gid=5,mode=620)
/dev/md0 on /export type reiserfs (rw,noatime,notail)
none on /dev/shm type tmpfs (rw)
none on /tmp type tmpfs (rw)

[ + plus some autofs / nfs stuff ]

