Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262303AbUKVSJp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262303AbUKVSJp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 13:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262298AbUKVSGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 13:06:38 -0500
Received: from locomotive.csh.rit.edu ([129.21.60.149]:44078 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S262241AbUKVSEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 13:04:15 -0500
Message-ID: <41A22A2D.1000708@suse.com>
Date: Mon, 22 Nov 2004 13:04:29 -0500
From: Jeff Mahoney <jeffm@suse.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>,
       Jeff Mahoney <jeffm@suse.com>
Subject: Re: [PATCH 2/5] selinux: adds a private inode operation
References: <20041121001318.GC979@locomotive.unixthugs.org> <1101145050.18273.68.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1101145050.18273.68.camel@moss-spartans.epoch.ncsc.mil>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Bogosity: No, tests=bogofilter, spamicity=0.000000, version=0.92.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Stephen Smalley wrote:
| On Sat, 2004-11-20 at 19:13, Jeffrey Mahoney wrote:
|
|>diff -ruNpX dontdiff linux-2.6.9/security/selinux/hooks.c
linux-2.6.9.selinux/security/selinux/hooks.c
|>--- linux-2.6.9/security/selinux/hooks.c	2004-11-19 14:40:58.000000000
- -0500
|>+++ linux-2.6.9.selinux/security/selinux/hooks.c	2004-11-20
17:11:22.000000000 -0500
|>@@ -740,6 +740,15 @@ static int inode_doinit_with_dentry(stru
|> 	if (isec->initialized)
|> 		goto out;
|>
|>+	if (opt_dentry && opt_dentry->d_parent &&
opt_dentry->d_parent->d_inode) {
|>+		struct inode_security_struct *pisec =
opt_dentry->d_parent->d_inode->i_security;
|>+		if (pisec->inherit) {
|>+			isec->sid = pisec->sid;
|>+			isec->initialized = 1;
|>+			goto out;
|>+		}
|>+	}
|>+
|> 	down(&isec->sem);
|> 	hold_sem = 1;
|> 	if (isec->initialized)
|
|
| Actually, isn't this code unnecessary given that patch 3/5 ensures that
| the selinux_inode_mark_private() hook is called from
| reiserfs_new_inode() on the new inode if the directory is private?  I
| think that eliminates the need to perform this test and inheritance in
| inode_doinit, which is called by the d_instantiate.
|

Yes, you're right. The isec->initialized check means that code never
gets executed.

- -Jeff

- --
Jeff Mahoney
SuSE Labs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBoiomLPWxlyuTD7IRAu3TAKCJK4LycKusauFJ/QPUIJSC3hqzaACgmsPD
Gte20LrcLzyB6Yjc83JJmr0=
=5sgF
-----END PGP SIGNATURE-----

-- 
Jeff Mahoney
SuSE Labs
