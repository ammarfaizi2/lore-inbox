Return-Path: <linux-kernel-owner+w=401wt.eu-S964843AbXALTnd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964843AbXALTnd (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 14:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964925AbXALTnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 14:43:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:55866 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964843AbXALTnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 14:43:32 -0500
From: Neil Brown <neilb@suse.de>
To: Fengguang Wu <fengguang.wu@gmail.com>
Date: Sat, 13 Jan 2007 06:43:07 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17831.58571.460279.128732@notabene.brown>
Cc: linux-kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: "svc: unknown version (3)" when CONFIG_NFSD_V4=y
In-Reply-To: message from Fengguang Wu on Friday January 12
References: <367964923.02447@ustc.edu.cn>
	<20070105024226.GA6076@mail.ustc.edu.cn>
	<17828.33075.145986.404400@notabene.brown>
	<368438638.13038@ustc.edu.cn>
	<20070110141756.GA5572@mail.ustc.edu.cn>
	<17829.46603.14554.981639@notabene.brown>
	<368527150.02925@ustc.edu.cn>
	<20070111145309.GA6226@mail.ustc.edu.cn>
	<17830.46175.410277.466742@notabene.brown>
	<368569131.07190@ustc.edu.cn>
	<20070112023251.GA6136@mail.ustc.edu.cn>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday January 12, fengguang.wu@gmail.com wrote:
> > Are you really really double-plus sure that you are running a kernel
> > with the patch applied?
> > Because at the very least it should have changed the message to
> 
> Oh, sorry. I recompiled & installed kernel and it output this new message:
> 
> [  133.129919] svc: unknown version (3 for prog 100227, nfsacl)
> 

Ok, thanks.  I must have missed something else wrong in the code......

Probably this 'break' in the wrong place...

Could you try this patch instead please - or just move the 'break' to
where it should be.

Thanks,
NeilBrown

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/nfsd/nfssvc.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff .prev/fs/nfsd/nfssvc.c ./fs/nfsd/nfssvc.c
--- .prev/fs/nfsd/nfssvc.c	2007-01-11 14:55:38.000000000 +1100
+++ ./fs/nfsd/nfssvc.c	2007-01-13 06:40:12.000000000 +1100
@@ -72,7 +72,7 @@ static struct svc_program	nfsd_acl_progr
 	.pg_prog		= NFS_ACL_PROGRAM,
 	.pg_nvers		= NFSD_ACL_NRVERS,
 	.pg_vers		= nfsd_acl_versions,
-	.pg_name		= "nfsd",
+	.pg_name		= "nfsacl",
 	.pg_class		= "nfsd",
 	.pg_stats		= &nfsd_acl_svcstats,
 	.pg_authenticate	= &svc_set_client,
@@ -118,16 +118,16 @@ int nfsd_vers(int vers, enum vers_op cha
 	switch(change) {
 	case NFSD_SET:
 		nfsd_versions[vers] = nfsd_version[vers];
-		break;
 #if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
 		if (vers < NFSD_ACL_NRVERS)
-			nfsd_acl_version[vers] = nfsd_acl_version[vers];
+			nfsd_acl_versions[vers] = nfsd_acl_version[vers];
 #endif
+		break;
 	case NFSD_CLEAR:
 		nfsd_versions[vers] = NULL;
 #if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
 		if (vers < NFSD_ACL_NRVERS)
-			nfsd_acl_version[vers] = NULL;
+			nfsd_acl_versions[vers] = NULL;
 #endif
 		break;
 	case NFSD_TEST:
