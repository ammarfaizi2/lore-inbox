Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030269AbWFCIMh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030269AbWFCIMh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 04:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030292AbWFCIMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 04:12:09 -0400
Received: from mga03.intel.com ([143.182.124.21]:2883 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1030277AbWFCIME (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 04:12:04 -0400
X-IronPort-AV: i="4.05,205,1146466800"; 
   d="scan'208"; a="45451684:sNHT19327371"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Ingo Molnar'" <mingo@elte.hu>, "Con Kolivas" <kernel@kolivas.org>
Cc: "'Andrew Morton'" <akpm@osdl.org>,
       "'Nick Piggin'" <nickpiggin@yahoo.com.au>,
       "'Chris Mason'" <mason@suse.com>, <linux-kernel@vger.kernel.org>
Subject: RE: [patch] fix smt nice lock contention and optimization
Date: Sat, 3 Jun 2006 01:12:04 -0700
Message-ID: <000801c686e5$666e5f60$df34030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AcaG41JnwrQOmpm5ToiOKny0eEYIEQAAc4cg
In-Reply-To: <20060603075734.GC20229@elte.hu>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote on Saturday, June 03, 2006 12:58 AM
> * Con Kolivas <kernel@kolivas.org> wrote:
> 
> > Could we make this neater with extra braces such as:
> > 
> >  	for_each_domain(this_cpu, tmp) {
> > 		if (tmp->flags & SD_SHARE_CPUPOWER) {
> >  			sd = tmp;
> > 			break;
> > 		}
> > 	}
> > 
> > and same for the other uses of for_each ? I know it's redundant but 
> > it's neater IMO when there are multiple lines of code below it.
> 
> yep, that's the preferred style when there are multiple lines below a 
> loop.


OK, thanks for the tips.  Here is an incremental coding-style fix:

--- ./kernel/sched.c.orig	2006-06-02 23:54:11.000000000 -0700
+++ ./kernel/sched.c	2006-06-02 23:55:45.000000000 -0700
@@ -2973,11 +2973,12 @@
 	struct sched_domain *tmp, *sd = NULL;
 	int i;
 
-	for_each_domain(this_cpu, tmp)
+	for_each_domain(this_cpu, tmp) {
 		if (tmp->flags & SD_SHARE_CPUPOWER) {
 			sd = tmp;
 			break;
 		}
+	}
 	if (!sd)
 		return;
 
@@ -3019,11 +3020,12 @@
 	if (!p->mm || rt_task(p))
 		return 0;
 
-	for_each_domain(this_cpu, tmp)
+	for_each_domain(this_cpu, tmp) {
 		if (tmp->flags & SD_SHARE_CPUPOWER) {
 			sd = tmp;
 			break;
 		}
+	}
 	if (!sd)
 		return 0;
 
