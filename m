Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265540AbUFIFYk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265540AbUFIFYk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 01:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265542AbUFIFYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 01:24:40 -0400
Received: from vivaldi.madbase.net ([81.173.6.10]:489 "HELO
	vivaldi.madbase.net") by vger.kernel.org with SMTP id S265540AbUFIFYj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 01:24:39 -0400
Message-ID: <54574.67.8.218.172.1086758675.squirrel@webmail.krabbendam.net>
In-Reply-To: <40BD2841.2050509@serice.net>
References: <40BD2841.2050509@serice.net>
Date: Wed, 9 Jun 2004 01:24:35 -0400 (EDT)
Subject: Re: [PATCH] iso9660 Inodes Anywhere and NFS
From: "Eric Lammerts" <eric@lammerts.org>
To: "Paul Serice" <paul@serice.net>
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


"Paul Serice" <paul@serice.net> wrote:
> The inode number scheme was also changed.  Continuing to use the byte
> offset would have resulted in non-unique inodes in many common
> situations, but because the inode number no longer plays any role in
> reading the meta-data off the disk, I was free to set the inode number
> to some unique characteristic of the file.  I have chosen to use the
> block offset which is also 32-bits wide.

But what about 0-byte files? The block offset could be the same for all
0-byte files, or worse, it could be the same as the block offset of a
non-0-byte file.

I don't know if this has been mentioned before, but since a directory
record is always 34 bytes or bigger, why not simply divide the directory
record byte offset by 32? I.e.,

-   inode_number = (bh->b_blocknr << bufbits) + offset;
+   inode_number = (bh->b_blocknr << (bufbits - 5)) + (offset >> 5);

Eric

