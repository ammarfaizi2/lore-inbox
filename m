Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288012AbSABXaR>; Wed, 2 Jan 2002 18:30:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287999AbSABX2m>; Wed, 2 Jan 2002 18:28:42 -0500
Received: from smtp-out.Austria.eu.net ([193.154.160.116]:1961 "EHLO
	relay12.austria.eu.net") by vger.kernel.org with ESMTP
	id <S287169AbSABX12>; Wed, 2 Jan 2002 18:27:28 -0500
Subject: [Patch] sysrq-show-output, kernel 2.4.17
From: Harald Holzer <harald.holzer@eunet.at>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-2jZRuEVLB/+yuggsaJgx"
X-Mailer: Evolution/1.0 (Preview Release)
Date: 03 Jan 2002 00:25:06 +0100
Message-Id: <1010013906.15492.17.camel@hh2.hhhome.at>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-2jZRuEVLB/+yuggsaJgx
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Sysrq-m didnt show memory information on the serial console.

This patch sets the console_loglevel to 7 before it calls show_mem,
show_regs and show_state, to get the output.

Harald Holzer


--=-2jZRuEVLB/+yuggsaJgx
Content-Disposition: attachment; filename=sysrq-show-output.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=ANSI_X3.4-1968

--- linux-2.4.17/drivers/char/sysrq.c	Fri Dec 21 18:41:54 2001
+++ linux/drivers/char/sysrq.c	Tue Jan  1 21:18:24 2002
@@ -246,8 +246,14 @@
=20
 static void sysrq_handle_showregs(int key, struct pt_regs *pt_regs,
 		struct kbd_struct *kbd, struct tty_struct *tty) {
+	int orig_loglevel;
+
 	if (pt_regs)
+		orig_loglevel =3D console_loglevel;
+		console_loglevel =3D 7;
 		show_regs(pt_regs);
+		console_loglevel =3D orig_loglevel;
+
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

--=-2jZRuEVLB/+yuggsaJgx--
