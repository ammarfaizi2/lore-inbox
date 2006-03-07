Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932084AbWCGT5E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbWCGT5E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 14:57:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932100AbWCGT5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 14:57:04 -0500
Received: from mail.gmx.de ([213.165.64.20]:4520 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932084AbWCGT5D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 14:57:03 -0500
X-Authenticated: #704063
Subject: [Patch] Wrong error handling in nfs4acl
From: Eric Sesterhenn <snakebyte@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: neilb@cse.unsw.edu.au
Content-Type: text/plain
Date: Tue, 07 Mar 2006 20:57:00 +0100
Message-Id: <1141761420.7561.7.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

this fixes coverity id #3. Coverity detected dead code,
since the == -1 comparison only returns 0 or 1 to error.
Therefore the if ( error < 0 ) statement was always false.
Seems that this was an if( error = nfs4... ) statement some time
ago, which got broken during cleanup.
Just compile tested.

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>


--- linux-2.6.16-rc5-mm1/fs/nfsd/nfs4acl.c.orig	2006-03-07 20:52:34.000000000 +0100
+++ linux-2.6.16-rc5-mm1/fs/nfsd/nfs4acl.c	2006-03-07 20:53:08.000000000 +0100
@@ -790,7 +790,7 @@ nfs4_acl_split(struct nfs4_acl *acl, str
 			continue;
 
 		error = nfs4_acl_add_ace(dacl, ace->type, ace->flag,
-				ace->access_mask, ace->whotype, ace->who) == -1;
+				ace->access_mask, ace->whotype, ace->who);
 		if (error < 0)
 			goto out;
 


