Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261888AbVGUVUw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261888AbVGUVUw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 17:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261884AbVGUVUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 17:20:24 -0400
Received: from gw01.mail.saunalahti.fi ([195.197.172.115]:44433 "EHLO
	gw01.mail.saunalahti.fi") by vger.kernel.org with ESMTP
	id S261888AbVGUVTf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 17:19:35 -0400
Message-ID: <42E01163.3090302@trn.iki.fi>
Date: Fri, 22 Jul 2005 00:19:31 +0300
From: =?UTF-8?B?TGFzc2UgS8Okcmtrw6RpbmVuIC8gVHJvbmlj?= 
	<tronic+lzID=lx43caky45@trn.iki.fi>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050712)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: CIFS slowness & crashes
X-Enigmail-Version: 0.92.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig91EC3E797DCA4483BB6EF234"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig91EC3E797DCA4483BB6EF234
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

I mailed sfrench@samba.org (the guy who wrote the driver) about this a
month ago, but didn't get any reply. Is anyone working on that driver
anymore?

The problems that I wrote him about were:

1. CIFS VFS hangs entirely if the server crashes or otherwise goes
offline. Every process touching the mount halts too and cannot be killed
(but they are not zombies). System loads start climbing and eventually
the entire system will die (after system loads reach about 500). It is
not possible to umount with either smbumount (hangs) nor umount -f
(prints errors but doesn't umount anything). It won't recover without
reboot, even if the server becomes back online.

This problem has been around as long as I have used SMBFS or CIFS. There
has only been slight variation from one version to another. Sometimes it
is possible to umount them (after some pretty long timeout), sometimes
it is not. It seems as if the problem was being fixed, but none of the
fixes really worked.

2. Occassionally the transmission speeds go extremely low for no
apparent reason. While writing this, I am getting 0.39 Mo/s over a
gigabit network. Using FTP to read the same file gives 40 Mo/s, which is
the speed that the file can be read locally on the server too.
Remounting the CIFS does not help, nor does restarting Samba. However,
using SMBFS I can get 20 Mo/s which is a bit better but still far from
what it should be. It is important to mention that sometimes CIFS does
work faster (about as quickly as SMBFS) and that this misbehavior occurs
randomly.

During CIFS transfer, both computers seem to be idling. The CPU usage
(including I/O wait) is almost none. During SMBFS transfer the server
smbd process uses about 15 % CPU and the client is almost idle. The
client is P4 3.4 GHz and the server is Athlon64 3000+.

I also tested with a Windows XP client machine and found out that this
slowness issue does not happen with it, using the very same Samba server
that the Linux CIFS mount is using.

- Tronic -

--------------enig91EC3E797DCA4483BB6EF234
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFC4BFmOBbAI1NE8/ERAsCJAJ9j8guhkogrzZp1UoA8WjZN1fLRJACdEP9J
SDh69EAJzisFttdbE2lQFto=
=ctxj
-----END PGP SIGNATURE-----

--------------enig91EC3E797DCA4483BB6EF234--
