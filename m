Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262123AbVERH6O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbVERH6O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 03:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262127AbVERH6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 03:58:14 -0400
Received: from h80ad263e.async.vt.edu ([128.173.38.62]:42760 "EHLO
	h80ad263e.async.vt.edu") by vger.kernel.org with ESMTP
	id S262124AbVERH6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 03:58:05 -0400
Message-Id: <200505180757.j4I7vNa3010150@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: fs <fs@ercist.iscas.ac.cn>
Cc: Bryan Henderson <hbryan@us.ibm.com>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Kenichi Okuyama <okuyama@intellilink.co.jp>
Subject: Re: [RFD] What error should FS return when I/O failure occurs? 
In-Reply-To: Your message of "Wed, 18 May 2005 13:10:24 EDT."
             <1116436224.2428.16.camel@CoolQ> 
From: Valdis.Kletnieks@vt.edu
References: <OF18BF4790.4053D6B0-ON88257004.0063F34D-88257004.006557CA@us.ibm.com>
            <1116436224.2428.16.camel@CoolQ>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1116403041_3369P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 18 May 2005 03:57:22 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1116403041_3369P
Content-Type: text/plain; charset=us-ascii

On Wed, 18 May 2005 13:10:24 EDT, fs said:

> For each test case, different FS returns different result.
> From user's perspective, it's really annoying, so, there should be a 
> standard which constraints the error type. Otherwise, different fs
> can return whatever they want, regardless of the user's need. 

Which does the user "need":

a) an 'errno' valye that's forced to be one of a specific subset of values,
even if none of them explain what's going on

or

b) an 'errno' value that actually tells you about the error?

Remember - if the *kernel* forces a -EROFS to become a -EIO, then userspace
is stuck with that value.  If the kernel passes -EROFS back to userspace,
then after glibc stashes an EROFS into errno, either glibc or the application
program can insert a 'if (errno == EROFS) {errno = EIO;}' if it feels that
EROFS is unnatural.

And in any case, that's what the *application programmer* needs.  What the *user*
needs is for the file to either be safely stored, or a dialog box put up saying
that it failed....

--==_Exmh_1116403041_3369P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCivVhcC3lWbTT17ARApDiAJ0XXaxk+c07j/RjZwydrZPs7ayi3wCfYgJy
2EZpwp39Op2N/ZsE59qqXiw=
=FFbd
-----END PGP SIGNATURE-----

--==_Exmh_1116403041_3369P--
