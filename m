Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261445AbVAXF6M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261445AbVAXF6M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 00:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261446AbVAXF6L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 00:58:11 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:5300 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261445AbVAXF6H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 00:58:07 -0500
Message-ID: <41F48E70.5090200@comcast.net>
Date: Mon, 24 Jan 2005 00:58:08 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: LSM hook addition?
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Can someone point me to documentation or give me a small patch to add an
LSM hook to kernel 2.6.10 in fs/namei.c at line 1986:

        new_dentry = lookup_create(&nd, 0);
        error = PTR_ERR(new_dentry);
        if (!IS_ERR(new_dentry)) {
                error = security_inode_make_hardlink(old_nd); // ADD
                error = vfs_link(old_nd.dentry, nd.dentry->d_inode,
new_dentry);

I believe this would be sufficient to finish an LSM module to implement
linking restrictions from GrSecurity.  I did Symlinks in an LSM module,
but haven't tested it out; it's purely academic.  I guess adding an LSM
hook would be an interesting academic experience; I'd enjoy examining a
patch that adds this hook, and then trying to add another hook myself.

The hook here would be used (in my academic exploration) to prevent hard
links from being created to files you don't own, unless you're root.

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB9I5vhDd4aOud5P8RAmNNAJ44riGGJ6CP1sCC/CHfIJiD0u6augCeNFEI
PjjmHxipSD2wRyv4z+JElig=
=VDIo
-----END PGP SIGNATURE-----
