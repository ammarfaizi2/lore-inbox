Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270365AbTG1Rnz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 13:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270386AbTG1Rnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 13:43:55 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:35457 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S270365AbTG1Rnv (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 13:43:51 -0400
Message-Id: <200307281759.h6SHx75k004260@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test2-mm1 and the mysterious dissapearing penguin..
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1109813884P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 28 Jul 2003 13:59:07 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1109813884P
Content-Type: text/plain; charset=us-ascii

OK So test2-mm1 comes out, so I pull down Linus's -test2 patch, the -mm1 patch,
and build a new tree from the -test1 source and the 2 patches.  I copy over
my .config, run 'make oldconfig', and 'make', and install all the pieces in the
right places, and reboot.

I get a vesa framebuffer, but no penguin logo, which *was* there in -test1-mm2.

So.. I figure I've screwed something up...

%  diff -u linux-2.6.0-test1-mm2/.config linux-2.6.0-test2-mm1/.config
--- linux-2.6.0-test1-mm2/.config       2003-07-20 12:10:24.000000000 -0400
+++ linux-2.6.0-test2-mm1/.config       2003-07-28 10:50:03.000000000 -0400
@@ -23,6 +23,8 @@
 CONFIG_KALLSYMS=y
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
+CONFIG_IOSCHED_AS=y
+CONFIG_IOSCHED_DEADLINE=y
 
 #
 # Loadable module support
@@ -597,6 +599,7 @@
 CONFIG_PCMCIA_HERMES=y
 # CONFIG_AIRO_CS is not set
 # CONFIG_PCMCIA_ATMEL is not set
+# CONFIG_PCMCIA_WL3501 is not set
 CONFIG_NET_WIRELESS=y
 
 #

Hmm.. Then I notice that my speedstep-ich still has issues, and re-apply a patch
that *ONLY* hits speedstep-ich.c, and re-build.. and I get this:

% make
  CC      scripts/empty.o
  MKELF   scripts/elfconfig.h
  HOSTCC  scripts/file2alias.o
  HOSTCC  scripts/modpost.o
  HOSTLD  scripts/modpost
make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
  CHK     include/linux/compile.h
  CC      arch/i386/kernel/cpu/cpufreq/speedstep-ich.o
  LD      arch/i386/kernel/cpu/cpufreq/built-in.o
  LD      arch/i386/kernel/cpu/built-in.o
  LD      arch/i386/kernel/built-in.o
./scripts/pnmtologo -t mono -n logo_linux_mono -o drivers/video/logo/logo_linux_mono.c drivers/video/logo/logo_linux_mono.pbm
  CC      drivers/video/logo/logo_linux_mono.o
./scripts/pnmtologo -t vga16 -n logo_linux_vga16 -o drivers/video/logo/logo_linux_vga16.c drivers/video/logo/logo_linux_vga16.ppm
  CC      drivers/video/logo/logo_linux_vga16.o
./scripts/pnmtologo -t clut224 -n logo_linux_clut224 -o drivers/video/logo/logo_linux_clut224.c drivers/video/logo/logo_linux_clut224.ppm
  CC      drivers/video/logo/logo_linux_clut224.o
  LD      drivers/video/logo/built-in.o
  LD      drivers/video/built-in.o
  LD      drivers/built-in.o
  GEN     .version
  CHK     include/linux/compile.h

Looks like a dependency issue?  Why would they get build THIS time and apparently
not the first time around?

--==_Exmh_1109813884P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/JWRrcC3lWbTT17ARAkfNAKDSfWxXHURRBiWnqu/W21C5VPnZaACbBsNb
2st5szg1LbUTTyMdNmo07Kk=
=XpGM
-----END PGP SIGNATURE-----

--==_Exmh_1109813884P--
