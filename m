Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288285AbSACTJL>; Thu, 3 Jan 2002 14:09:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287303AbSACTIw>; Thu, 3 Jan 2002 14:08:52 -0500
Received: from smtp-out.Austria.eu.net ([193.154.160.116]:29342 "EHLO
	relay12.austria.eu.net") by vger.kernel.org with ESMTP
	id <S287400AbSACTIk>; Thu, 3 Jan 2002 14:08:40 -0500
Subject: [Patch] Corrected, sysrq-show-output, kernel 2.4.17
From: Harald Holzer <harald.holzer@eunet.at>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-+I0Xb2D5BMkfuuGwb87o"
X-Mailer: Evolution/1.0 (Preview Release)
Date: 03 Jan 2002 20:06:14 +0100
Message-Id: <1010084774.12670.21.camel@hh2.hhhome.at>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+I0Xb2D5BMkfuuGwb87o
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Sorry, i forgot a pair of {} in sysrq_handle_showregs.

I should stop programming python ;-)

Harald Holzer

-----Forwarded Message-----

From: Helge Deller <deller@gmx.de>
To: Harald Holzer <harald.holzer@eunet.at>
Subject: Re: [Patch] sysrq-show-output, kernel 2.4.17
Date: 03 Jan 2002 08:45:36 +0100

On Thursday 03 January 2002 00:25, Harald Holzer wrote:
> Sysrq-m didnt show memory information on the serial console.
>
> This patch sets the console_loglevel to 7 before it calls show_mem,
> show_regs and show_state, to get the output.
>
> Harald Holzer

static void sysrq_handle_showregs(int key, struct pt_regs *pt_regs,
                 struct kbd_struct *kbd, struct tty_struct *tty) {
 +       int orig_loglevel;
 +
         if (pt_regs)
 +               orig_loglevel = console_loglevel;
 +               console_loglevel = 7;
                 show_regs(pt_regs);
 +               console_loglevel = orig_loglevel;
 +
  }

Hi Harald,
I think you misssed a pair of { ... } here...

Helge



--=-+I0Xb2D5BMkfuuGwb87o
Content-Disposition: attachment; filename=sysrq-show-output.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=ANSI_X3.4-1968

--- linux-2.4.17/drivers/char/sysrq.c	Thu Jan  3 18:28:59 2002
+++ linux/drivers/char/sysrq.c	Thu Jan  3 18:29:54 2002
@@ -246,8 +246,14 @@
=20
 static void sysrq_handle_showregs(int key, struct pt_regs *pt_regs,
 		struct kbd_struct *kbd, struct tty_struct *tty) {
-	if (pt_regs)
+	int orig_loglevel;
+
+	if (pt_regs) {
+		orig_loglevel =3D console_loglevel;
+		console_loglevel =3D 7;
 		show_regs(pt_regs);
+		console_loglevel =3D orig_loglevel;
+	}
 }
 static struct sysrq_key_op sysrq_showregs_op =3D {
 	handler:	sysrq_handle_showregs,
@@ -258,7 +264,12 @@
=20
 static void sysrq_handle_showstate(int key, struct pt_regs *pt_regs,
 		struct kbd_struct *kbd, struct tty_struct *tty) {
+	int orig_loglevel;
+
+	orig_loglevel =3D console_loglevel;
+	console_loglevel =3D 7;
 	show_state();
+	console_loglevel =3D orig_loglevel;
 }
 static struct sysrq_key_op sysrq_showstate_op =3D {
 	handler:	sysrq_handle_showstate,
@@ -269,7 +280,12 @@
=20
 static void sysrq_handle_showmem(int key, struct pt_regs *pt_regs,
 		struct kbd_struct *kbd, struct tty_struct *tty) {
+	int orig_loglevel;
+
+	orig_loglevel =3D console_loglevel;
+	console_loglevel =3D 7;
 	show_mem();
+	console_loglevel =3D orig_loglevel;
 }
 static struct sysrq_key_op sysrq_showmem_op =3D {
 	handler:	sysrq_handle_showmem,

--=-+I0Xb2D5BMkfuuGwb87o--
