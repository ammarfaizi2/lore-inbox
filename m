Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263513AbTJLVAO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 17:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263519AbTJLVAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 17:00:14 -0400
Received: from h80ad2602.async.vt.edu ([128.173.38.2]:29317 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263513AbTJLVAK (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 17:00:10 -0400
Message-Id: <200310122059.h9CKxweb019804@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: kevin conaway <kconaway_is@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Where does user_path_walk() live? 
In-Reply-To: Your message of "Sun, 12 Oct 2003 21:38:19 BST."
             <20031012203819.GN7665@parcelfarce.linux.theplanet.co.uk> 
From: Valdis.Kletnieks@vt.edu
References: <20031012202609.54340.qmail@web20422.mail.yahoo.com>
            <20031012203819.GN7665@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_626099742P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 12 Oct 2003 16:59:58 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_626099742P
Content-Type: text/plain; charset=us-ascii

On Sun, 12 Oct 2003 21:38:19 BST, viro@parcelfarce.linux.theplanet.co.uk said:
> On Sun, Oct 12, 2003 at 01:26:09PM -0700, kevin conaway wrote:
> > I am a student doing an independent study on
> > filesystem security and I was trying to pin down
> 
> man find
> man xargs
> man grep
> 
> RTFUnixFAQ

Actually, the answer Kevin wanted was:

cd /usr/src/linux
grep -r __user_walk .

which will tell you it's in fs/namei.c - near line 967 for 2.6.9-test7 tree.

Unfortunately, it's basically a wrapper for path_lookup (also in fs/namei.c maybe
110 lines up from there).. which will drop you into link_path_walk() a ways above
that.  link_path_walk() is where the actual fun happens - note that most of
link_path_walk()'s actual work is done by calls to do_lookup() and follow_mount().

I would suggest Kevin read and understand *ALL* of fs/namei.c....

--==_Exmh_626099742P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/icDOcC3lWbTT17ARAv3NAJ9sxFJD64M7dNqDrnDyJRLKRFs91ACZAYQU
TGqjR2ViHQzyAarHaZrAeKY=
=LV6j
-----END PGP SIGNATURE-----

--==_Exmh_626099742P--
