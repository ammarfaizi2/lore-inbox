Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291706AbSBNPFU>; Thu, 14 Feb 2002 10:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291712AbSBNPFL>; Thu, 14 Feb 2002 10:05:11 -0500
Received: from angband.namesys.com ([212.16.7.85]:5249 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S291706AbSBNPFC>; Thu, 14 Feb 2002 10:05:02 -0500
Date: Thu, 14 Feb 2002 18:05:01 +0300
From: Oleg Drokin <green@namesys.com>
To: Sebastian Dr?ge <sebastian.droege@gmx.de>
Cc: reiserfs-list-subscribe@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: Reiserfs Corruption with 2.5.5-pre1
Message-ID: <20020214180501.A1755@namesys.com>
In-Reply-To: <20020214155716.3b810a91.sebastian.droege@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
In-Reply-To: <20020214155716.3b810a91.sebastian.droege@gmx.de>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

On Thu, Feb 14, 2002 at 03:57:16PM +0100, Sebastian Dr?ge wrote:

> after starting GNOME with 2.5.5-pre1 with reiserfs on the root partition I get several funny-named files in ~/.gnome/accels and I can't start some programms anymore... When I reboot into 2.4.17 again everything works right and this files are gone again

Hm. I was not able to run 2.5.5-pre1 with reiserfs support without patch
attached at all.

> This only happens with any kernel since 2.5.4-pre* or so and it happens everytime I try to start GNOME under such kernel.

Have you tried to run reiserfsck on your partition after 2.5.4-pre1
Run reiserfsck and never use 2.5.4-pre1 or earlier 2.5 kernels.
if that won't help, we are interested to hear.

Bye,
    Oleg

--k+w/mQv8wyuph6w0
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
 

--k+w/mQv8wyuph6w0--
