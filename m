Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264256AbTGHLR0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 07:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265043AbTGHLOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 07:14:36 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:50948 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267210AbTGHLMF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 07:12:05 -0400
Date: Tue, 8 Jul 2003 12:26:40 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.22-pre4 won't link without CONFIG_QUOTA
Message-ID: <20030708122640.B17446@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030708092128.GB5725@malvern.uk.w2k.superh.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030708092128.GB5725@malvern.uk.w2k.superh.com>; from Richard.Curnow@superh.com on Tue, Jul 08, 2003 at 10:21:28AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 08, 2003 at 10:21:28AM +0100, Richard Curnow wrote:
> Hi Christoph,
> 
> I'm building without quota support.  I get the following error at link
> time:

This is the patch I sent to marcelo a few minutes ago:

===== fs/dquot.c 1.18 vs edited =====
--- 1.18/fs/dquot.c	Tue Jun 24 23:11:29 2003
+++ edited/fs/dquot.c	Mon Jul  7 10:44:36 2003
@@ -152,8 +152,6 @@
 static LIST_HEAD(free_dquots);
 static struct list_head dquot_hash[NR_DQHASH];
 
-struct dqstats dqstats;
-
 static void dqput(struct dquot *);
 static struct dquot *dqduplicate(struct dquot *);
 
===== fs/quota.c 1.1 vs edited =====
--- 1.1/fs/quota.c	Tue Jun 24 23:11:30 2003
+++ edited/fs/quota.c	Mon Jul  7 10:42:58 2003
@@ -13,6 +13,7 @@
 #include <linux/smp_lock.h>
 #include <linux/quotacompat.h>
 
+struct dqstats dqstats;
 
 /* Check validity of quotactl */
 static int check_quotactl_valid(struct super_block *sb, int type, int cmd, qid_t id)
