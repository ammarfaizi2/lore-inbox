Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932529AbWCWDmt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932529AbWCWDmt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 22:42:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751036AbWCWDmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 22:42:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:214 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751121AbWCWDmt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 22:42:49 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>, stable@vger.kernel.org
Date: Thu, 23 Mar 2006 14:41:16 +1100
Message-Id: <1060323034116.13086@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: [PATCH] Fix bug: BIO_RW_BARRIER requests to md/raid1 hang.
References: <20060323143936.13067.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following fixes a rather embarassing bug in 2.6.16, and so should
go into 2.6.16.1, and 2.6.16-rc1.
Thanks,
NeilBrown


### Comments for Changeset

Both R1BIO_Barrier and R1BIO_Returned are 4 !!!!

This means that barrier requests don't get returned (i.e. b_endio
called) because it looks like they already have been.


Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./include/linux/raid/raid1.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff ./include/linux/raid/raid1.h~current~ ./include/linux/raid/raid1.h
--- ./include/linux/raid/raid1.h~current~	2006-03-23 13:46:27.000000000 +1100
+++ ./include/linux/raid/raid1.h	2006-03-23 14:36:53.000000000 +1100
@@ -130,6 +130,6 @@ struct r1bio_s {
  * with failure when last write completes (and all failed).
  * Record that bi_end_io was called with this flag...
  */
-#define	R1BIO_Returned 4
+#define	R1BIO_Returned 6
 
 #endif
