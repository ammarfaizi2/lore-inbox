Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261543AbUKWTaJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261543AbUKWTaJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 14:30:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261534AbUKWT2F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 14:28:05 -0500
Received: from locomotive.csh.rit.edu ([129.21.60.149]:13888 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S261519AbUKWT0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 14:26:50 -0500
Message-ID: <41A38F10.8000609@suse.com>
Date: Tue, 23 Nov 2004 14:27:12 -0500
From: Jeff Mahoney <jeffm@suse.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>,
       James Morris <jmorris@redhat.com>
Subject: Re: [PATCH 2/5] selinux: adds a private inode operation
References: <20041121001318.GC979@locomotive.unixthugs.org> <1101145050.18273.68.camel@moss-spartans.epoch.ncsc.mil> <41A22A2D.1000708@suse.com> <1101148090.18273.94.camel@moss-spartans.epoch.ncsc.mil> <41A23922.80501@suse.com> <20041122123000.C14339@build.pdx.osdl.net>
In-Reply-To: <20041122123000.C14339@build.pdx.osdl.net>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Bogosity: No, tests=bogofilter, spamicity=0.000000, version=0.92.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Chris Wright wrote:
| * Jeff Mahoney (jeffm@suse.com) wrote:
|
|>Excellent. Thanks. Preliminary testing works as expected (ie: deadlocks
|>don't occur, xattrs/<dir> is removed when owning file is deleted)
|>
|>I've integrated the changes into my patch set. With those issues
|>addressed, would you feel these would be appropriate for inclusion? I
|>suspect you may have gotten questions as many interested parties in this
|>feature working as I have.
|
|
| Why add extra hook, when this could be done in VFS with i_flags?

Sure, it could be done w/ an i_flags bit. However, since it's explicitly
related to the security infrastructure, I think it's more appropriate
there. There's no change in the size of inode_security_struct, and the
addition of the deref is trivial given how many other places in the
file-io path use the same call table. That said, I'll change it to use
whatever ends up being agreed upon. I'm just looking to get selinux to
not call xattr routines on reiserfs-internal files/directories.

- -Jeff

- --
Jeff Mahoney
SuSE Labs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBo48QLPWxlyuTD7IRAiIlAJ9wN7JPywCVz/UVJ1dVTM1kQphPRQCgoK8J
TMDL9KrBABk49cbfN7AcoOA=
=6RPR
-----END PGP SIGNATURE-----
