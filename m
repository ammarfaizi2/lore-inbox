Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161030AbWF0HYd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161030AbWF0HYd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 03:24:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030733AbWF0HUH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 03:20:07 -0400
Received: from ns2.suse.de ([195.135.220.15]:55206 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030714AbWF0HT4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 03:19:56 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 27 Jun 2006 17:19:45 +1000
Message-Id: <1060627071945.26612@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: Frank Filz <ffilzlnx@us.ibm.com>
Subject: [PATCH 002 of 14] knfsd: Fixing missing 'expkey' support for fsid type 3
References: <20060627171533.26405.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Frank Filz <ffilzlnx@us.ibm.com>

Type '3' is used for the fsid in filehandles when the device number
of the device holding the filesystem has more than 8 bits in either
major or minor.
Unfortunately expkey_parse doesn't recognise type 3.  Fix this.

(Slighty modified from Frank's original)

Signed-Off-By: Frank Filz <ffilzlnx@us.ibm.com>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/nfsd/export.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff .prev/fs/nfsd/export.c ./fs/nfsd/export.c
--- .prev/fs/nfsd/export.c	2006-06-27 12:15:18.000000000 +1000
+++ ./fs/nfsd/export.c	2006-06-27 12:15:55.000000000 +1000
@@ -126,7 +126,7 @@ static int expkey_parse(struct cache_det
 	if (*ep)
 		goto out;
 	dprintk("found fsidtype %d\n", fsidtype);
-	if (fsidtype > 2)
+	if (key_len(fsidtype)==0) /* invalid type */
 		goto out;
 	if ((len=qword_get(&mesg, buf, PAGE_SIZE)) <= 0)
 		goto out;
