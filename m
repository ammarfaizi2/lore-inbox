Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131626AbRDABJz>; Sat, 31 Mar 2001 20:09:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131660AbRDABJq>; Sat, 31 Mar 2001 20:09:46 -0500
Received: from ppp013.uio.no ([129.240.240.14]:37636 "EHLO ns.froyn.org")
	by vger.kernel.org with ESMTP id <S131626AbRDABJe>;
	Sat, 31 Mar 2001 20:09:34 -0500
Date: Sun, 1 Apr 2001 03:35:03 +0200 (CEST)
From: Ketil Froyn <ketil@froyn.com>
To: <linux-kernel@vger.kernel.org>
Subject: oops in uhci.c running 2.4.2-ac28
Message-ID: <Pine.LNX.4.30.0104010313440.1135-100000@ns.froyn.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

While running kernel 2.4.2-ac28, I switched on spinlock debugging and
verbose BUG() reporting (I always use sysrq). Anyway, while running this I
got an oops after about 2 or 3 minutes running, several times, exact same
place each time, which I traced back to rh_int_timer_do(). This was in
uhci.c (I used CONFIG_USB_UHCI_ALT).

The oops was at [<c01e4d24>], and rh_int_timer_do starts at [<c01e4cac>]
(I'd calculate the offset in the function, but it's too late at night). I
recompiled with usb-uhci.c instead (CONFIG_USB_UHCI), and now I don't get
the oops any more. Using nm vmlinux, I got this stack:

rh_int_timer_do
timer_bh
bh_action
tasklet_hi_action
gcc_compiled. (?)
do_IRQ
default_idle

If more info is needed, I'll be glad to reproduce the bug and copy the
oops here.

Also, the reason I started all this debugging was that I have a freecom
usb CD-RW that stops when I try to access it (the process is in
uninterruptible sleep and never comes out) when I access some files on
some CDs. If anyone knows about this, I'd appreciate any tips. Also, if
anyone has the technical specs on it, I'd even be willing to (try to) look
at it to see if I can spot something with the freecom code... haven't
found anything on www.freecom.com yet.

Linux XXXXXX 2.4.2-ac28 #3 Sun Apr 1 01:16:44 CEST 2001 i686 unknown
Gnu C                  egcs-2.91.66
Gnu make               3.78.1
binutils               2.9.5.0.22
util-linux             2.10f
mount                  2.10f
modutils               2.4.2
e2fsprogs              1.19
pcmcia-cs              3.1.8
PPP                    2.4.0b1
Linux C Library        2.1.3
Dynamic linker (ldd)   2.1.3
Procps                 2.0.6
Net-tools              1.54
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         ne 8390 vfat fat ufs

Kind Regards,
Ketil Froyn

