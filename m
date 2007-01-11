Return-Path: <linux-kernel-owner+w=401wt.eu-S965048AbXAKD7c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965048AbXAKD7c (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 22:59:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965032AbXAKD7c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 22:59:32 -0500
Received: from ns2.suse.de ([195.135.220.15]:44338 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965048AbXAKD7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 22:59:31 -0500
From: Neil Brown <neilb@suse.de>
To: Fengguang Wu <fengguang.wu@gmail.com>
Date: Thu, 11 Jan 2007 14:59:07 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17829.46603.14554.981639@notabene.brown>
Cc: linux-kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: "svc: unknown version (3)" when CONFIG_NFSD_V4=y
In-Reply-To: message from Fengguang Wu on Wednesday January 10
References: <367964923.02447@ustc.edu.cn>
	<20070105024226.GA6076@mail.ustc.edu.cn>
	<17828.33075.145986.404400@notabene.brown>
	<368438638.13038@ustc.edu.cn>
	<20070110141756.GA5572@mail.ustc.edu.cn>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday January 10, fengguang.wu@gmail.com wrote:
> 
> root ~# mount localhost:/suse /mnt
> [  132.678204] svc: unknown version (3 for prog 100227, nfsd)
> 
> I've confirmed that 2.6.20-rc2-mm1, 2.6.20-rc3-mm1, 2.6.19-rc6-mm1 all
> have this warning, while 2.6.17-2-amd64 is good.

Thanks.  That helps a lot.

This patch should help too.  Please let me know.

NeilBrown


Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/nfsd/nfssvc.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff .prev/fs/nfsd/nfssvc.c ./fs/nfsd/nfssvc.c
--- .prev/fs/nfsd/nfssvc.c	2007-01-11 14:55:38.000000000 +1100
+++ ./fs/nfsd/nfssvc.c	2007-01-11 14:57:03.000000000 +1100
@@ -72,7 +72,7 @@ static struct svc_program	nfsd_acl_progr
 	.pg_prog		= NFS_ACL_PROGRAM,
 	.pg_nvers		= NFSD_ACL_NRVERS,
 	.pg_vers		= nfsd_acl_versions,
-	.pg_name		= "nfsd",
+	.pg_name		= "nfsacl",
 	.pg_class		= "nfsd",
 	.pg_stats		= &nfsd_acl_svcstats,
 	.pg_authenticate	= &svc_set_client,
@@ -121,13 +121,13 @@ int nfsd_vers(int vers, enum vers_op cha
 		break;
 #if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
 		if (vers < NFSD_ACL_NRVERS)
-			nfsd_acl_version[vers] = nfsd_acl_version[vers];
+			nfsd_acl_versions[vers] = nfsd_acl_version[vers];
 #endif
 	case NFSD_CLEAR:
 		nfsd_versions[vers] = NULL;
 #if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
 		if (vers < NFSD_ACL_NRVERS)
-			nfsd_acl_version[vers] = NULL;
+			nfsd_acl_versions[vers] = NULL;
 #endif
 		break;
 	case NFSD_TEST:
