Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267949AbTAMFYR>; Mon, 13 Jan 2003 00:24:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267924AbTAMFXa>; Mon, 13 Jan 2003 00:23:30 -0500
Received: from h80ad24d8.async.vt.edu ([128.173.36.216]:21376 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S267923AbTAMFWF>; Mon, 13 Jan 2003 00:22:05 -0500
Message-Id: <200301122138.h0CLcjQ7001108@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4+dev
To: linux-kernel@vger.kernel.org
Subject: 2.5.56, modules, and RedHat Psyche
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-331814880P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 12 Jan 2003 16:38:44 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-331814880P
Content-Type: text/plain; charset=us-ascii

Just got bit by this little code in /etc/rc.sysinit  on RH 8.0.92:

if ! grep -iq nomodules /proc/cmdline 2>/dev/null && [ -f /proc/ksyms ]; then
    USEMODULES=y
fi

...

if [ -f /proc/sys/kernel/modprobe ]; then
   if [ -n "$USEMODULES" ]; then
       sysctl -w kernel.modprobe="/sbin/modprobe" >/dev/null 2>&1
       sysctl -w kernel.hotplug="/sbin/hotplug" >/dev/null 2>&1
   else
       # We used to set this to NULL, but that causes 'failed to exec' messages"
       sysctl -w kernel.modprobe="/bin/true" >/dev/null 2>&1
       sysctl -w kernel.hotplug="/bin/true" >/dev/null 2>&1
   fi
fi

Easy enough to work around, once you know about it. I noticed this trying to
figure out why iptables was working when the filters were built into the
kernel, but not as modules.

Hopefully this will save somebody else debugging time and/or eventually
produce a patch for rc.sysinit....
-- 
				Valdis Kletnieks
				Computer Systems Senior Engineer
				Virginia Tech


--==_Exmh_-331814880P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+IeBkcC3lWbTT17ARAgewAJ9pmjvKJjiVg03fk7RXRCbm+GlQMgCdEJU1
uj34I72J7dkDTQDNmxiyeLI=
=FapB
-----END PGP SIGNATURE-----

--==_Exmh_-331814880P--
