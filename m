Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262300AbUK3T72@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262300AbUK3T72 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 14:59:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262290AbUK3T40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 14:56:26 -0500
Received: from locomotive.csh.rit.edu ([129.21.60.149]:3393 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S262300AbUK3Tyh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 14:54:37 -0500
Message-ID: <41ACD023.4070205@suse.com>
Date: Tue, 30 Nov 2004 14:55:15 -0500
From: Jeff Mahoney <jeffm@suse.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
Cc: Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       James Morris <jmorris@redhat.com>
Subject: Re: 2.6.10-rc2-mm4
References: <20041130095045.090de5ea.akpm@osdl.org> <1101842310.4401.111.camel@moss-spartans.epoch.ncsc.mil> <20041130112903.C2357@build.pdx.osdl.net> <20041130194328.GA28126@infradead.org>
In-Reply-To: <20041130194328.GA28126@infradead.org>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Bogosity: No, tests=bogofilter, spamicity=0.000000, version=0.92.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Christoph Hellwig wrote:
| On Tue, Nov 30, 2004 at 11:29:03AM -0800, Chris Wright wrote:
|
|>My concerns are that the check has to be duplicated in any module,
|>and that thus far we've tried to keep out fs -> module communication,
|>letting vfs do it.  This could at least be fs -> vfs communication,
|>and then either vfs or security framework could check flags and never
|>call into module on fs private objects.
|
|
| (1) an inode beeing private could have much more uses even outside LSM
| (2) it's an awfull lot of code where having a flag is really little code
| (3) there 's lots of room in the inode flags
|
| I can't find anything that speaks for the messy current implementation

I'd agree with this assessment. The original purpose of the private flag
was reiserfs-internal to avoid locking issues with xattrs-on-xattrs.
SELinux just happened to try to use xattrs-on-xattrs from outside the
filesystem. Without being too familiar with selinux, I used the patch
because it "just worked."

Such a VFS-level flag could provide the same functionality while
allowing me to remove the private flag from reiserfs.

- -Jeff

- --
Jeff Mahoney
SuSE Labs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBrNAjLPWxlyuTD7IRAj/lAJ4yZ0zfrDqm+LC4ue8Ph7eA9cQHcgCgpNwX
4q3nWWsm0HOsNvQO9exXvwc=
=1nSR
-----END PGP SIGNATURE-----
