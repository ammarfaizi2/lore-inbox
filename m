Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261714AbVEPR7W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261714AbVEPR7W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 13:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261712AbVEPR7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 13:59:22 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:8465 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261714AbVEPR7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 13:59:05 -0400
Message-Id: <200505161758.j4GHw4EW009866@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: fs <fs@ercist.iscas.ac.cn>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Kenichi Okuyama <okuyama@intellilink.co.jp>
Subject: Re: [RFD] What error should FS return when I/O failure occurs? 
In-Reply-To: Your message of "Mon, 16 May 2005 14:04:04 EDT."
             <1116266644.2434.86.camel@CoolQ> 
From: Valdis.Kletnieks@vt.edu
References: <1116263665.2434.69.camel@CoolQ> <200505160635.j4G6ZUcX023810@turing-police.cc.vt.edu>
            <1116266644.2434.86.camel@CoolQ>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1116266283_5623P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 16 May 2005 13:58:04 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1116266283_5623P
Content-Type: text/plain; charset=us-ascii

On Mon, 16 May 2005 14:04:04 EDT, fs said:

> The point is(from the user's perspective, not FS developer's):
> If you open a file with O_RDWR, and sys_open returns success,
> next, call sys_write, but returns EROFS? The two return values are
> paradox/self-contradictory.

You'd be better off pointing out that 'man 2 write' lists the errors that
might be returned as:  EBAF, EINVAL, EFAULT, EFBIG, EPIPE, EAGAIN, EINTR,
ENOSPC, and EIO.

Does the POSIX spec allow write() to return -EROFS?

What happens if you're writing to an NFS-mounted file system, and the remote
system remounts the disk R/O?  What is reported in that case?

> The purpose of this RFD, is to get the community to understand,
> all I/O related syscalls should return VFS error, not FS error.

All fine and good, until you hit a case like ext3 where reporting
the FS error code will better explain the *real* problem than forcing
it to fit into one of the provided VFS errors.

> User mode app should not care about the FS they are using. 
> So, the community should define the ONLY VFS error first.

I think that's been done, and the VFS behavior is "if the FS reports
an error we pass it up to userspace".

--==_Exmh_1116266283_5623P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCiN8rcC3lWbTT17ARAt+hAJ9kO2EUC31BKoqkvPNrNkqo+zaJsgCgwtwc
2pyqqAl6PKOAzNtCea6msP0=
=J49L
-----END PGP SIGNATURE-----

--==_Exmh_1116266283_5623P--
