Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288811AbSAEOFC>; Sat, 5 Jan 2002 09:05:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288815AbSAEOEv>; Sat, 5 Jan 2002 09:04:51 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:10509 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S288811AbSAEOEf>; Sat, 5 Jan 2002 09:04:35 -0500
Message-ID: <3C37074A.1020201@namesys.com>
Date: Sat, 05 Jan 2002 17:01:46 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: "Adam J. Richter" <adam@yggdrasil.com>
CC: reiserfs-dev@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: [reiserfs-dev] Patch?: linux-2.5.2-pre8/fs/reiserfs kdev_t compilation fixes
In-Reply-To: <20020105051938.A25230@baldur.yggdrasil.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We'll test and release a patch on ~tuesday.  Right now all programmers 
are on Russian holidays.

Thanks Adam,

Hans


Adam J. Richter wrote:

>	The following patch gets linux-2.5.2-pre8/fs/reiserfs to
>compile.  I suspect that a lot of the conversion back and forth
>between integers and kdev_t that I have accomodated could possibly
>be eliminated by someone who understands the fs/reiserfs better.
>
>	I have not tested this patch in any way.  I only know that
>it compiles.
>
>
>------------------------------------------------------------------------
>
>Only in linux/fs/reiserfs: CVS
>diff -u -r linux-2.5.2-pre8/fs/reiserfs/procfs.c linux/fs/reiserfs/procfs.c
>--- linux-2.5.2-pre8/fs/reiserfs/procfs.c	Fri Jan  4 19:40:37 2002
>+++ linux/fs/reiserfs/procfs.c	Sat Jan  5 05:12:34 2002
>@@ -77,7 +77,7 @@
> 	int len = 0;
> 	struct super_block *sb;
>     
>-	sb = procinfo_prologue( ( kdev_t ) ( int ) data );
>+	sb = procinfo_prologue( to_kdev_t((int)data) );
> 	if( sb == NULL )
> 		return -ENOENT;
> 	len += sprintf( &buffer[ len ], "%s format\twith checks %s\n",
>@@ -134,7 +134,7 @@
> 	struct reiserfs_sb_info *r;
> 	int len = 0;
>     
>-	sb = procinfo_prologue( ( kdev_t ) ( int ) data );
>+	sb = procinfo_prologue( to_kdev_t((int)data) );
> 	if( sb == NULL )
> 		return -ENOENT;
> 	r = &sb->u.reiserfs_sb;
>@@ -214,7 +214,7 @@
> 	int len = 0;
> 	int level;
> 	
>-	sb = procinfo_prologue( ( kdev_t ) ( int ) data );
>+	sb = procinfo_prologue( to_kdev_t((int)data) );
> 	if( sb == NULL )
> 		return -ENOENT;
> 	r = &sb->u.reiserfs_sb;
>@@ -293,7 +293,7 @@
> 	struct reiserfs_sb_info *r = &sb->u.reiserfs_sb;
> 	int len = 0;
>     
>-	sb = procinfo_prologue( ( kdev_t ) ( int ) data );
>+	sb = procinfo_prologue( to_kdev_t((int)data) );
> 	if( sb == NULL )
> 		return -ENOENT;
> 	r = &sb->u.reiserfs_sb;
>@@ -334,7 +334,7 @@
> 	int hash_code;
> 	int len = 0;
>     
>-	sb = procinfo_prologue( ( kdev_t ) ( int ) data );
>+	sb = procinfo_prologue( to_kdev_t((int)data) );
> 	if( sb == NULL )
> 		return -ENOENT;
> 	sb_info = &sb->u.reiserfs_sb;
>@@ -387,7 +387,7 @@
> 	int len = 0;
> 	int exact;
>     
>-	sb = procinfo_prologue( ( kdev_t ) ( int ) data );
>+	sb = procinfo_prologue( to_kdev_t((int)data) );
> 	if( sb == NULL )
> 		return -ENOENT;
> 	sb_info = &sb->u.reiserfs_sb;
>@@ -438,7 +438,7 @@
> 	struct reiserfs_super_block *rs;
> 	int len = 0;
>     
>-	sb = procinfo_prologue( ( kdev_t ) ( int ) data );
>+	sb = procinfo_prologue( to_kdev_t((int)data) );
> 	if( sb == NULL )
> 		return -ENOENT;
> 	r = &sb->u.reiserfs_sb;
>@@ -491,7 +491,7 @@
> 			"prepare_retry: \t%12lu\n",
> 
> 			DJF( s_journal_block ),
>-			DJF( s_journal_dev ) == 0 ? "none" : bdevname( DJF( s_journal_dev ) ), 
>+			DJF( s_journal_dev ) == 0 ? "none" : bdevname( to_kdev_t( DJF( s_journal_dev ) ) ),
> 			DJF( s_journal_dev ),
> 			DJF( s_orig_journal_size ),
> 			DJF( s_journal_trans_max ),
>@@ -578,7 +578,7 @@
> {
> 	return ( sb->u.reiserfs_sb.procdir ) ? create_proc_read_entry
> 		( name, 0, sb->u.reiserfs_sb.procdir, func, 
>-		  ( void * ) ( int ) sb -> s_dev ) : NULL;
>+		  ( void * ) kdev_t_to_nr( sb -> s_dev ) ) : NULL;
> }
> 
> void reiserfs_proc_unregister( struct super_block *sb, const char *name )
>



