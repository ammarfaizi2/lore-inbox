Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265248AbUGVSMn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265248AbUGVSMn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 14:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267186AbUGVSKR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 14:10:17 -0400
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:20078 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S266894AbUGVSJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 14:09:00 -0400
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
To: Andrew Morton <akpm@osdl.org>
Subject: [patch] Re: Fw: Re: 2.6.7-mm7
Date: Thu, 22 Jul 2004 17:59:13 +0200
User-Agent: KMail/1.5
References: <20040710132558.2de12ca2.akpm@osdl.org>
In-Reply-To: <20040710132558.2de12ca2.akpm@osdl.org>
Cc: diegocg@teleline.es, jdike@addtoit.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <200407221705.49272.blaisorblade_spam@yahoo.it>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_RR+/ATiIDseg1In"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_RR+/ATiIDseg1In
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Alle 22:25, sabato 10 luglio 2004, Andrew Morton ha scritto:
> Begin forwarded message:
>
> Date: Sat, 10 Jul 2004 20:29:49 +0200
> From: Diego Calleja Garc=EDa <diegocg@teleline.es>
> To: jdike@addtoit.com
> Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
> Subject: Re: 2.6.7-mm7
>
> El Thu, 8 Jul 2004 23:50:25 -0700 Andrew Morton <akpm@osdl.org> escribi=
=F3:
> > - Added a big UML update.   Needs work.
>
> Fails to compile here (gcc (GCC) 3.3.4 (Debian 1:3.3.4-3) and
> config "ARCH=3Dum make defconfig")
>
>   CC      arch/um/drivers/stdio_console.o
> arch/um/drivers/stdio_console.c:207: error: conflicting types for
> `console_device' include/linux/console.h:107: error: previous declaration
> of `console_device' make[1]: *** [arch/um/drivers/stdio_console.o] Error 1

Probably something due to a -mm change. I simply renamed the stdio_console.c
console_device (which is static) to um_console_device.

The patch is against vanilla; but since the line numbers in the gcc message
don't match, there is probably some other change in that file. So give it a
check.

Here's the patch (both inline and attached).


In the -mm tree (in this moment) and not in 2.6.7 there is another console_=
device in
include/linux/console.h; so I renamed the UML one (it's static).

=2D--

 uml-linux-2.6.7-paolo/arch/um/drivers/stdio_console.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN arch/um/drivers/stdio_console.c~fix-name-conflict-mm arch/um/driv=
ers/stdio_console.c
=2D-- uml-linux-2.6.7/arch/um/drivers/stdio_console.c~fix-name-conflict-mm	=
2004-07-22 16:54:12.827219496 +0200
+++ uml-linux-2.6.7-paolo/arch/um/drivers/stdio_console.c	2004-07-22 16:55:=
10.785408512 +0200
@@ -203,7 +203,7 @@ static void console_write(struct console
 		up(&line->sem);
 }
=20
=2Dstatic struct tty_driver *console_device(struct console *c, int *index)
+static struct tty_driver *um_console_device(struct console *c, int *index)
 {
 	*index =3D c->index;
 	return console_driver;
@@ -217,7 +217,7 @@ static int console_setup(struct console=20
 static struct console stdiocons =3D {
 	name:		"tty",
 	write:		console_write,
=2D	device:		console_device,
+	device:		um_console_device,
 	setup:		console_setup,
 	flags:		CON_PRINTBUFFER,
 	index:		-1,
_

=2D-=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729





--Boundary-00=_RR+/ATiIDseg1In
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="fix-name-conflict-mm.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="fix-name-conflict-mm.patch"


In the -mm tree (in this moment) and not in 2.6.7 there is another console_device in
include/linux/console.h; so I renamed the UML one (it's static).

---

 uml-linux-2.6.7-paolo/arch/um/drivers/stdio_console.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN arch/um/drivers/stdio_console.c~fix-name-conflict-mm arch/um/drivers/stdio_console.c
--- uml-linux-2.6.7/arch/um/drivers/stdio_console.c~fix-name-conflict-mm	2004-07-22 16:54:12.827219496 +0200
+++ uml-linux-2.6.7-paolo/arch/um/drivers/stdio_console.c	2004-07-22 16:55:10.785408512 +0200
@@ -203,7 +203,7 @@ static void console_write(struct console
 		up(&line->sem);
 }
 
-static struct tty_driver *console_device(struct console *c, int *index)
+static struct tty_driver *um_console_device(struct console *c, int *index)
 {
 	*index = c->index;
 	return console_driver;
@@ -217,7 +217,7 @@ static int console_setup(struct console 
 static struct console stdiocons = {
 	name:		"tty",
 	write:		console_write,
-	device:		console_device,
+	device:		um_console_device,
 	setup:		console_setup,
 	flags:		CON_PRINTBUFFER,
 	index:		-1,
_

--Boundary-00=_RR+/ATiIDseg1In--


