Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267186AbUIODln@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267186AbUIODln (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 23:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267184AbUIODln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 23:41:43 -0400
Received: from [82.154.233.47] ([82.154.233.47]:20372 "EHLO
	puma-vgertech.no-ip.com") by vger.kernel.org with ESMTP
	id S267186AbUIODlS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 23:41:18 -0400
Message-ID: <4147B9E0.1090306@vgertech.com>
Date: Wed, 15 Sep 2004 04:41:20 +0100
From: Nuno Silva <nuno.silva@vgertech.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040912)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Jochen Bern <bern@ti.uni-trier.de>, linux-kernel@vger.kernel.org
Subject: Re: procfs and chroot() ... ?
References: <414649B5.4000701@ti.uni-trier.de> <20040914025300.GG23987@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20040914025300.GG23987@parcelfarce.linux.theplanet.co.uk>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

viro@parcelfarce.linux.theplanet.co.uk wrote:
| On Tue, Sep 14, 2004 at 03:30:29AM +0200, Jochen Bern wrote:
|
|>I'm trying to chroot() a server that needs to read one readonly pseudo
|>file from /proc . I tried to pinpoint my options to do so ...
|>
|>-- The alternative to accessing this one pseudo file would be to grant
|>   the server access to /dev/kmem ... NOT ... ANY ... BETTER!! 8-}
|>-- Mounting two procfs instances (one normal, one inside the chroot())
|>   and setting restrictive permissions on the latter makes identical
|>   changes to the former. (I assume that'ld be the same for ACLs?)
|>-- Deploying SELinux ... will have to do a good deal of reading to
|>   even find out what'ld be involved in that ...
|>-- Mounting a "second" procfs, chroot()ing into the exact subdir the
|>   file is in, and mounting non-procfs stuff (like the etc dir with the
|>   configs) *over* the sub-subdirs (ARGH!) would *happen* to rid me of
|>   all *writable* pseudo files, but still provide read access to way
|>   more info that I'ld want to provide to the server ...
|>(- I'll try to Use The Source (tm) so that the server will not close the
|>   pseudo file, and does the chroot() itself after opening it, but let's
|>   assume for the sake of the argument that I won't succeed in that.)
|
|
| Egads...
|
| mount --bind /proc/whatever/the/fsck/you/want \
| 	/home/jail/wherever/the/fsck/you/want/to/see/it
|
| (assuming that jail is in /home/jail and "mountpoint" exists).

Jochen,
you can also --bind only one file. But you must create the file first:

# mkdir /var/jails/jail1/proc
# touch /var/jails/jail1/proc/cpuinfo
# mount --bind /proc/cpuinfo /var/jails/jail1/proc/cpuinfo

Regards,
Nuno Silva
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBR7ngOPig54MP17wRAuL9AKCnrrHSuAxGZTz0P53JthkMIF9wHgCeOMam
kv9QDqkpnAqB+XzVcTKNyIo=
=lJiN
-----END PGP SIGNATURE-----
