Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289564AbSBKN7F>; Mon, 11 Feb 2002 08:59:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289571AbSBKN6z>; Mon, 11 Feb 2002 08:58:55 -0500
Received: from angband.namesys.com ([212.16.7.85]:6784 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S289564AbSBKN6h>; Mon, 11 Feb 2002 08:58:37 -0500
Date: Mon, 11 Feb 2002 16:58:36 +0300
From: Oleg Drokin on behalf of Hans Reiser <reiser@namesys.com>
To: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com
Subject: [PATCH] 2.4 reiserfs fix for truncate to update mtime.
Message-ID: <20020211165836.A1443@namesys.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

   Attached patch fixes a problem where reiserfs fails to correctly
   update mtime after truncate() call in some cases

Bye,
    Oleg

--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="truncate_update_mtime.diff"

--- linus.orig/fs/reiserfs/stree.c Thu, 13 Dec 2001 11:06:51 -0500
+++ linus/fs/reiserfs/stree.c Fri, 01 Feb 2002 13:35:29 -0500
@@ -1700,8 +1700,7 @@
     }
 
     if ( n_file_size == 0 || n_file_size < n_new_file_size ) {
-	pathrelse(&s_search_path);
-	return;
+	goto update_and_out ;
     }
 
     /* Update key to search for the last file item. */
@@ -1754,6 +1753,7 @@
 	    "PAP-5680: truncate did not finish: new_file_size %Ld, current %Ld, oid %d\n",
 	    n_new_file_size, n_file_size, s_item_key.on_disk_key.k_objectid);
 
+update_and_out:
     if (update_timestamps) {
 	// this is truncate, not file closing
 	p_s_inode->i_mtime = p_s_inode->i_ctime = CURRENT_TIME;



--u3/rZRmxL6MmkK24--
