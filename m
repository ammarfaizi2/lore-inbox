Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263867AbUDPWPO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 18:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263822AbUDPWMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 18:12:49 -0400
Received: from dsl093-002-214.det1.dsl.speakeasy.net ([66.93.2.214]:38928 "EHLO
	pumpkin.fieldses.org") by vger.kernel.org with ESMTP
	id S263867AbUDPWJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 18:09:28 -0400
Date: Fri, 16 Apr 2004 18:09:23 -0400
To: Dave Jones <davej@redhat.com>, trond.myklebust@fys.uio.no,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: NFS thinko
Message-ID: <20040416220922.GA12062@fieldses.org>
References: <20040416211628.GM20937@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040416211628.GM20937@redhat.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2004 at 10:16:28PM +0100, Dave Jones wrote:
> Dereferencing 'exp' before the check for NULL.

It would be a bug if exp were ever NULL there.  Better just to delete
that check entirely.

--Bruce Fields


If ek = exp_find_key() is not an error, then ek->ek_export should be
set; no point in checking if it's NULL.


 include/linux/nfsd/export.h |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

diff -puN include/linux/nfsd/export.h~export_exp_deref_fix include/linux/nfsd/export.h
--- linux-2.6.6-rc1/include/linux/nfsd/export.h~export_exp_deref_fix	2004-04-16 17:51:57.000000000 -0400
+++ linux-2.6.6-rc1-bfields/include/linux/nfsd/export.h	2004-04-16 17:58:30.000000000 -0400
@@ -120,8 +120,7 @@ exp_find(struct auth_domain *clp, int fs
 		int err;
 		cache_get(&exp->h);
 		expkey_put(&ek->h, &svc_expkey_cache);
-		if (exp &&
-		    (err = cache_check(&svc_export_cache, &exp->h, reqp)))
+		if ((err = cache_check(&svc_export_cache, &exp->h, reqp)))
 			exp = ERR_PTR(err);
 		return exp;
 	} else

_
