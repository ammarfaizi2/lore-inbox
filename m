Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751392AbWCBDMK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbWCBDMK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 22:12:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751396AbWCBDMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 22:12:09 -0500
Received: from mail26.syd.optusnet.com.au ([211.29.133.167]:2239 "EHLO
	mail26.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751392AbWCBDMI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 22:12:08 -0500
From: Con Kolivas <kernel@kolivas.org>
To: "Mark L. Fugate" <mark.fugate@comcast.net>
Subject: Re: 2.6.15.5 Compile error
Date: Thu, 2 Mar 2006 14:12:40 +1100
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org
References: <4405B468.9050908@comcast.net>
In-Reply-To: <4405B468.9050908@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603021412.40757.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Mar 2006 01:49 am, Mark L. Fugate wrote:
> To whom it may concern:
>
> I received the following compile error while compiling the 2.6.15.5
> kernel. My .config is attached.

That looks like a silly oversight.

Try this patch.

Cheers,
Con
---
Build fix for direct.c

Signed-off-by: Con Kolivas <kernel@kolivas.org>

 fs/nfs/direct.c |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-2.6.15-ck5/fs/nfs/direct.c
===================================================================
--- linux-2.6.15-ck5.orig/fs/nfs/direct.c	2006-03-02 13:06:57.000000000 +1100
+++ linux-2.6.15-ck5/fs/nfs/direct.c	2006-03-02 13:55:28.000000000 +1100
@@ -73,6 +73,8 @@ struct nfs_direct_req {
 				error;		/* any reported error */
 };
 
+static void
+nfs_free_user_pages(struct page **pages, int npages, int do_dirty);
 
 /**
  * nfs_get_user_pages - find and set up pages underlying user's buffer
