Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750840AbWDSG4k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750840AbWDSG4k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 02:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750838AbWDSG4k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 02:56:40 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:10630 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1750824AbWDSG4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 02:56:39 -0400
Message-Id: <200604190656.k3J6uSGW010288@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: casey@schaufler-ca.com, James Morris <jmorris@namei.org>,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       fireflier-devel@lists.sourceforge.net
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks 
In-Reply-To: Your message of "Wed, 19 Apr 2006 02:40:25 EDT."
             <CD11FD59-4E2E-4AD7-9DD0-5811CE792B24@mac.com> 
From: Valdis.Kletnieks@vt.edu
References: <20060419014857.35628.qmail@web36606.mail.mud.yahoo.com>
            <CD11FD59-4E2E-4AD7-9DD0-5811CE792B24@mac.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1145429788_10003P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 19 Apr 2006 02:56:28 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1145429788_10003P
Content-Type: text/plain; charset=us-ascii

On Wed, 19 Apr 2006 02:40:25 EDT, Kyle Moffett said:
> Perhaps the SELinux model should be extended to handle (dir-inode,
> path-entry) pairs.  For example, if I want to protect the /etc/shadow
> file regardless of what tool is used to safely modify it, I would set

Some of us think that the tools can protect /etc/shadow just fine on their
own, and are concerned with rogue software that abuses /etc/shadow without
bothering to safely modify it..

> up security as follows:
> 
> o  Protect the "/" and "/etc" directory inodes as usual under SELinux  
> (with attributes on directory inodes).
> o  Create pairs with (etc_inode,"shadow") and (etc_inode,"gshadow")  
> and apply security attributes to those potentially nonexistent pairs.

*bzzt* wrong.  Why should "gshadow" matter? (Think carefully about what
happens when a setUID program gets exploited and used to scribble on /etc/shadow -
black hats rarely bother to do locking and other such niceties....)

> I'm not terribly familiar with the exact internal semantics of
> SELinux, but that should provide a 90% solution (it fixes bind mounts

90% doesn't give the security guys warm-and-fuzzies....

> and namespaces).  The remaining 2 issues are hardlinks and fd-
> passing.  For hardlinks you don't care about other links to that
> data, you're concerned with protecting a particular filesystem
> location, not particular contents, so you just need to prevent _new_
> hardlinks to a protected (dir_inode, path_elem) pair, which doesn't 
> seem very hard.

It's not. include/linux/security.h:

 * @inode_link:
 *      Check permission before creating a new hard link to a file.
 *      @old_dentry contains the dentry structure for an existing link to the file.
 *      @dir contains the inode structure of the parent directory of the new link.
 *      @new_dentry contains the dentry structure for the new link.
 *      Return 0 if permission is granted.

>                 For fd-passing, I don't know what to do.  Perhaps  
> nothing.

include/linux/security.h:

 * @file_receive:
 *      This hook allows security modules to control the ability of a process
 *      to receive an open file descriptor via socket IPC.
 *      @file contains the file structure being received.
 *      Return 0 if permission is granted.

Already a solved problem.



--==_Exmh_1145429788_10003P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFERd8ccC3lWbTT17ARAvPtAJ4uGqjuSkQBG6/lYzieZkwWfjnGkwCfYe0T
0sASB6BI4hCWt0TyRA+rMgI=
=4mov
-----END PGP SIGNATURE-----

--==_Exmh_1145429788_10003P--
