Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261730AbVAYCFA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261730AbVAYCFA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 21:05:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbVAYCFA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 21:05:00 -0500
Received: from h80ad25f5.async.vt.edu ([128.173.37.245]:24850 "EHLO
	h80ad25f5.async.vt.edu") by vger.kernel.org with ESMTP
	id S261730AbVAYCE5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 21:04:57 -0500
Message-Id: <200501250204.j0P24mFE014360@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: John Richard Moser <nigelenki@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: undefined references 
In-Reply-To: Your message of "Mon, 24 Jan 2005 19:04:53 EST."
             <41F58D25.1000203@comcast.net> 
From: Valdis.Kletnieks@vt.edu
References: <41F58D25.1000203@comcast.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1106618688_11132P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 24 Jan 2005 21:04:48 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1106618688_11132P
Content-Type: text/plain; charset=us-ascii

On Mon, 24 Jan 2005 19:04:53 EST, John Richard Moser said:

> fs/built-in.o(.text+0xe413): In function `link_path_walk':
> : undefined reference to `gr_inode_follow_link'
> fs/built-in.o(.text+0xe933): In function `link_path_walk':
> : undefined reference to `gr_inode_follow_link'
> fs/built-in.o(.text+0x10c28): In function `sys_link':
> : undefined reference to `gr_inode_hardlink'
> fs/built-in.o(.text+0x10c52): In function `sys_link':
> : undefined reference to `gr_inode_handle_create'
> make: *** [.tmp_vmlinux1] Error 1
> 
> What would cause this kind of error?

link_path_walk() still has a reference to gr_inode_follow_link (the code
you probably want to move to an LSM exit), and sys_ling() still calls
gr_inode_hardlink() and gr_inode_handle_create() - but the actual functions
you're calling either don't exist anymore, or they didn't get compiled and linked
in.  If those functions are supposed to exist, you need to get them into a .o.
If those are (as I suspect) becoming LSM exit hooks, then you need to clean up
the direct calls in link_path_walk() and sys_link().

--==_Exmh_1106618688_11132P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFB9ak/cC3lWbTT17ARAmXfAJ9LoZw2WKrnfoMaDM921/S28Cx2owCg1mcQ
cTPFdv2NA37LeJCJfOmDtyw=
=ad5b
-----END PGP SIGNATURE-----

--==_Exmh_1106618688_11132P--
