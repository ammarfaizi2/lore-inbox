Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261668AbUENQfj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261668AbUENQfj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 12:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261672AbUENQfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 12:35:38 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:54487 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S261668AbUENQf3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 12:35:29 -0400
Date: Fri, 14 May 2004 18:33:55 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: "Sergey S. Kostyliov" <rathamahata@php4.ru>
Cc: Will Dyson <will_dyson@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] befs (1/5): LBD support
Message-ID: <20040514163355.GC23863@wohnheim.fh-wedel.de>
References: <200405132232.09816.rathamahata@php4.ru> <40A4E432.4020202@pobox.com> <200405142009.36776.rathamahata@php4.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200405142009.36776.rathamahata@php4.ru>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 May 2004 20:09:36 +0400, Sergey S. Kostyliov wrote:
> On Friday 14 May 2004 19:22, Will Dyson wrote:
> > 
> >   Are you interested in taking over official maintainership?
> 
> Yes, I am interested. How do you like this patch?

Good to know.  How do you like this patch?

Jörn

-- 
A quarrel is quickly settled when deserted by one party; there is
no battle unless there be two.
-- Seneca


Simply thinko:
inode->i_flags should never contain fs-specific flags.  In fact, it doesn't;
the checks against it cause "chattr +T" to be useless for ext[23].  Same
bug was in befs as well.

 linuxvfs.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


--- linux-2.6.5cow/fs/befs/linuxvfs.c~befs_inode_flags	2004-04-27 16:34:51.000000000 +0200
+++ linux-2.6.5cow/fs/befs/linuxvfs.c	2004-04-27 16:48:54.000000000 +0200
@@ -376,7 +376,7 @@
 	befs_ino->i_attribute = fsrun_to_cpu(sb, raw_inode->attributes);
 	befs_ino->i_flags = fs32_to_cpu(sb, raw_inode->flags);
 
-	if (S_ISLNK(inode->i_mode) && !(inode->i_flags & BEFS_LONG_SYMLINK)) {
+	if (S_ISLNK(inode->i_mode) && !(befs_ino->i_flags & BEFS_LONG_SYMLINK)){
 		inode->i_size = 0;
 		inode->i_blocks = befs_sb->block_size / VFS_BLOCK_SIZE;
 		strncpy(befs_ino->i_data.symlink, raw_inode->data.symlink,
