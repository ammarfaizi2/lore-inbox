Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291383AbSBNKCF>; Thu, 14 Feb 2002 05:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291355AbSBNKBz>; Thu, 14 Feb 2002 05:01:55 -0500
Received: from angband.namesys.com ([212.16.7.85]:12416 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S291298AbSBNKBj>; Thu, 14 Feb 2002 05:01:39 -0500
Date: Thu, 14 Feb 2002 13:01:38 +0300
From: Oleg Drokin <green@namesys.com>
To: Luigi Genoni <kernel@Expansa.sns.it>
Cc: Alex Riesen <fork0@users.sourceforge.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: reiserfs oops with 2.5.5-pre1 (was: [reiserfs-dev] 2.5.4-pre1:)zero-filled files reiserfs
Message-ID: <20020214130137.A8400@namesys.com>
In-Reply-To: <20020214085059.B5605@namesys.com> <Pine.LNX.4.44.0202141054350.27542-100000@Expansa.sns.it>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0202141054350.27542-100000@Expansa.sns.it>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

On Thu, Feb 14, 2002 at 10:57:13AM +0100, Luigi Genoni wrote:
> Well, with 2.5.5-pre1 i get this oops:
> 
> PAP-14030: direct2indirect: pasted or inserted byte exists in the
> treeinvalid operand: 0000
It means 2.5.2-dj3 or 2.5.3 kernel, you run some time ago,
have damaged your reiserfs filesystem.
Now you have to run reiserfsck --rebuild-tree on that partition.
Also you need attached patch to be able to user reiserfs on 2.5.5-pre1
at all.

Bye,
    Oleg

--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="new_lookup_locking_fix.diff"

--- linux-2.5.5-pre1/fs/reiserfs/namei.c.orig	Thu Feb 14 11:53:09 2002
+++ linux-2.5.5-pre1/fs/reiserfs/namei.c	Thu Feb 14 11:53:17 2002
@@ -344,8 +344,6 @@
     struct reiserfs_dir_entry de;
     INITIALIZE_PATH (path_to_entry);
 
-    reiserfs_check_lock_depth("lookup") ;
-
     if (dentry->d_name.len > REISERFS_MAX_NAME_LEN (dir->i_sb->s_blocksize))
 	return ERR_PTR(-ENAMETOOLONG);
 

--PEIAKu/WMn1b1Hv9--
