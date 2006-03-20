Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964799AbWCTNwG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964799AbWCTNwG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 08:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964801AbWCTNwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 08:52:05 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:20436 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S964799AbWCTNwE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 08:52:04 -0500
Date: Mon, 20 Mar 2006 19:22:24 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, ak@suse.de, davem@davemloft.net,
       suparna@in.ibm.com, richardj_moore@uk.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [3/3 PATCH] Kprobes: User space probes support- single stepping out-of-line
Message-ID: <20060320135223.GA18975@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <20060320060745.GC31091@in.ibm.com> <20060320060931.GD31091@in.ibm.com> <20060320061014.GE31091@in.ibm.com> <20060320061123.GF31091@in.ibm.com> <20060320030922.4ea9445b.akpm@osdl.org> <441E92D8.4070309@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <441E92D8.4070309@yahoo.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2006 at 10:32:40PM +1100, Nick Piggin wrote:
> Andrew Morton wrote:
> >Prasanna S Panchamukhi <prasanna@in.ibm.com> wrote:
> 
> >>+
> >>+/**
> >>+ * This routines get the pte of the page containing the specified 
> >>address.
> >>+ */
> >>+static pte_t  __kprobes *get_uprobe_pte(unsigned long address)
> >>+{
> >>+	pgd_t *pgd;
> >>+	pud_t *pud;
> >>+	pmd_t *pmd;
> >>+	pte_t *pte = NULL;
> >>+
> >>+	pgd = pgd_offset(current->mm, address);
> >>+	if (!pgd)
> >>+		goto out;
> >>+
> >>+	pud = pud_offset(pgd, address);
> >>+	if (!pud)
> >>+		goto out;
> >>+
> >>+	pmd = pmd_offset(pud, address);
> >>+	if (!pmd)
> >>+		goto out;
> >>+
> >>+	pte = pte_alloc_map(current->mm, pmd, address);
> >>+
> >>+out:
> >>+	return pte;
> >>+}
> >
> >
> >That's familiar looking code..
> >
> >I guess this should be given a more generic name then placed in
> >mm/memory.c, which is where we do pagetable walking.
> >
> 
> Apart from this, there looks like quite a bit of other mm code
> that has been crammed into everywhere but mm/ (yes this has
> happened before, but it shouldn't be encouraged in new code).
> 
> For this specific example, I'm not sure that a function returning
> a pointer to a pte is a good idea to be exporting. I'd like to see
> some good reasons why things like get_user_pages, find_*_page, and
> other standard APIs can't be used. Then you can list those reasons
> in an individual patch to add your required API to mm/. This can
> be more easily reviewed by people who aren't as good at wading
> through code as Andrew.
> 
> Also, adding your own mm code outside core files really makes
> things hard to maintain and audit when somebody would like to
> change anything.
> 

Nick,

I will send out a separate patch to add this piece of code with proper
comments.

Thanks
Prasanna
> -- 
> SUSE Labs, Novell Inc.
> Send instant messages to your online friends http://au.messenger.yahoo.com 

-- 
Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Email: prasanna@in.ibm.com
Ph: 91-80-51776329
