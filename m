Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932329AbWHaOVS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932329AbWHaOVS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 10:21:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932315AbWHaOVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 10:21:18 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:48804 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S932329AbWHaOVR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 10:21:17 -0400
Date: Thu, 31 Aug 2006 16:16:46 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Steven Whitehouse <swhiteho@redhat.com>
cc: linux-kernel@vger.kernel.org, Russell Cattelan <cattelan@redhat.com>,
       David Teigland <teigland@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       hch@infradead.org
Subject: Re: [PATCH 01/16] GFS2: Core header files
In-Reply-To: <1157030918.3384.785.camel@quoit.chygwyn.com>
Message-ID: <Pine.LNX.4.61.0608311607441.5900@yvahk01.tjqt.qr>
References: <1157030918.3384.785.camel@quoit.chygwyn.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>+ *
>+ * This copyrighted material is made available to anyone wishing to use,
>+ * modify, copy, or redistribute it subject to the terms and conditions
>+ * of the GNU General Public License v.2.
>+ */

"v2" perhaps? From a math pov, the extra dot implies v0.2.

>+struct gfs2_log_operations;

I would suggest listing only struct lines that are actually required, i.e. the
compiler would barf without them.

>+enum {
>+	/* Actions */
>+	HIF_MUTEX		= 0,
>+	HIF_PROMOTE		= 1,
>+	HIF_DEMOTE		= 2,
>+	HIF_GREEDY		= 3,

I leave it to you whether going with the above or

enum {
   HIF_MUTEX = 0,
   HIF_PROMOTE,
   HIF_DEMOTE,
   HIF_GREEDY,
   ...
};

If these values need to stay the same, for example to maintain on-disk
compatibility, I prefer the former, though.

>+	/* Quota stuff */
>+
>+	struct gfs2_quota_data *al_qd[4];

What four quotas can there be? Use the MAXQUOTAS macro if feasible.

>+struct gfs2_quota_lvb {
>+        uint32_t qb_magic;
>+        uint32_t __pad;
>+        uint64_t qb_limit;      /* Hard limit of # blocks to alloc */
>+        uint64_t qb_warn;       /* Warn user when alloc is above this # */
>+        int64_t qb_value;       /* Current # blocks allocated */
>+};

Is this an on-disk structure or why is there a __pad field?



Jan Engelhardt
-- 
