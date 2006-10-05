Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750866AbWJETSY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750866AbWJETSY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 15:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750860AbWJETSY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 15:18:24 -0400
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:42972 "EHLO
	pne-smtpout1-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S1750826AbWJETSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 15:18:23 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Eric Sandeen <esandeen@redhat.com>
Subject: Re: Merge window closed: v2.6.19-rc1
References: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org>
From: Peter Osterlund <petero2@telia.com>
Date: 05 Oct 2006 21:17:50 +0200
In-Reply-To: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org>
Message-ID: <m38xjuo9lt.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> Ok, it's two weeks since v2.6.18, and as a result I've cut a -rc1 release.
...
> so please give it a good testing, and let's see if there are any 
> regressions.

The UDF filesystem can't be mounted in read-write mode any more,
because of forgotten braces.

Signed-off-by: Peter Osterlund <petero2@telia.com>
---

 fs/udf/super.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/fs/udf/super.c b/fs/udf/super.c
index 1d3b5d2..1aea6a4 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -1621,9 +1621,10 @@ #endif
 		goto error_out;
 	}
 
-	if (UDF_SB_PARTFLAGS(sb, UDF_SB_PARTITION(sb)) & UDF_PART_FLAG_READ_ONLY)
+	if (UDF_SB_PARTFLAGS(sb, UDF_SB_PARTITION(sb)) & UDF_PART_FLAG_READ_ONLY) {
 		printk("UDF-fs: Partition marked readonly; forcing readonly mount\n");
 		sb->s_flags |= MS_RDONLY;
+	}
 
 	if ( udf_find_fileset(sb, &fileset, &rootdir) )
 	{

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
