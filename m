Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751209AbWBPB22@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbWBPB22 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 20:28:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751214AbWBPB22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 20:28:28 -0500
Received: from [218.25.172.144] ([218.25.172.144]:47113 "HELO mail.fc-cn.com")
	by vger.kernel.org with SMTP id S1751209AbWBPB21 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 20:28:27 -0500
Date: Thu, 16 Feb 2006 09:28:27 +0800
From: Coywolf Qi Hunt <qiyong@fc-cn.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [patch] make sysctl_overcommit_memory enumeration sensible
Message-ID: <20060216012827.GA2702@localhost.localdomain>
References: <20060215085456.GA2481@localhost.localdomain> <43F2EDD6.7000204@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F2EDD6.7000204@yahoo.com.au>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2006 at 08:01:10PM +1100, Nick Piggin wrote:
> Coywolf Qi Hunt wrote:
> >I see system admins often confused when they sysctl vm.overcommit_memory.
> >This patch makes overcommit_memory enumeration sensible.
> >
> 
> What's the point? The current has been there for a long time, and
> is well documented.

Yes, the current is well documented and for a long time. But the design is
insane, no matter how well and how long it is documented. Users have to read
the document for *many times*.

The new way is logical so it would let us "read once, remember always".


	Coywolf

> 
> >0 - no overcommit
> >1 - always overcommit
> >2 - heuristic overcommit (default)
> >
> >I don't feel this would break any userspace scripts.
> 
> You mean, except for the ones that go `echo 0 > 
> /proc/sys/vm/overcommit_memory`;
> or `echo 2 > /proc/sys/vm/overcommit_memory` ?
> 
> And those sysctl configuration files that get set at bootup?
> 
> >If it seems OK, I'll
> >update the documents.
> >
> >Signed-off-by: Coywolf Qi Hunt <qiyong@fc-cn.com>
> >---
> >diff --git a/include/linux/mman.h b/include/linux/mman.h
> >index 18a5689..e50f5ad 100644
> >--- a/include/linux/mman.h
> >+++ b/include/linux/mman.h
> >@@ -10,9 +10,9 @@
> > #define MREMAP_MAYMOVE	1
> > #define MREMAP_FIXED	2
> > 
> >-#define OVERCOMMIT_GUESS		0
> >+#define OVERCOMMIT_NEVER		0
> > #define OVERCOMMIT_ALWAYS		1
> >-#define OVERCOMMIT_NEVER		2
> >+#define OVERCOMMIT_GUESS		2
> > extern int sysctl_overcommit_memory;
> > extern int sysctl_overcommit_ratio;
> > extern atomic_t vm_committed_space;
> >
> 
> 
> -- 
> SUSE Labs, Novell Inc.
> Send instant messages to your online friends http://au.messenger.yahoo.com 
> 

-- 
Coywolf Qi Hunt
