Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130454AbRCWKGU>; Fri, 23 Mar 2001 05:06:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130457AbRCWKGN>; Fri, 23 Mar 2001 05:06:13 -0500
Received: from mail-out.chello.nl ([213.46.240.7]:26907 "EHLO
	amsmta01-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S130454AbRCWKGA>; Fri, 23 Mar 2001 05:06:00 -0500
Date: Fri, 23 Mar 2001 11:04:13 +0100
From: Kurt Garloff <garloff@suse.de>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Some strange patch to drivers/input/keybdev.c
Message-ID: <20010323110413.D12408@garloff.casa-etp.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20010322214255.A4737@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="jTMWTj4UTAEmbWeb"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010322214255.A4737@devserv.devel.redhat.com>; from zaitcev@redhat.com on Thu, Mar 22, 2001 at 09:42:55PM -0500
X-Operating-System: Linux 2.2.16 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TUE/NL, SuSE/FRG
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jTMWTj4UTAEmbWeb
Content-Type: multipart/mixed; boundary="0IvGJv3f9h+YhkrH"
Content-Disposition: inline


--0IvGJv3f9h+YhkrH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 22, 2001 at 09:42:55PM -0500, Pete Zaitcev wrote:
> Some guy sent me the attached patch. He says it allows
> him to use 2 additional keys on the 106 key USB keyboard.
> I never saw a 106 key keyboard before, USB or not.
> Does anyone understand what is going on? Vojtech?

don't know if it's related, but new keyboards tend to have those annoying
APM keys. On my keyboard, they generate the scan sequences e0 5e (Power
OFF), e0 5f (Sleep) and e0 63 (Wake Up). I guess the USB kbd also has those
toy keys.
Patch to support those keys on a normal PS/2 kbd attached.

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE GmbH, Nuernberg, FRG                               SCSI, Security

--0IvGJv3f9h+YhkrH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux2216-apm-keys.diff"
Content-Transfer-Encoding: quoted-printable

--- linux.compile.old/drivers/char/pc_keyb.c	Tue Jul 11 15:00:25 2000
+++ linux.compile/drivers/char/pc_keyb.c	Wed Jan 31 18:51:41 2001
@@ -153,6 +153,10 @@
=20
 #define E1_PAUSE   119
=20
+#define E0_PWOFF   115
+#define E0_SLEEP   116
+#define E0_ALARM   117
+
 /*
  * The keycodes below are randomly located in 89-95,112-118,120-127.
  * They could be thrown away (and all occurrences below replaced by 0),
@@ -230,10 +234,10 @@
   0, 0, 0, 0, 0, E0_KPSLASH, 0, E0_PRSCR,	      /* 0x30-0x37 */
   E0_RALT, 0, 0, 0, 0, E0_F13, E0_F14, E0_HELP,	      /* 0x38-0x3f */
   E0_DO, E0_F17, 0, 0, 0, 0, E0_BREAK, E0_HOME,	      /* 0x40-0x47 */
-  E0_UP, E0_PGUP, 0, E0_LEFT, E0_OK, E0_RIGHT, E0_KPMINPLUS, E0_END,/* 0x4=
8-0x4f */
+  E0_UP, E0_PGUP, 0, E0_LEFT, E0_OK, E0_RIGHT, E0_KPMINPLUS, E0_END, /* 0x=
48-0x4f */
   E0_DOWN, E0_PGDN, E0_INS, E0_DEL, 0, 0, 0, 0,	      /* 0x50-0x57 */
-  0, 0, 0, E0_MSLW, E0_MSRW, E0_MSTM, 0, 0,	      /* 0x58-0x5f */
-  0, 0, 0, 0, 0, 0, 0, 0,			      /* 0x60-0x67 */
+  0, 0, 0, E0_MSLW, E0_MSRW, E0_MSTM, E0_PWOFF, E0_SLEEP, /* 0x58-0x5f */
+  0, 0, 0, E0_ALARM, 0, 0, 0, 0,		      /* 0x60-0x67 */
   0, 0, 0, 0, 0, 0, 0, E0_MACRO,		      /* 0x68-0x6f */
   0, 0, 0, 0, 0, 0, 0, 0,			      /* 0x70-0x77 */
   0, 0, 0, 0, 0, 0, 0, 0			      /* 0x78-0x7f */

--0IvGJv3f9h+YhkrH--

--jTMWTj4UTAEmbWeb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6ux+cxmLh6hyYd04RAv0GAKCgCLC+VSudNSvpY7lRvR0sz+d9NQCePx4J
8n+D3trB5sr/K29Zf2a+ACs=
=QfHe
-----END PGP SIGNATURE-----

--jTMWTj4UTAEmbWeb--
