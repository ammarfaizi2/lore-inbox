Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283667AbRLIRfP>; Sun, 9 Dec 2001 12:35:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283672AbRLIRfG>; Sun, 9 Dec 2001 12:35:06 -0500
Received: from zok.SGI.COM ([204.94.215.101]:51909 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S283667AbRLIRet>;
	Sun, 9 Dec 2001 12:34:49 -0500
From: Jack Steiner <steiner@sgi.com>
Message-Id: <200112091734.LAA45393@fsgi055.americas.sgi.com>
Subject: Re: [Lse-tech] [RFC] [PATCH] Scalable Statistics Counters
To: pj@engr.sgi.com (Paul Jackson)
Date: Sun, 9 Dec 2001 11:34:43 -0600 (CST)
Cc: steiner@sgi.com (Jack Steiner), dipankar@in.ibm.com (Dipankar Sarma),
        nchr@us.ibm.com (Niels Christiansen), kiran@linux.ibm.com,
        lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.SGI.4.21.0112082027310.203252-100000@sam.engr.sgi.com> from "Paul Jackson" at Dec 08, 2001 08:44:37 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> I think Jack got his attribution wrong.  Which is good for me,
> since I wrote what Jack just gently demolished <grin>.
  
And I probably should not have been reading mail while I
debugged a weird system hang. :-)  I missed the earlier
part of the thread - I though you were refering to local
allocation.

I dont think I have a strong opinion yet about kmem_cache_alloc_node()
vs kmem_cache_alloc_cpu(). I would not be surprised to find that 
both interfaces make sense.  

If code want to allocate close to a cpu, then kmem_cache_alloc_cpu()
is the best choice. However, I would also expect that some code
already knows the node. Then kmem_cache_alloc_node() is best.

Conversion of cpu->node is easy. Conversion of node->cpu
is slightly more difficult (currently) and has the ambiguity
that there may be multiple cpus on the node - which one should
you select? And does it matter?

As precident, the page allocation routines are all node-based.
(ie., alloc_pages_node(), etc...)


-- 
Thanks

Jack Steiner    (651-683-5302)   (vnet 233-5302)      steiner@sgi.com

