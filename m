Return-Path: <linux-kernel-owner+w=401wt.eu-S932498AbXAJGBp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932498AbXAJGBp (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 01:01:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932614AbXAJGBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 01:01:45 -0500
Received: from cantor2.suse.de ([195.135.220.15]:40754 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932498AbXAJGBo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 01:01:44 -0500
From: Neil Brown <neilb@suse.de>
To: Fengguang Wu <fengguang.wu@gmail.com>
Date: Wed, 10 Jan 2007 17:01:23 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17828.33075.145986.404400@notabene.brown>
Cc: linux-kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: "svc: unknown version (3)" when CONFIG_NFSD_V4=y
In-Reply-To: message from Fengguang Wu on Friday January 5
References: <367964923.02447@ustc.edu.cn>
	<20070105024226.GA6076@mail.ustc.edu.cn>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday January 5, fengguang.wu@gmail.com wrote:
> Hi Neil,
> 
> NFS mounting succeeded, but the kernel gives a warning.
> I'm running 2.6.20-rc2-mm1.
> 
> # mount -o vers=3 localhost:/suse /mnt
> [  689.651606] svc: unknown version (3)
> # mount | grep suse
> localhost:/suse on /mnt type nfs (rw,nfsvers=3,addr=127.0.0.1)
> 
> Any clues about it?

Weird.

Please try this patch.  It should provide more useful information.

NeilBrown

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./net/sunrpc/svc.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff .prev/net/sunrpc/svc.c ./net/sunrpc/svc.c
--- .prev/net/sunrpc/svc.c	2007-01-10 16:58:14.000000000 +1100
+++ ./net/sunrpc/svc.c	2007-01-10 16:59:55.000000000 +1100
@@ -910,7 +910,8 @@ err_bad_prog:
 
 err_bad_vers:
 #ifdef RPC_PARANOIA
-	printk("svc: unknown version (%d)\n", vers);
+	printk("svc: unknown version (%d for prog %d, %s)\n", 
+	       vers, prog, progp->pg_name);
 #endif
 	serv->sv_stats->rpcbadfmt++;
 	svc_putnl(resv, RPC_PROG_MISMATCH);
