Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269429AbUINPnJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269429AbUINPnJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 11:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269440AbUINPl0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 11:41:26 -0400
Received: from locomotive.csh.rit.edu ([129.21.60.149]:6498 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S269422AbUINPgi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 11:36:38 -0400
Message-ID: <414710B7.5080709@suse.com>
Date: Tue, 14 Sep 2004 11:39:35 -0400
From: Jeff Mahoney <jeffm@suse.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] ReiserFS v3 I/O error handling
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Bogosity: No, tests=bogofilter, spamicity=0.000000, version=0.92.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hey all -

One of the most common complaints I've heard about ReiserFS is how
graceless it is in handling critical I/O errors.

ext[23] can handle I/O errors anywhere, with the results being up to the
system admin to determine: continue, go read only, or panic.

ReiserFS doesn't offer the admin any such choice, instead panicking on
any I/O error in the journal.

I've posted four patches at:
ftp://ftp.suse.com/pub/people/jeffm/reiserfs/kernel-v2.6/io-error/

Against 2.6.9-rc2:
* reiserfs-cleanup-buffer-heads.diff
	- Cleans up handling of buffer head bitfields - uses
	  the kernel supplied FNS_BUFFER macros instead.
* reiserfs-cleanup-sb-journal.diff
	- Cleans up accessing of the journal structure, prefering
~           to create a temporary variable in functions that access
~           the journal structure non-trivially. Should make 0 difference
~           at compile time.
* reiserfs-write-lock.diff
	- Fixes two missing reiserfs_write_unlock() calls on error paths
~           that are unrelated to the last patch.
* reiserfs-io-error-handling.diff
	- Allows ReiserFS to gracefully handle I/O errors in critical
	  code paths. The admin has the option to go read-only or panic.
	  Since ReiserFS has no option to ignore the use of the journal,
~          the "continue" method is not enabled.

These patches have seen a lot of testing in the SuSE Linux Enterprise
Server 9 kernel, and are considered ready for mainline.

Hans - please take a look.

- -Jeff

[Resent: The patches initially were attached, and I suspect they were
too large to make it onto the list.]

- --
Jeff Mahoney
SuSE Labs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBRxC3LPWxlyuTD7IRAmyYAJ4t2zN0ZnGMWp4FV8CIVQYVcuOhqACfdMlJ
rSdILv0XFfcWh7lyCbQPyAY=
=iTX3
-----END PGP SIGNATURE-----
