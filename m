Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262469AbTBERbA>; Wed, 5 Feb 2003 12:31:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262780AbTBERbA>; Wed, 5 Feb 2003 12:31:00 -0500
Received: from [195.223.140.107] ([195.223.140.107]:17280 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S262469AbTBERa4>;
	Wed, 5 Feb 2003 12:30:56 -0500
Date: Wed, 5 Feb 2003 18:40:21 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: lm@bitmover.com
Cc: linux-kernel@vger.kernel.org
Subject: 2.5 changeset 1.952.4.2 corrupt in fs/jfs/inode.c
Message-ID: <20030205174021.GE19678@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Larry,

If you apply all changeset in order starting from 2.5.59 until 1.952.4.2
you should get a fs/jfs/inode.c like this:

void jfs_truncate(struct inode *ip)
{
	jFYI(1, ("jfs_truncate: size = 0x%lx\n", (ulong) ip->i_size));

	block_truncate_page(ip->i_mapping, ip->i_size, jfs_get_block);
	^^^^^^^^^^^^^^^^^^^

but the changeset 1.952.4.2 is the below one and it shows:

@@ -378,7 +377,7 @@

 void jfs_truncate(struct inode *ip)
 {
-       jFYI(1, ("jfs_truncate: size = 0x%lx\n", (ulong) ip->i_size));
+       jfs_info("jfs_truncate: size = 0x%lx", (ulong) ip->i_size);

        nobh_truncate_page(ip->i_mapping, ip->i_size);
	^^^^^^^^^^^^^^^^^^

so it thinks the function is called nobh_truncate_page and not
block_truncate_page.

Note, I'm using my own GPL software to checkout from the bitkeeper
servers (I don't want to miss the additional information stored in
proprietary form inside the bitkepper database and so I'm extracting it
all and storing it in a open manner locally, in a complete structured
form, they're live classes dumped to disk, not like the monolithic
patches in the cset/ directory where it's not trivial to manage all the
metadata to see all the evolution of a certain file or subsystem by
writing a few more lines of code that loads and use those classes) so it
could be my bug and not a bug in bitkeeper, no idea if it's reproducible
with bitkeeper.  I hope I'm not wasting your time and that it's not a
bug from my part ;)

btw, the changeset would apply anyways despite the corrupted patch, if
I'd use the default fuzz level of patch, but still it looks corrupted
and a bug that needs fixing (either from my part or your part) so I'm
not going to ignore it even if it doesn't literally reject.

See:

	http://linux.bkbits.net:8080/linux-2.5/patch@1.952.4.2?nav=index.html|ChangeSet@-4w|cset@1.952.4.2

I'd appreciate if you could check why bitkeeper thinks such function is
nobh_truncate_page and not block_truncate_page as my GPL software
pretends while it checkouts all the changesets from the bitkeeper
servers.

Thanks,

Andrea
