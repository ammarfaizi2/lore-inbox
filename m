Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261971AbUJYPYX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261971AbUJYPYX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 11:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbUJYPYC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 11:24:02 -0400
Received: from nwkea-mail-1.sun.com ([192.18.42.13]:21992 "EHLO
	nwkea-mail-1.sun.com") by vger.kernel.org with ESMTP
	id S261959AbUJYPWT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 11:22:19 -0400
Date: Mon, 25 Oct 2004 11:21:56 -0400
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: [PATCH 25/28] VFS: statfs(64) shouldn't follow last component
 symlink
In-reply-to: <20041025151405.GA1740@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       raven@themaw.net
Message-id: <417D1A14.5010601@sun.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 0.8 (X11/20040918)
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <10987158413464@sun.com> <10987158711277@sun.com>
 <20041025151405.GA1740@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Christoph Hellwig wrote:
> On Mon, Oct 25, 2004 at 10:51:11AM -0400, Mike Waychison wrote:
> 
>>Mount-related userspace tools will require the ability to detect whether what
>>looks like a regular directory is actually a autofs trigger.  To handle this,
>>tools can statfs a given directory and check to see if statfs->f_type ==
>>AUTOFSNG_SUPER_MAGIC before walking into the directory (and causing the a
>>filesystem to automount).
>>
>>To make this happen, we cannot allow statfs to follow_link.
>>
>>NOTE: This may break any userspace that assumes it can statfs across a
>>last-component symlink.  I can't think of any real world breakage however, as
>>mount(8) will drop the real path in /etc/mtab and /proc/mounts will always
>>show the true path.
> 
> 
> Which means it's vetoed.  It's a big change in syscall semantics.  And
> propabably breaks SuS (for statvfs(3) which requires full symlink
> resolution when it just refers to a path on the filesystem.
> 

Ya, I figured that would be the case.   What do folks think about a
lstatfs(64)?

- --
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me,
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBfRoUdQs4kOxk3/MRAgHoAKCApqvkE2hgLAJKXDkLWWJE7BqevgCfQlh9
BxBlFSMUPoo1VyOcntae7Y0=
=rR8G
-----END PGP SIGNATURE-----
