Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288233AbSACHTC>; Thu, 3 Jan 2002 02:19:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288231AbSACHSn>; Thu, 3 Jan 2002 02:18:43 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:24836 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S288225AbSACHSh>; Thu, 3 Jan 2002 02:18:37 -0500
Date: Thu, 3 Jan 2002 10:18:30 +0300
From: Oleg Drokin <green@namesys.com>
To: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com
Subject: [PATCH] corrupted reiserfs may cause kernel to panic on lookup() sometimes.
Message-ID: <20020103101830.A2610@namesys.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

    Certain disk corruptions and i/o errors may cause lookup() to panic, which is wrong.
    This patch fixes the problem.
    Please apply.

Bye,
    Oleg

--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="corrupted_fs_panic_on_lookup_fix.diff"

--- linux/fs/reiserfs/namei.c.orig	Tue Dec 25 16:27:27 2001
+++ linux/fs/reiserfs/namei.c	Tue Dec 25 16:29:13 2001
@@ -309,9 +309,10 @@
 
     while (1) {
 	retval = search_by_entry_key (dir->i_sb, &key_to_search, path_to_entry, de);
-	if (retval == IO_ERROR)
-	    // FIXME: still has to be dealt with
-	    reiserfs_panic (dir->i_sb, "zam-7001: io error in " __FUNCTION__ "\n");
+	if (retval == IO_ERROR) {
+	    reiserfs_warning ("zam-7001: io error in " __FUNCTION__ "\n");
+	    return IO_ERROR;
+	}
 
 	/* compare names for all entries having given hash value */
 	retval = linear_search_in_dir_item (&key_to_search, de, name, namelen);

--ZPt4rx8FFjLCG7dd--
