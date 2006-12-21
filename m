Return-Path: <linux-kernel-owner+w=401wt.eu-S1423036AbWLUTLQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423036AbWLUTLQ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 14:11:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423038AbWLUTLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 14:11:16 -0500
Received: from mx1.redhat.com ([66.187.233.31]:34973 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423033AbWLUTLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 14:11:15 -0500
Message-ID: <458ADC45.3050308@redhat.com>
Date: Thu, 21 Dec 2006 13:11:01 -0600
From: Eric Sandeen <sandeen@redhat.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Randy Dunlap <randy.dunlap@oracle.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ext4 development <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH] ext2: skip pages past number of blocks in ext2_find_entry
References: <458AD954.7020904@redhat.com> <20061221110549.bf336c02.randy.dunlap@oracle.com>
In-Reply-To: <20061221110549.bf336c02.randy.dunlap@oracle.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap wrote:

> Please don't hide the goto; un-indent 1 tab stop.
Whoops, thanks Randy - it wasn't intentional. :)

Signed-off-by: Eric Sandeen <sandeen@redhat.com>

Index: linux-2.6.19/fs/ext2/dir.c
===================================================================
--- linux-2.6.19.orig/fs/ext2/dir.c
+++ linux-2.6.19/fs/ext2/dir.c
@@ -368,6 +368,14 @@ struct ext2_dir_entry_2 * ext2_find_entr
 		}
 		if (++n >= npages)
 			n = 0;
+		/* next page is past the blocks we've got */
+		if (unlikely(n > (dir->i_blocks >> (PAGE_CACHE_SHIFT - 9)))) {
+			ext2_error(dir->i_sb, __FUNCTION__,
+				"dir %lu size %lld exceeds block count %llu",
+				dir->i_ino, dir->i_size,
+				(unsigned long long)dir->i_blocks);
+			goto out;
+		}
 	} while (n != start);
 out:
 	return NULL;


