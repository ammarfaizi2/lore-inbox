Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751328AbWBVDzV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbWBVDzV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 22:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751329AbWBVDzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 22:55:21 -0500
Received: from xproxy.gmail.com ([66.249.82.192]:39247 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751328AbWBVDzV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 22:55:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fXMahmXfRnPWICbXMVZ164iw4EA1XsAbJ98O0eyywDAA3G53U5AuF9KBz53pFvw650rrIUoMCv33FMLyQs4asfAD4ruy9vRPXi6oWoeBshZBwpIYGGrOD68MslGyZxjAHRhNmdcIXf0FvlR5bQh0DSccVtLofgnlQ5bZRGNJ9jg=
Message-ID: <ed5aea430602211955k225698c9w35ac02eae071a0c5@mail.gmail.com>
Date: Tue, 21 Feb 2006 20:55:15 -0700
From: David Mosberger-Tang <David.Mosberger@acm.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Subject: Re: IA64 non-contiguous memory space bugs
Cc: David Gibson <david@gibson.dropbear.id.au>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <200602220253.k1M2rWg10346@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060222001359.GA23574@localhost.localdomain>
	 <200602220253.k1M2rWg10346@unix-os.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm only following this superficially, but keep in mind that a vm-area
MUST NEVER cross a hole.

  --david

On 2/21/06, Chen, Kenneth W <kenneth.w.chen@intel.com> wrote:
> David Gibson wrote on Tuesday, February 21, 2006 4:14 PM
> > First bug (confirmed many months ago by Chris Wedgwood) - you can get
> > weird effects if you attempt to mmap() something into one of the
> > address space gaps.  The ia64 outer wrapper for mmap2() tries to
> > prevent it, but doesn't do a good enough job, it's still possible
> > indirectly with shmat() and maybe mremap().  Basic trouble is that
> > most of the checks applied by the generic code assume that everything
> > between 0 and TASK_SIZE is valid.
>
> Ha ha ha.
>
> On ia64, the low level tlb fault handler (vhpt_miss and nested_dtlb_miss)
> checks that all unused address bits (between REGION_NUMBER and PGDIR_SHIFT)
> should be all zero.  If they are not zero, it will fall into page fault
> handler and in there, ia64 should just send SEGV instead of happily hand
> over a page.  Buggy buggy....
>
> - Ken
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ia64" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--
Mosberger Consulting LLC, http://www.mosberger-consulting.com/
