Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261460AbTJFUCb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 16:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261459AbTJFUCa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 16:02:30 -0400
Received: from newmail.somanetworks.com ([216.126.67.42]:12262 "EHLO
	mail.somanetworks.com") by vger.kernel.org with ESMTP
	id S261680AbTJFUAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 16:00:55 -0400
Date: Mon, 6 Oct 2003 16:00:49 -0400
From: Georg Nikodym <georgn@somanetworks.com>
To: Jan Schubert <Jan.Schubert@GMX.li>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0_test6: CONFIG_I8K produces wrong/no keycodes for special
 buttons
Message-Id: <20031006160049.6e428690.georgn@somanetworks.com>
In-Reply-To: <3F81ACB5.2000309@GMX.li>
References: <200310061034.h96AYGVP021010@dizzy.dz.net>
	<3F814B37.5040009@GMX.li>
	<20031006134215.7b857e06.georgn@somanetworks.com>
	<3F81ACB5.2000309@GMX.li>
Organization: SOMA Networks
X-Mailer: Sylpheed version 0.9.5claws28 (GTK+ 1.2.10; i386-pc-linux-gnu)
X-Face: #EE>^U0b8z^y>O0BZ>JJMGXyyxSP?<W-(g1&Yh;2p1'N6AeM]{Zfu(v>Uhe8ptGua4P}`QZ
 m%yb7CYwN^TiGQcP&mncyDrjAtLh7cB|m{$C,ww;yaYi*YvQllxb*vet
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Mon__6_Oct_2003_16_00_49_-0400_1BXmLoprDLrDCeXS"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Mon__6_Oct_2003_16_00_49_-0400_1BXmLoprDLrDCeXS
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Mon, 06 Oct 2003 19:56:05 +0200
Jan Schubert <Jan.Schubert@GMX.li> wrote:

> >-g (who's been too lazy to attempt the atkbd.c patchery needed to fix
> >this)
> >
> So, i assume you will fix this?

Wrong.  I know basically nothing about the input/keyboard code.  But...

Andries Brouwer posted, in another thread, that one should be able to
take the code from the message, and edit the table atkbd_set2_keycode...

Were it that simple (my patch is attached).  For the two buttons that
yielded the error message, I changed the 0 to the keycode that 2.4 used
to provide...

So this makes the messages go away, that's only half the battle.  If you
run with this patch, you'll notice that the Prev button generates the
same X keycode as the End key (which is busted).

I have no earthly idea how the keycodes in atkdb.c map to X keycodes. 
Maybe somebody can explain it in a simple way...

-g


===== /ws/georgn/bk/keller-kernels/keller-2.6/drivers/input/keyboard/atkbd.c 1.37 vs edited =====
--- 1.37/drivers/input/keyboard/atkbd.c	Fri Sep 26 02:56:26 2003
+++ edited//ws/georgn/bk/keller-kernels/keller-2.6/drivers/input/keyboard/atkbd.c	Mon Oct  6 14:30:39 2003
@@ -65,13 +65,13 @@
 	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
 	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,255,
 	  0,  0, 92, 90, 85,  0,137,  0,  0,  0,  0, 91, 89,144,115,  0,
-	217,100,255,  0, 97,165,164,  0,156,  0,  0,140,115,  0,  0,125,
+	217,100,255,  0, 97,165,164,  0,156,  0,  0,140,115,  0,  131,125,
 	173,114,  0,113,152,163,151,126,128,166,  0,140,  0,147,  0,127,
 	159,167,115,160,164,  0,  0,116,158,  0,150,166,  0,  0,  0,142,
 	157,  0,114,166,168,  0,  0,213,155,  0, 98,113,  0,163,  0,138,
 	226,  0,  0,  0,  0,  0,153,140,  0,255, 96,  0,  0,  0,143,  0,
 	133,  0,116,  0,143,  0,174,133,  0,107,  0,105,102,  0,  0,112,
-	110,111,108,112,106,103,  0,119,  0,118,109,  0, 99,104,119
+	110,111,108,112,106,103,  129,119,  0,118,109,  0, 99,104,119
 };
 
 static unsigned char atkbd_set3_keycode[512] = {

--Signature=_Mon__6_Oct_2003_16_00_49_-0400_1BXmLoprDLrDCeXS
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/gcn0oJNnikTddkMRAsukAKCIs8xA6W9elDX+o7W/wwczXZk9MgCeIUE7
mW02nkqvu+F8k7BBFU43cbQ=
=zglr
-----END PGP SIGNATURE-----

--Signature=_Mon__6_Oct_2003_16_00_49_-0400_1BXmLoprDLrDCeXS--
