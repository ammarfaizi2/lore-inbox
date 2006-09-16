Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964794AbWIPMnk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964794AbWIPMnk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 08:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964799AbWIPMnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 08:43:39 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:33460 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S964794AbWIPMnj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 08:43:39 -0400
X-Sasl-enc: X357r4RGpybjSbXkR30ZhinSjhFFqWU4OSRuH4qJdpxh 1158410617
Message-ID: <450BF1CC.2070309@imap.cc>
Date: Sat, 16 Sep 2006 14:45:00 +0200
From: Tilman Schmidt <tilman@imap.cc>
Organization: me - organized??
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.8.0.6) Gecko/20060729 SeaMonkey/1.0.4 Mnenhy/0.7.4.666
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: john stultz <johnstul@us.ibm.com>
Subject: [2.6.18-rc7] printk output delay in syslog wrt dmesg still unfixed
X-Enigmail-Version: 0.94.1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig7D86609D75735AB27014FF6B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7D86609D75735AB27014FF6B
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

The following problem, which I reported for kernel 2.6.18-rc1 on my
development machine
  Dell OptiPlex GX110
  uname -a =3D Linux gx110 2.6.18-rc7-noinitrd #1 PREEMPT Thu Sep 14
15:13:38 CEST 2006 i686 i686 i386 GNU/Linux
  933 MHz Pentium III processor, i810 chipset, 512 MB RAM
  distribution SuSE 10.0, syslog-ng 1.6.8, klogd 1.4.1, Xorg X11 6.8.2
still exists with 2.6.18-rc7:

While X is running, output from printk() appears in syslog (eg.
/var/log/messages) only after a key is pressed on the system keyboard,
even though it is visible with dmesg immediately.

Additional observations:
- The problem is *not* present with 2.6.17.* or earlier kernels.
- The problem *is* present with 2.6.18-rc*-mm* kernels.
- The problem disappears if the X server is terminated (telinit 3) and
  reappears if the X server is started again (telinit 5).
- Syslog messages from userspace programs are not affected by the delay.
- No messages are lost, all appear eventually, though possibly hours
  or days later, depending on how long nobody touches the keyboard.
- It doesn't matter which key is pressed; even pressing a shift key all
  by its own is sufficient to make the missing messages appear.
- I couldn't find any other action that would release the messages;
  neither mouse movements or clicks, nor waiting up to 24 hours, not
  even logging in via ssh from another machine and compiling a Linux
  kernel. ;-)
- The effect can be clearly observed by the difference between the
  kernel's own timestamps and those by syslogd; an extreme example:

Sep 16 14:11:16 gx110 kernel: [18729.057746] gigaset: unblocking all
channels
Sep 16 14:11:16 gx110 kernel: [18729.057765] gigaset: searching
scheduled commands
Sep 16 14:11:16 gx110 kernel: [86033.298803] gigaset: received response
(8 bytes): ^M^JZLOG^M^J
Sep 16 14:11:16 gx110 kernel: [86033.298898] bas_gigaset: cmd_loop: End
of Command (0 Bytes)

Please let me know if I can help in any way with locating the cause of
this annoying phenomenon.

Thanks
Tilman

--=20
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Ungeoeffnet mindestens haltbar bis: (siehe Rueckseite)


--------------enig7D86609D75735AB27014FF6B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3rc1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFC/HSMdB4Whm86/kRAufiAJ9pOjHfS8KUzW58MXKt7h0IHv+AJQCfZ27U
Y0b3M3eozoa5Mc2WjChjZ0A=
=V9z5
-----END PGP SIGNATURE-----

--------------enig7D86609D75735AB27014FF6B--
