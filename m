Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268311AbUHKW5n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268311AbUHKW5n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 18:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268299AbUHKWy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 18:54:29 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:48264 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S268304AbUHKWwQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 18:52:16 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: walt <wa1ter@myrealbox.com>
Date: Thu, 12 Aug 2004 08:52:08 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16666.41752.197153.706539@cse.unsw.edu.au>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.8-rc4] New nfsd-related kernel panic
In-Reply-To: message from walt on Wednesday August 11
References: <411AAF69.9080803@myrealbox.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday August 11, wa1ter@myrealbox.com wrote:
> 
> Anyone else seeing this?

Yes.  I've just sent the following patch to Linus/Andrew.

NeilBrown

diff ./fs/nfsd/nfs3xdr.c~current~ ./fs/nfsd/nfs3xdr.c
--- ./fs/nfsd/nfs3xdr.c~current~	2004-08-12 08:32:26.000000000 +1000
+++ ./fs/nfsd/nfs3xdr.c	2004-08-12 08:37:33.000000000 +1000
@@ -347,8 +347,8 @@ nfs3svc_decode_readargs(struct svc_rqst 
 		svc_take_page(rqstp);
 		args->vec[v].iov_base = page_address(rqstp->rq_respages[pn]);
 		args->vec[v].iov_len = len < PAGE_SIZE? len : PAGE_SIZE;
+		len -= args->vec[v].iov_len;
 		v++;
-		len -= PAGE_SIZE;
 	}
 	args->vlen = v;
 	return xdr_argsize_check(rqstp, p);

diff ./fs/nfsd/nfsxdr.c~current~ ./fs/nfsd/nfsxdr.c
--- ./fs/nfsd/nfsxdr.c~current~	2004-08-12 08:32:26.000000000 +1000
+++ ./fs/nfsd/nfsxdr.c	2004-08-12 08:38:49.000000000 +1000
@@ -255,8 +255,8 @@ nfssvc_decode_readargs(struct svc_rqst *
 		svc_take_page(rqstp);
 		args->vec[v].iov_base = page_address(rqstp->rq_respages[pn]);
 		args->vec[v].iov_len = len < PAGE_SIZE?len:PAGE_SIZE;
+		len -= args->vec[v].iov_len;
 		v++;
-		len -= PAGE_SIZE;
 	}
 	args->vlen = v;
 	return xdr_argsize_check(rqstp, p);
