Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318913AbSHSPXp>; Mon, 19 Aug 2002 11:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318914AbSHSPXp>; Mon, 19 Aug 2002 11:23:45 -0400
Received: from angband.namesys.com ([212.16.7.85]:61831 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S318913AbSHSPXo>; Mon, 19 Aug 2002 11:23:44 -0400
Date: Mon, 19 Aug 2002 19:27:42 +0400
From: Oleg Drokin <green@namesys.com>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       reiserfs-dev@namesys.com, viro@math.psu.edu
Subject: Re: Need more symbols to be exported out of kernel
Message-ID: <20020819192742.A19821@namesys.com>
References: <20020819184208.A11022@namesys.com> <20020819155226.A26430@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20020819155226.A26430@infradead.org>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Mon, Aug 19, 2002 at 03:52:26PM +0100, Christoph Hellwig wrote:

> >    remove_suid
> trivial inline,  either move it to a header or copy & paste.

Moving to header file trned out to be not that trivial ;)
So I just exported it as it is, since it never was inline desplite
the definition.
Ans I hate duplicating code as it will become maintenance nightmare
later.

Ok, here is first draft of the patch, any issues?

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.748   -> 1.749  
#	      kernel/ksyms.c	1.60    -> 1.61   
#	        mm/filemap.c	1.67    -> 1.68   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/08/19	green@angband.namesys.com	1.749
# export generic_osync_inode,block_commit_write, remove_suid
# --------------------------------------------
#
diff -Nru a/kernel/ksyms.c b/kernel/ksyms.c
--- a/kernel/ksyms.c	Mon Aug 19 19:24:31 2002
+++ b/kernel/ksyms.c	Mon Aug 19 19:24:31 2002
@@ -215,6 +215,7 @@
 EXPORT_SYMBOL(generic_cont_expand);
 EXPORT_SYMBOL(cont_prepare_write);
 EXPORT_SYMBOL(generic_commit_write);
+EXPORT_SYMBOL(block_commit_write);
 EXPORT_SYMBOL(block_truncate_page);
 EXPORT_SYMBOL(generic_block_bmap);
 EXPORT_SYMBOL(generic_file_read);
@@ -531,6 +532,8 @@
 EXPORT_SYMBOL(is_bad_inode);
 EXPORT_SYMBOL(event);
 EXPORT_SYMBOL(brw_page);
+EXPORT_SYMBOL(generic_osync_inode);
+EXPORT_SYMBOL(remove_suid);
 
 #ifdef CONFIG_UID16
 EXPORT_SYMBOL(overflowuid);
diff -Nru a/mm/filemap.c b/mm/filemap.c
--- a/mm/filemap.c	Mon Aug 19 19:24:31 2002
+++ b/mm/filemap.c	Mon Aug 19 19:24:31 2002
@@ -2886,7 +2886,7 @@
 	return page;
 }
 
-inline void remove_suid(struct inode *inode)
+void remove_suid(struct inode *inode)
 {
 	unsigned int mode;
 

Bye,
    Oleg
