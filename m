Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267341AbUGNJiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267341AbUGNJiZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 05:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267342AbUGNJiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 05:38:25 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:52228 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S267341AbUGNJiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 05:38:11 -0400
Subject: Re: Can't compile sg.c 2.6.8-rc1-mm1
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <30a4d01b04071401457267defa@mail.gmail.com>
References: <30a4d01b04071401457267defa@mail.gmail.com>
Content-Type: multipart/mixed; boundary="=-o4iXvaMgTjppUxIgFy7e"
Date: Wed, 14 Jul 2004 11:37:34 +0200
Message-Id: <1089797854.1740.2.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.2 (1.5.9.2-1) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-o4iXvaMgTjppUxIgFy7e
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2004-07-14 at 11:45 +0300, Genady Okrain wrote:
> I am using gcc-3.4.1
> 
>   CC [M]  drivers/scsi/sg.o
> drivers/scsi/sg.c: In function `sg_ioctl':
> drivers/scsi/sg.c:209: sorry, unimplemented: inlining failed in call
> to 'sg_jif_to_ms': function body not available
> drivers/scsi/sg.c:930: sorry, unimplemented: called from here
> make[2]: *** [drivers/scsi/sg.o] Error 1
> make[1]: *** [drivers/scsi] Error 2
> make: *** [drivers] Error 2
> 

Also, the following patch is needed for "make menuconfig" to work with
GCC 3.5.

--=-o4iXvaMgTjppUxIgFy7e
Content-Disposition: attachment; filename=gcc-35-fix-mconf.c.patch
Content-Type: text/x-patch; name=gcc-35-fix-mconf.c.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -uNr linux-2.6.7-mm7/scripts/kconfig/mconf.c linux-2.6.7-mm7-gcc35/scripts/kconfig/mconf.c
--- linux-2.6.7-mm7/scripts/kconfig/mconf.c	2004-06-16 07:19:02.000000000 +0200
+++ linux-2.6.7-mm7-gcc35/scripts/kconfig/mconf.c	2004-07-09 10:10:07.000000000 +0200
@@ -88,7 +88,7 @@
 static int indent;
 static struct termios ios_org;
 static int rows, cols;
-static struct menu *current_menu;
+struct menu *current_menu;
 static int child_count;
 static int do_resize;
 static int single_menu_mode;

--=-o4iXvaMgTjppUxIgFy7e--

