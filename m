Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030713AbWF0HHJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030713AbWF0HHJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 03:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932549AbWF0HGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 03:06:41 -0400
Received: from mx1.suse.de ([195.135.220.2]:25987 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030713AbWF0HGX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 03:06:23 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 27 Jun 2006 17:06:05 +1000
Message-Id: <1060627070605.26082@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 011 of 12] md: Fix "Will Configure" message when interpreting md= kernel parameter.
References: <20060627170010.25835.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If a partitionable array is used, we should say e.g.
  Will configure md_d0 (super-block) from ....
rather than
  Will configure md0 (super-block) from ....
which implies non-partitionable.


Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./usr/kinit/do_mounts_md.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff .prev/usr/kinit/do_mounts_md.c ./usr/kinit/do_mounts_md.c
--- .prev/usr/kinit/do_mounts_md.c	2006-06-27 12:15:15.000000000 +1000
+++ ./usr/kinit/do_mounts_md.c	2006-06-27 12:17:34.000000000 +1000
@@ -205,8 +205,8 @@ static int md_setup(char *str)
 		pername = "super-block";
 	}
 
-	fprintf(stderr, "md: Will configure md%d (%s) from %s, below.\n",
-		minor, pername, str);
+	fprintf(stderr, "md: Will configure md%s%d (%s) from %s, below.\n",
+		partitioned?"_d":"", minor, pername, str);
 	md_setup_args[ent].device_names = str;
 	md_setup_args[ent].partitioned = partitioned;
 	md_setup_args[ent].minor = minor;
