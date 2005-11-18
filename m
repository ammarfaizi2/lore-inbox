Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161012AbVKRSHs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161012AbVKRSHs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 13:07:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161022AbVKRSHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 13:07:48 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:46490 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161012AbVKRSHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 13:07:47 -0500
Date: Fri, 18 Nov 2005 18:07:43 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: akpm@osdl.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-rc1-mm1 panic in ptrace_check_attach()
Message-ID: <20051118180743.GA3708@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Badari Pulavarty <pbadari@us.ibm.com>, akpm@osdl.org,
	lkml <linux-kernel@vger.kernel.org>
References: <1132336600.24066.179.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1132336600.24066.179.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2005 at 09:56:40AM -0800, Badari Pulavarty wrote:
> Hi Andrew,
> 
> I am not sure if its already reported. I get panic in
> ptrace_check_attach() while trying to run UML on 2.6.15-rc1-mm1.
> 
> Going to try 2.6.15-rc1-mm2 now. 

Looks like 2.6.15-rc1-mm1 has total crap in ptrace_get_task_struct
(and it looks like my fault because I sent out a wrong patch).

The patch below should fix it:

Index: linux-2.6/kernel/ptrace.c
===================================================================
--- linux-2.6.orig/kernel/ptrace.c	2005-11-18 10:25:35.000000000 +0100
+++ linux-2.6/kernel/ptrace.c	2005-11-18 10:25:54.000000000 +0100
@@ -459,7 +459,7 @@
 	read_unlock(&tasklist_lock);
 	if (!child)
 		return ERR_PTR(-ESRCH);
-	return 0;
+	return child;
 }
 
 #ifndef __ARCH_SYS_PTRACE
