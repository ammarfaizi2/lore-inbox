Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265909AbUFXXPG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265909AbUFXXPG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 19:15:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265903AbUFXXPF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 19:15:05 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:7586 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S265962AbUFXXOm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 19:14:42 -0400
Message-ID: <40DB605D.6000409@comcast.net>
Date: Thu, 24 Jun 2004 19:14:37 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 0.7 (X11/20040623)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Collapse ext2 and 3 please
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I know this has been mentioned before, or at least I *hope* it has.

ext2 and ext3 are essentially the same, aren't they?  I'm looking at a
diff, and other than ext2->ext3, I'm seeing things like:

- -              mark_inode_dirty(inode);
+              ext3_mark_inode_dirty(handle, inode);

and thinking

- -              mark_inode_dirty(inode);
+#ifdef CONFIG_EXT2_JOURNALED
+              if (fs->journaled)
+                 extjnl_mark_inode_dirty(handle, inode);
+              else
+#endif
+                 mark_inode_dirty(inode);

would have been so much more appropriate.  I see entire functions that
are dropped and added; the dropped can stay, the added can be added,
they can be used conditionally.  I also see mostly code that just was
copied verbatim, or was s/EXT2/EXT3/ or s/ext2/ext3/ .  That's just not
appropriate.

The ext2 driver can even load up ext3 partitions without using the
journal, if it still behaves like it did in 2.4.20.  I say collapse them
in on eachother.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFA22BbhDd4aOud5P8RAqsqAJ9hVAgMnKIHzXNx1NIs7cwYbLvfrwCfU8D2
Q+NLucNYfQRft3Fd1Q0HpPE=
=Vmkg
-----END PGP SIGNATURE-----
