Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284762AbRLEWWi>; Wed, 5 Dec 2001 17:22:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284765AbRLEWW3>; Wed, 5 Dec 2001 17:22:29 -0500
Received: from zero.tech9.net ([209.61.188.187]:37892 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S284762AbRLEWWZ>;
	Wed, 5 Dec 2001 17:22:25 -0500
Subject: Re: [PATCH] Preemptible kernel for SH
From: Robert Love <rml@tech9.net>
To: jsiegel@mvista.com
Cc: linux-kernel@vger.kernel.org, linuxsh-dev@lists.sourceforge.net
In-Reply-To: <1007261428.820.4.camel@phantasy>
In-Reply-To: <1007261428.820.4.camel@phantasy>
Content-Type: multipart/mixed; boundary="=-9mgGWYhL0dBfAVJTjeJ9"
X-Mailer: Evolution/1.0 (Preview Release)
Date: 05 Dec 2001 17:22:27 -0500
Message-Id: <1007590948.28563.8.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-9mgGWYhL0dBfAVJTjeJ9
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Users of gcc-3.x will need the attached patch _for gcc_ to compile an SH
kernel patched with preempt-kernel.  This is _not_ our fault, it is a
gcc bug and is now merged into CVS and should be part of gcc-3.1.

gcc-2.9x compiles without problem.  It is only 3.x versions that suffer
the bug.

	Robert Love

P.S. Also of note: yes this works on Sega Dreamcast.  You can have a
fully preemptible Dreamcast.  Impress your friends.  Or something.

--=-9mgGWYhL0dBfAVJTjeJ9
Content-Disposition: attachment; filename=gcc-ice-rml-3.0.2-1.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=ISO-8859-1

--- gcc/gcc/alias.c	2001/09/11 21:39:24	1.115.4.7
+++ gcc/gcc/alias.c	2001/11/18 08:16:38	1.115.4.8
@@ -1041,6 +1041,9 @@
   /* Some RTL can be compared without a recursive examination.  */
   switch (code)
     {
+    case VALUE:
+     return CSELIB_VAL_PTR (x) =3D=3D CSELIB_VAL_PTR (y);
+
     case REG:
       return REGNO (x) =3D=3D REGNO (y);
=20
@@ -1109,6 +1112,12 @@
 	  if (rtx_equal_for_memref_p (XEXP (x, i), XEXP (y, i)) =3D=3D 0)
 	    return 0;
 	  break;
+
+	  /* This can happen for asm operands.  */
+	case 's':
+	  if (strcmp (XSTR (x, i), XSTR (y, i)))
+	    return 0;
+	break;
=20
 	/* This can happen for an asm which clobbers memory.  */
 	case '0':

--=-9mgGWYhL0dBfAVJTjeJ9--

