Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264112AbTDWQJj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 12:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264113AbTDWQJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 12:09:39 -0400
Received: from h80ad26b0.async.vt.edu ([128.173.38.176]:24706 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S264112AbTDWQJf (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 12:09:35 -0400
Message-Id: <200304231621.h3NGLaCs019543@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: "Leonard Milcin, Jr" <thervoy@post.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: FileSystem Filter Driver 
In-Reply-To: Your message of "Wed, 23 Apr 2003 17:48:17 +0200."
             <3EA6B5C1.1040903@post.pl> 
From: Valdis.Kletnieks@vt.edu
References: <000501c30983$1ffb8950$ade1db3e@pinguin> <1051092516.1896.7.camel@abhilinux.cygnet.co.in> <20030423.11473966@knigge.local.net>
            <3EA6B5C1.1040903@post.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_982507576P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 23 Apr 2003 12:21:36 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_982507576P
Content-Type: text/plain; charset=us-ascii

On Wed, 23 Apr 2003 17:48:17 +0200, "Leonard Milcin, Jr" <thervoy@post.pl>  said:
> Nice. I wonder if there is some open-source project with aim in building
> audit tool based on that idea. It will be very nice to have one, and I 
> think it will be very interesting, especially for corporate users. I 
> will search for information about this, and if I find nothing, maybe 
> this is a good moment to start that project? The aim will be building 
> kernel driver + user-space tool to provide 1) ultimate filesystem audit 
> tool, 2) user space access control manager. This will help linux to 
> conquer with proprietary products.

Proper kernel auditing is harder than it looks.  Check the LSM mailing list
archives for the last attempt to get auditing into the kernel - the idea
was basically dropped.

The basic problem is that there exist standards and best practices on how
auditing should be done, and doing it correctly in the Linux kernel would be
quite invasive.  For example, although LSM already provides an exit in the
open() syscall, you can't use it for auditing because not all failures reach
the exit - there are cases (failed on permissions/ACL checks, etc) where the
call is failed and returns before LSM exits are call, and the standards say
those should result in audit records.

Placing the hooks isn't easy either.  You can't hook right at the syscall
level. because you end up having to do a lot of work twice (looking up
pathnames, etc) - both wasteful and prone to race conditions.  Hooking at the
filesystem level isn't right either - if you hook ext2 and ext3, you miss any
events that happen to be on xfs or reiserfs or what have you. If you can't
think of 3 "gotchas" of doing it at the VFS level, you shouldn't be poking in
that code either.. ;)

Good Luck.. ;)

--==_Exmh_982507576P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+pr2QcC3lWbTT17ARAnf4AJ9tn4PdZP2smBhdyeW2NaDxIbrG0gCg0FQ/
IHARzyYe9NBnevTU+Q+tr/s=
=Zw3Y
-----END PGP SIGNATURE-----

--==_Exmh_982507576P--
