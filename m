Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263600AbUA3Les (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 06:34:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263636AbUA3Les
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 06:34:48 -0500
Received: from gizmo06bw.bigpond.com ([144.140.70.16]:46002 "HELO
	gizmo06bw.bigpond.com") by vger.kernel.org with SMTP
	id S263600AbUA3Lep (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 06:34:45 -0500
Message-ID: <401A4150.684A6C76@eyal.emu.id.au>
Date: Fri, 30 Jan 2004 22:34:40 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.25-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
CC: dbrownell@users.sourceforge.net, linux-kernel@vger.kernel.org,
       greg@kroah.com, linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.4.25-pre8: usb/gadget/file_storage.c doesn't compile with gcc 2.95 
 [patch]
References: <Pine.LNX.4.58L.0401291833160.1304@logos.cnet> <20040130024350.GD3004@fs.tum.de>
Content-Type: multipart/mixed;
 boundary="------------07E8BAE05395B8A1F9944F01"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------07E8BAE05395B8A1F9944F01
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Adrian Bunk wrote:
> 
> On Thu, Jan 29, 2004 at 06:41:52PM -0200, Marcelo Tosatti wrote:
> >...
> > Summary of changes from v2.4.25-pre7 to v2.4.25-pre8
> > ============================================
> >...
> > David Brownell:
> >...
> >   o USB gadget: add file_storage gadget driver [2/7]
> >...
> 
> I'm getting the following compile error with gcc 2.95:
> 
> <--  snip  -->
> 
> ...
> gcc-2.95 -D__KERNEL__
> -I/home/bunk/linux/kernel-2.4/linux-2.4.25-pre8-modular/include -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
> -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=k6
> -DMODULE -DMODVERSIONS -include
> /home/bunk/linux/kernel-2.4/linux-2.4.25-pre8-modular/include/linux/modversions.h
> -nostdinc -iwithprefix include -DKBUILD_BASENAME=file_storage  -c -o
> file_storage.o file_storage.c
> file_storage.c: In function `received_cbi_adsc':
> file_storage.c:1385: parse error before `;'
> file_storage.c: In function `check_parameters':
> file_storage.c:3767: parse error before `;'
> file_storage.c: In function `fsg_bind':
> file_storage.c:3912: parse error before `;'
> make[2]: *** [file_storage.o] Error 1
> make[2]: Leaving directory
> `/home/bunk/linux/kernel-2.4/linux-2.4.25-pre8-modular/drivers/usb/gadget'

One way to get past this problem, at least for Debian (gcc 2.95.4).

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
--------------07E8BAE05395B8A1F9944F01
Content-Type: text/plain; charset=us-ascii;
 name="2.4.25-pre8.file_storage.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.25-pre8.file_storage.patch"

--- linux/drivers/usb/gadget/file_storage.c.orig	Fri Jan 30 20:35:35 2004
+++ linux/drivers/usb/gadget/file_storage.c	Fri Jan 30 21:13:10 2004
@@ -3909,7 +3909,7 @@
 		goto out;
 	fsg->thread_pid = rc;
 
-	INFO(fsg, DRIVER_DESC ", version: " DRIVER_VERSION "\n");
+	INFO(fsg, DRIVER_DESC ", version: " DRIVER_VERSION "\n", "");
 	INFO(fsg, "Number of LUNs=%d\n", fsg->nluns);
 
 	pathbuf = kmalloc(PATH_MAX, GFP_KERNEL);

--------------07E8BAE05395B8A1F9944F01--

