Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267238AbUHXBgf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267238AbUHXBgf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 21:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267961AbUHXBcr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 21:32:47 -0400
Received: from holomorphy.com ([207.189.100.168]:16776 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268184AbUHXB32 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 21:29:28 -0400
Date: Mon, 23 Aug 2004 18:29:24 -0700
From: wli@holomorphy.com
To: Dave Jones <davej@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, suparna@in.ibm.com
Subject: Re: [PATCH] Writeback page range hint
Message-ID: <20040824012924.GP4418@holomorphy.com>
Mail-Followup-To: wli@holomorphy.com, Dave Jones <davej@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, suparna@in.ibm.com
References: <200408232138.i7NLcfJd019125@hera.kernel.org> <20040824010723.GA15668@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040824010723.GA15668@redhat.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2004 at 02:07:23AM +0100, Dave Jones wrote:
> Causes sparse spew..
> include/linux/writeback.h:54:19: warning: dubious one-bit signed bitfield
> include/linux/writeback.h:55:30: warning: dubious one-bit signed bitfield
> include/linux/writeback.h:56:19: warning: dubious one-bit signed bitfield
> include/linux/writeback.h:57:19: warning: dubious one-bit signed bitfield

Does this help?


Index: mm4-2.6.8.1/include/linux/writeback.h
===================================================================
--- mm4-2.6.8.1.orig/include/linux/writeback.h	2004-08-23 16:11:10.318739856 -0700
+++ mm4-2.6.8.1/include/linux/writeback.h	2004-08-23 18:26:45.790960088 -0700
@@ -51,10 +51,10 @@
 	loff_t start;
 	loff_t end;
 
-	int nonblocking:1;		/* Don't get stuck on request queues */
-	int encountered_congestion:1;	/* An output: a queue is full */
-	int for_kupdate:1;		/* A kupdate writeback */
-	int for_reclaim:1;		/* Invoked from the page allocator */
+	unsigned nonblocking:1,		/* Don't get stuck on request queues */
+	    encountered_congestion:1,	/* An output: a queue is full */
+	    for_kupdate:1,		/* A kupdate writeback */
+	    for_reclaim:1;		/* Invoked from the page allocator */
 };
 
 /*
