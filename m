Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315873AbSEGP2Z>; Tue, 7 May 2002 11:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315875AbSEGP2Y>; Tue, 7 May 2002 11:28:24 -0400
Received: from 216-42-72-144.ppp.netsville.net ([216.42.72.144]:10167 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S315873AbSEGP2W>; Tue, 7 May 2002 11:28:22 -0400
Subject: Re: [reiserfs-dev] [BK] [2.4] Reiserfs changeset 2 out of 4, please
	apply.
From: Chris Mason <mason@suse.com>
To: Hans Reiser <reiser@namesys.com>
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com
In-Reply-To: <200205071505.g47F5iE04039@namesys.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 07 May 2002 11:27:32 -0400
Message-Id: <1020785252.32097.165.camel@tiny>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-05-07 at 11:05, Hans Reiser wrote:
> Hello!
> 
>  You can get this changeset from bk://thebsh.namesys.com/bk/reiser3-linux-2.4
> 
>  This changeset are cleaning up reiserfscode, removes stale comments, and
>  rewrites some "borrowed" functions so that all of the code in reiserfs subdir
>  should now only belong to NAMESYS.

It is the end of a release cycle on a stable kernel with huge changes to
the IDE layer, and we have at least one unconfirmed report of problems
with reiserfs+IDE after a crash.

This is not the right time to send in cleanups like this, especially
when they bits as useless as the stuff below.  #1, #2 and #4 look like
valid fixes.  #3 should probably be mixed with the iput deadlock fix
like Oleg did in 2.5, and should wait until after 2.4.19.

-chris

@@ -957,6 +875,7 @@
     int windex ;
     struct reiserfs_transaction_handle th ;
     int jbegin_count = JOURNAL_PER_BALANCE_CNT * 3; 
+    time_t ctime;
 
 
     if (S_ISDIR(inode->i_mode))
@@ -984,7 +903,8 @@
     }
 
     inode->i_nlink++;
-    inode->i_ctime = CURRENT_TIME;
+    ctime = CURRENT_TIME;
+    inode->i_ctime = ctime;
     reiserfs_update_sd (&th, inode);
 
     atomic_inc(&inode->i_count) ;
@@ -1037,14 +957,6 @@
 }

