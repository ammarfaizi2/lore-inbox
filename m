Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270056AbTGQSvd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 14:51:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269964AbTGQSvd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 14:51:33 -0400
Received: from xs4all.vs19.net ([213.84.236.198]:62270 "EHLO spaans.vs19.net")
	by vger.kernel.org with ESMTP id S269296AbTGQStz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 14:49:55 -0400
Date: Thu, 17 Jul 2003 21:04:28 +0200
From: Jasper Spaans <jasper@vs19.net>
To: Frank Cusack <fcusack@fcusack.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, torvalds@osdl.org,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Allow unattended nfs3/krb5 mounts
Message-ID: <20030717190428.GA4735@spaans.vs19.net>
References: <20030715232605.A9418@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20030715232605.A9418@google.com>
Attach: /home/spaans/JasperSpaans.vcf
Organization: http://www.insultant.nl/
X-Copyright: Copyright 2003 C. Jasper Spaans - All Rights Reserved
X-message-flag: Warning! The sender of this mail thinks you should use a more secure email client!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 15, 2003 at 11:26:05PM -0700, Frank Cusack wrote:
> The comment in nfs_get_root() basically describes the patch:
> 
>     Some authentication types (gss/krb5, most notably)
>     are such that root won't be able to present a
>     credential for GETATTR (ie, getroot()).
[..]
> Does this patch look reasonable?  It works in my environment, against
> a netapp server (with the rpcsec_gss patch I provided earlier).

The way this patch was imported in bk-cvs causes a compile-time failure
in fs/nfs/inode.c;

Below is the -what seems to me- obvious fix.

One comment though wrt this code: it seems both the spellings 'flavor' and
'flavour' are used in this piece of code which is somewhat confusing. Should
that be fixed?

Index: fs/nfs/inode.c
===================================================================
RCS file: /home/cvs/linux-2.5/fs/nfs/inode.c,v
retrieving revision 1.79
diff -u -r1.79 inode.c
--- CVS/fs/nfs/inode.c	17 Jul 2003 17:28:19 -0000	1.79
+++ linux-2.5/fs/nfs/inode.c	17 Jul 2003 17:40:29 -0000
@@ -1441,7 +1441,7 @@
 	if ((server->idmap = nfs_idmap_new(server)) == NULL)
 		printk(KERN_WARNING "NFS: couldn't start IDmap\n");
 
-	err = nfs_sb_init(sb);
+	err = nfs_sb_init(sb, authflavour);
 	if (err == 0)
 		return 0;
 	rpciod_down();

VrGr,
-- 
Jasper Spaans                 http://jsp.vs19.net/contact/
