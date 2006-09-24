Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751170AbWIXQ5o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbWIXQ5o (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 12:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbWIXQ5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 12:57:44 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:39400 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1751170AbWIXQ5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 12:57:43 -0400
X-Sasl-enc: BBx/dq5cLmmvo/Mpv+C4Gp27k81hrpkTb4sek9XzPNfB 1159117064
Message-ID: <4516B966.3010909@imap.cc>
Date: Sun, 24 Sep 2006 18:59:18 +0200
From: Tilman Schmidt <tilman@imap.cc>
Organization: me - organized??
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.8.0.6) Gecko/20060729 SeaMonkey/1.0.4 Mnenhy/0.7.4.666
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [2.6.18-rc7-mm1] slow boot
X-Enigmail-Version: 0.94.1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig65C80F18D1D7235AD3BCF59F"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig65C80F18D1D7235AD3BCF59F
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

FYI: On my Dell OptiPlex GX110 (Intel Pentium III, 933 MHz, 512 MB
RAM, i810 chipset), kernel 2.6.18-rc7-mm1 takes drastically longer
to boot than 2.6.18 mainline release. Some data points from the
respective dmesg outputs:

<<<<<<< 2.6.18
<4>[   26.332472] PID hash table entries: 2048 (order: 11, 8192 bytes)
<4>[   26.334415] Console: colour VGA+ 80x25
>>>>>>> 2.6.18-rc7-mm1
<4>[   32.102004] PID hash table entries: 2048 (order: 11, 8192 bytes)
<4>[   32.174041] Console: colour VGA+ 80x25

Strange delay in mm wrt mainline. (There are several of these.)

<<<<<<< 2.6.18
<4>[   26.336075] ------------------------
<4>[   26.336130] | Locking API testsuite:
<4>[   26.336187] -------------------------------------------------------=
---------------------
<4>[   26.336270]                                  | spin |wlock |rlock |=
mutex | wsem | rsem |
<4>[   26.336352]   -----------------------------------------------------=
---------------------
<4>[   26.336451]                      A-A deadlock:  ok  |  ok  |  ok  |=
  ok  |  ok  |  ok  |
<4>[   26.338380]                  A-B-B-A deadlock:  ok  |  ok  |  ok  |=
  ok  |  ok  |  ok  |
<4>[   26.340249]              A-B-B-C-C-A deadlock:  ok  |  ok  |  ok  |=
  ok  |  ok  |  ok  |
=2E..
<4>[   26.408007] Good, all 218 testcases passed! |
<4>[   26.408065] ---------------------------------
>>>>>>> 2.6.18-rc7-mm1
<4>[   32.183079] ------------------------
<4>[   32.183134] | Locking API testsuite:
<4>[   32.183190] -------------------------------------------------------=
---------------------
<4>[   32.183273]                                  | spin |wlock |rlock |=
mutex | wsem | rsem |
<4>[   32.183356]   -----------------------------------------------------=
---------------------
<4>[   32.183452]                      A-A deadlock:  ok  |  ok  |  ok  |=
  ok  |  ok  |  ok  |
<4>[   32.273613]                  A-B-B-A deadlock:  ok  |  ok  |  ok  |=
  ok  |  ok  |  ok  |
<4>[   32.497062]              A-B-B-C-C-A deadlock:  ok  |  ok  |  ok  |=
  ok  |  ok  |  ok  |
=2E..
<4>[   39.746662] Good, all 218 testcases passed! |
<4>[   39.746720] ---------------------------------

All locking API tests are extremely slow (tenths of seconds in mm,
milliseconds in mainline.) By the end of the testsuite, the mm
kernel has already lost 13 seconds on the mainline kernel.

<<<<<<< 2.6.18
<4>[   26.596570] evxfevnt-0089 [02] enable                : Transition t=
o ACPI mode successful
<6>[   26.708752] NET: Registered protocol family 16
>>>>>>> 2.6.18-rc7-mm1
<4>[   40.787142] evxfevnt-0089 [02] enable                : Transition t=
o ACPI mode successful
<6>[   41.329553] NET: Registered protocol family 16

<<<<<<< 2.6.18
<6>[   26.749162] ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
<7>[   26.757435] Boot video device is 0000:00:01.0
>>>>>>> 2.6.18-rc7-mm1
<6>[   42.025638] ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
<7>[   42.435641] Boot video device is 0000:00:01.0

More inexplicable delays.

<<<<<<< 2.6.18
<6>[   30.233858] PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,=
0x64 irq 1,12
<6>[   30.242857] serio: i8042 AUX port at 0x60,0x64 irq 12
<6>[   30.249613] serio: i8042 KBD port at 0x60,0x64 irq 1
<6>[   30.257604] mice: PS/2 mouse device common for all mice
<6>[   30.265941] input: PC Speaker as /class/input/input0
<6>[   30.304365] input: AT Translated Set 2 keyboard as /class/input/inp=
ut1
>>>>>>> 2.6.18-rc7-mm1
<6>[   56.409925] PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,=
0x64 irq 1,12
<6>[   56.660486] serio: i8042 AUX port at 0x60,0x64 irq 12
<6>[   57.028188] serio: i8042 KBD port at 0x60,0x64 irq 1
<6>[   57.036853] mice: PS/2 mouse device common for all mice
<6>[   58.532944] input: PC Speaker as /devices/platform/pcspkr/input0
<6>[   59.224917] input: AT Translated Set 2 keyboard as /devices/platfor=
m/i8042/serio1/input1
<6>[   61.408168] input: ImPS/2 Generic Wheel Mouse as /devices/platform/=
i8042/serio0/input2

Keyboard and mouse detection take 100x as long as normal.

<<<<<<< 2.6.18
<6>[   37.446763] md: ... autorun DONE.
<6>[   38.578832] NTFS driver 2.1.27 [Flags: R/W MODULE].
<6>[   38.771306] NTFS volume version 3.1.
>>>>>>> 2.6.18-rc7-mm1
<6>[   73.384371] md: ... autorun DONE.
<6>[   73.565190] warning: process `showconsole' used the removed sysctl =
system call
<6>[   75.436369] NTFS driver 2.1.27 [Flags: R/W MODULE].
<6>[   75.637003] NTFS volume version 3.1.

In the end, the mm kernel has taken twice as much time to get up
and running as the mainline kernel.

Please let me know if you need more information.

--=20
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Ungeoeffnet mindestens haltbar bis: (siehe Rueckseite)


--------------enig65C80F18D1D7235AD3BCF59F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3rc1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFFrluMdB4Whm86/kRAl8mAJsH4qVS5kJRv7M5TWCJOsTW1CT/uACfa1Kc
MsYHGvLJV9E+NnelnMazz4c=
=knAb
-----END PGP SIGNATURE-----

--------------enig65C80F18D1D7235AD3BCF59F--
