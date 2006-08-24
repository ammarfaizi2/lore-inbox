Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030348AbWHXGhE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030348AbWHXGhE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 02:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030337AbWHXGgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 02:36:51 -0400
Received: from ns2.suse.de ([195.135.220.15]:26290 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030340AbWHXGgs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 02:36:48 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Thu, 24 Aug 2006 16:36:50 +1000
Message-Id: <1060824063650.4949@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 004 of 11] knfsd: Protect update to sn_nrthreads with lock_kernel
References: <20060824162917.3600.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/nfsd/nfsctl.c |    2 ++
 1 file changed, 2 insertions(+)

diff .prev/fs/nfsd/nfsctl.c ./fs/nfsd/nfsctl.c
--- .prev/fs/nfsd/nfsctl.c	2006-08-24 16:24:21.000000000 +1000
+++ ./fs/nfsd/nfsctl.c	2006-08-24 16:24:47.000000000 +1000
@@ -532,7 +532,9 @@ static ssize_t write_ports(struct file *
 			/* Decrease the count, but don't shutdown the
 			 * the service
 			 */
+			lock_kernel();
 			nfsd_serv->sv_nrthreads--;
+			unlock_kernel();
 		}
 		return err;
 	}
