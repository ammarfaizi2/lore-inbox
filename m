Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318385AbSHELDH>; Mon, 5 Aug 2002 07:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318386AbSHELDH>; Mon, 5 Aug 2002 07:03:07 -0400
Received: from mail1.commerzbank.com ([212.149.48.99]:25285 "EHLO
	mail1.commerzbank.com") by vger.kernel.org with ESMTP
	id <S318385AbSHELDE>; Mon, 5 Aug 2002 07:03:04 -0400
Message-ID: <A1081E14241CD4119D2B00508BCF80410843F2BD@SV021558>
From: "Zeuner, Axel" <Axel.Zeuner@partner.commerzbank.com>
To: linux-kernel@vger.kernel.org
Subject: AW: Thread group exit
Date: Mon, 5 Aug 2002 13:06:36 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C23C70.2A31B6A0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C23C70.2A31B6A0
Content-Type: text/plain;
	charset="iso-8859-1"

I rewrote the patch according to Alans idea, works for me. As mentioned
before, the patch is against 2.4.18-ngpt, but should also apply to 2.4.19.
Replace p_pptr with parent for 2.5 series.

Axel

Dr. Axel Zeuner
Consultant e.business D
Systor GmbH & Co. KG, Goethering 58,  63067 Offenbach


------_=_NextPart_000_01C23C70.2A31B6A0
Content-Type: application/octet-stream;
	name="self_exec_id.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="self_exec_id.diff"

--- kernel/exit.c.original	Mon Aug  5 09:09:31 2002=0A=
+++ kernel/exit.c	Mon Aug  5 12:26:38 2002=0A=
@@ -176,7 +176,6 @@=0A=
 		if (p->p_opptr =3D=3D father) {=0A=
 			/* We dont want people slaying init */=0A=
 			p->exit_signal =3D SIGCHLD;=0A=
-			p->self_exec_id++;=0A=
 =0A=
 			/* Make sure we're not reparenting to ourselves */=0A=
 			if (p =3D=3D reaper)=0A=
--- kernel/signal.c.original	Mon Aug  5 12:26:49 2002=0A=
+++ kernel/signal.c	Mon Aug  5 12:34:44 2002=0A=
@@ -16,6 +16,8 @@=0A=
 =0A=
 #include <asm/uaccess.h>=0A=
 =0A=
+extern struct task_struct* child_reaper;=0A=
+=0A=
 /*=0A=
  * SLAB caches for signal bits.=0A=
  */=0A=
@@ -772,6 +774,9 @@=0A=
 	struct siginfo info;=0A=
 	int why, status;=0A=
 =0A=
+	if (tsk->p_pptr=3D=3Dchild_reaper) {=0A=
+		sig=3DSIGCHLD;=0A=
+	}=0A=
 	info.si_signo =3D sig;=0A=
 	info.si_errno =3D 0;=0A=
 	info.si_pid =3D tsk->pid;=0A=

------_=_NextPart_000_01C23C70.2A31B6A0--
