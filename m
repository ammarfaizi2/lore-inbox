Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262363AbUKVTKm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262363AbUKVTKm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 14:10:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262315AbUKVTIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 14:08:51 -0500
Received: from locomotive.csh.rit.edu ([129.21.60.149]:38447 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S262353AbUKVTIK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 14:08:10 -0500
Message-ID: <41A23922.80501@suse.com>
Date: Mon, 22 Nov 2004 14:08:18 -0500
From: Jeff Mahoney <jeffm@suse.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>,
       James Morris <jmorris@redhat.com>
Subject: Re: [PATCH 2/5] selinux: adds a private inode operation
References: <20041121001318.GC979@locomotive.unixthugs.org>	 <1101145050.18273.68.camel@moss-spartans.epoch.ncsc.mil>	 <41A22A2D.1000708@suse.com> <1101148090.18273.94.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1101148090.18273.94.camel@moss-spartans.epoch.ncsc.mil>
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
| On Mon, 2004-11-22 at 13:04, Jeff Mahoney wrote:
|
|>Yes, you're right. The isec->initialized check means that code never
|>gets executed.
|
|
| Ok.  How about the untested diff below relative to your patch?  It
| removes the unnecessary code, replaces the unused inherits flag field
| (legacy from earlier code) with a private flag field, does not set the
| SID in selinux_inode_mark_private (leaving it with the unlabeled SID,
| which will ensure that we notice it if it ever reaches a SELinux
| permission check), and modifies SELinux permission checking functions
| and post_create() to test for the private flag and skip SELinux
| processing in that case.  Note that this means that reiserfs should be
| able to use the VFS helpers if desired without interference by SELinux
| when accessing these private inodes.
|

Excellent. Thanks. Preliminary testing works as expected (ie: deadlocks
don't occur, xattrs/<dir> is removed when owning file is deleted)

I've integrated the changes into my patch set. With those issues
addressed, would you feel these would be appropriate for inclusion? I
suspect you may have gotten questions as many interested parties in this
feature working as I have.

- -Jeff

- --
Jeff Mahoney
SuSE Labs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBojkiLPWxlyuTD7IRAoM/AJ9XQ/twgcSTiRGQU1kOp01A2NlhywCfWrvF
/LtguPq+tMjFe1uThpR4fws=
=izmO
-----END PGP SIGNATURE-----
