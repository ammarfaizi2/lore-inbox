Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932095AbWJ1SyO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbWJ1SyO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 14:54:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932088AbWJ1SyO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 14:54:14 -0400
Received: from nz-out-0102.google.com ([64.233.162.195]:30761 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932091AbWJ1SyM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 14:54:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent;
        b=bjqVGi2H3feo4fOEpnzYhovn8yPAadx1IZIny2WIsHqVZEqfEypPFTthfE09Z7RvKSH+l8A13Bmrg/f9Ybdl2siW1anRXgt61/VSQew8sPyBV+dkZQoaVmre/D8q2Y+LvSqWPe18YDMZKfGIoRRVr4hoOnwL9CX17lJnh4bFoxc=
Date: Sun, 29 Oct 2006 03:54:34 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Andy Adamson <andros@citi.umich.edu>,
       "J. Bruce Fields" <bfields@citi.umich.edu>,
       Trond Myklebust <Trond.Myklebust@netapp.com>
Subject: [PATCH] gss_spkm3: fix error handling in module init
Message-ID: <20061028185434.GL9973@localhost>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	linux-kernel@vger.kernel.org, Andy Adamson <andros@citi.umich.edu>,
	"J. Bruce Fields" <bfields@citi.umich.edu>,
	Trond Myklebust <Trond.Myklebust@netapp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

return error and privent from loading module when gss_mech_register()
failed.

Cc: Andy Adamson <andros@citi.umich.edu>
Cc: J. Bruce Fields <bfields@citi.umich.edu>
Cc: Trond Myklebust <Trond.Myklebust@netapp.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

 net/sunrpc/auth_gss/gss_spkm3_mech.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: work-fault-inject/net/sunrpc/auth_gss/gss_spkm3_mech.c
===================================================================
--- work-fault-inject.orig/net/sunrpc/auth_gss/gss_spkm3_mech.c
+++ work-fault-inject/net/sunrpc/auth_gss/gss_spkm3_mech.c
@@ -288,7 +288,7 @@ static int __init init_spkm3_module(void
 	status = gss_mech_register(&gss_spkm3_mech);
 	if (status)
 		printk("Failed to register spkm3 gss mechanism!\n");
-	return 0;
+	return status;
 }
 
 static void __exit cleanup_spkm3_module(void)
