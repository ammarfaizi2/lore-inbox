Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262462AbUCaWbm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 17:31:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262515AbUCaWbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 17:31:42 -0500
Received: from mx1.elte.hu ([157.181.1.137]:20122 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262462AbUCaWb0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 17:31:26 -0500
Date: Thu, 1 Apr 2004 00:31:20 +0200
From: Rokob Tibor Andras <rokoba@elte.hu>
To: linux-kernel@vger.kernel.org
Subject: Disabling VT switching as non-root in 2.4.25
Message-ID: <20040331223119.GA6825@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Trying the 'vlock' software (virtual console locking tool,
http://freshmeat.net/projects/vlock), and looking at
drivers/char/vt.c in kernel 2.4.25 I found the following:

There are two ioctls (VT_LOCKSWITCH,VT_UNLOCKSWITCH) which
are intended to lock and unlock the changing of virtual
consoles. According to the kernel code they are available to the
super-user only. However, by doing a VT_SETMODE ioctl to VT_PROCESS,=20
and denying to release the VT by giving 0 to VT_RELDISP, it is possible
to disable VT switching as non-root ('vlock' is a working example
which is able to do this).

I mean this is not only an inconsistency among the permissions needed by
different system calls, but a small 'security hole' (a user who has
access to the console may completely lock it, and it can only be
unlocked by logging in as root from the network (if there is any) and
killing the user's process).

The problem affects the 2.4.x kernel series including the last
released 2.4.25 and according to its ChangeLog also 2.4.26-rc1.
(It seems to me by a quick look that drivers/char/vt_ioctl.c in 2.6.3=20
behaves the same; I didn't check against 2.2.x and 2.0.x series).

Regards,
Andras Rokob
rokoba@elte.hu

My PGP public key is available from bolyai.elte.hu.

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAa0a2+/cmWq+8spQRAgeQAJ45oq6o+fgQ0Hn2B/11C+wQwvj07wCcCOd0
JiLZZ5IF4egVmTI2eCyZinw=
=M1T3
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
