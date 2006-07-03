Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750933AbWGCVrK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750933AbWGCVrK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 17:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750983AbWGCVrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 17:47:09 -0400
Received: from pool-71-254-76-103.ronkva.east.verizon.net ([71.254.76.103]:56516
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1750980AbWGCVrI (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 17:47:08 -0400
Message-Id: <200607032146.k63LkFNF027323@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Tomasz Torcz <zdzichu@irc.pl>,
       Helge Hafting <helgehaf@aitel.hist.no>,
       Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       "Theodore Ts'o" <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: ext4 features
In-Reply-To: Your message of "Mon, 03 Jul 2006 15:46:55 MDT."
             <44A9904F.7060207@wolfmountaingroup.com>
From: Valdis.Kletnieks@vt.edu
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de> <20060701170729.GB8763@irc.pl> <20060701174716.GC24570@cip.informatik.uni-erlangen.de> <20060701181702.GC8763@irc.pl> <20060703202219.GA9707@aitel.hist.no> <20060703205523.GA17122@irc.pl> <1151960503.3108.55.camel@laptopd505.fenrus.org>
            <44A9904F.7060207@wolfmountaingroup.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1151963175_4949P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 03 Jul 2006 17:46:15 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1151963175_4949P
Content-Type: text/plain; charset=us-ascii

On Mon, 03 Jul 2006 15:46:55 MDT, "Jeff V. Merkey" said:
> Add a salvagable file system to ext4, i.e. when a file is deleted, you
> just rename it and move it to a directory called DELETED.SAV and recycle
> the files as people allocate new ones.  Easy to do (internal "mv" of
> file to another directory) and modification of the allocation bitmaps.  
> Very simple and will pay off big.  If you need help designing it, just

Much better done in userspace - the kernel can't get this right without
some user hinting.  For starters, it creates a big security hole in all
the code that does an open()/unlink().

Also, how do you handle the corner cases?  The fact you're adding to the
pathname of the file means you might push some long names over the MAXPATHLEN
value, and you have to worry about name collisions in the directory, and
so on.  There's also more subtle leakage issues, such as properly handling
the permissions on the files on a multi-user system so users can't rummage
each other's trash....

--==_Exmh_1151963175_4949P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEqZAncC3lWbTT17ARAsJuAKDgBQtX3bdRO1DQCK1U+iMiCJaTpwCfT0+k
CnInJkDoHoXO+MG6huuoe3k=
=Sv/S
-----END PGP SIGNATURE-----

--==_Exmh_1151963175_4949P--
