Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751689AbVJTBid@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751689AbVJTBid (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 21:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751690AbVJTBid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 21:38:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23698 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751679AbVJTBic (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 21:38:32 -0400
Date: Wed, 19 Oct 2005 18:37:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: Rohit Seth <rohit.seth@intel.com>
Cc: hugh@veritas.com, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       agl@us.ibm.com
Subject: Re: [PATCH]: Handling spurious page fault for hugetlb region for
 2.6.14-rc4-git5
Message-Id: <20051019183748.2f6bc34f.akpm@osdl.org>
In-Reply-To: <1129772207.339.152.camel@akash.sc.intel.com>
References: <20051018141512.A26194@unix-os.sc.intel.com>
	<20051018143438.66d360c4.akpm@osdl.org>
	<1129673824.19875.36.camel@akash.sc.intel.com>
	<20051018172549.7f9f31da.akpm@osdl.org>
	<1129692330.24309.44.camel@akash.sc.intel.com>
	<20051018210721.4c80a292.akpm@osdl.org>
	<Pine.LNX.4.61.0510191623220.7586@goblin.wat.veritas.com>
	<1129748733.339.90.camel@akash.sc.intel.com>
	<Pine.LNX.4.61.0510192049030.10794@goblin.wat.veritas.com>
	<20051019131907.05ea7160.akpm@osdl.org>
	<Pine.LNX.4.61.0510192126100.11096@goblin.wat.veritas.com>
	<1129765996.339.138.camel@akash.sc.intel.com>
	<1129772207.339.152.camel@akash.sc.intel.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rohit Seth <rohit.seth@intel.com> wrote:
>
> > Excellent catch.  This broken truncation thing....
>  > 
>  > And I don't know what the right solution should be for this scenario at
>  > this point for 2.6.14....may be to actually look at the HUGEPTE
>  > corresponding to the hugetlb faulting address or don't allow mmaps to
>  > grow the hugetlb file bigger (except the first mmap).  I understand that
>  > both of them don't sound too good...
>  > 
>  > Any suggestions.
>  > 
> 
> 
>  I would like to keep this patch.  This at least takes care of bad things
>  happening behind application's back by OS/HW.  If the scenario that you
>  mentioned happens then the application is knowingly doing unsupported
>  things (at this point truncate is a broken operation on hugetlb).  The
>  application can be killed in this case.

Yes, we had an infinite-page-fault bug in the vmalloc code ages ago and the
app was indeed killable.  It'd be nice to confirm that this is still the
case.  If so, the stopgap approach seems reasonable.

As long as the demand-paging patches get in, that is.
