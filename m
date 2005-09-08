Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751334AbVIHNO0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbVIHNO0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 09:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbVIHNO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 09:14:26 -0400
Received: from pilet.ens-lyon.fr ([140.77.167.16]:60907 "EHLO
	relaissmtp.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S1751334AbVIHNOZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 09:14:25 -0400
Date: Thu, 8 Sep 2005 15:12:36 +0200
From: Benoit Boissinot <bboissin@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-mm2
Message-ID: <20050908131236.GB12411@ens-lyon.fr>
Reply-To: benoit.boissinot@ens-lyon.org
References: <20050908053042.6e05882f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050908053042.6e05882f.akpm@osdl.org>
X-Sieve: CMU Sieve 2.2
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/05, Andrew Morton <akpm@osdl.org> wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13/2.6.13-mm2/
> 

>  git-cifs.patch

it adds a new compilation warning with gcc-4:
fs/cifs/cifsglob.h:335: warning: type qualifiers ignored on function
return type

The following patch fixes it (removes the const qualifier)

Signed-off-by: Benoit Boissinot <benoit.boissinot@ens-lyon.org>


--- ./fs/cifs/cifsglob.h	2005-09-08 14:50:34.000000000 +0200
+++ ./fs/cifs/cifsglob.h.new	2005-09-08 15:02:50.000000000 +0200
@@ -331,7 +331,7 @@ CIFS_SB(struct super_block *sb)
 	return sb->s_fs_info;
 }
 
-static inline const char CIFS_DIR_SEP(const struct cifs_sb_info *cifs_sb)
+static inline char CIFS_DIR_SEP(const struct cifs_sb_info *cifs_sb)
 {
 	if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_POSIX_PATHS)
 		return '/';
