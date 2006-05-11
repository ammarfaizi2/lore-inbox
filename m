Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030253AbWEKPPx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030253AbWEKPPx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 11:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030257AbWEKPPx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 11:15:53 -0400
Received: from gold.veritas.com ([143.127.12.110]:14664 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1030253AbWEKPPw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 11:15:52 -0400
X-IronPort-AV: i="4.05,116,1146466800"; 
   d="scan'208"; a="59423634:sNHT28593516"
Date: Thu, 11 May 2006 16:15:43 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Adam Litke <agl@us.ibm.com>
cc: Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Hugetlb demotion for x86
In-Reply-To: <1147297535.24029.114.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0605111607250.24407@blonde.wat.veritas.com>
References: <1147287400.24029.81.camel@localhost.localdomain> 
 <20060510200516.GA30346@infradead.org>  <1147293156.24029.95.camel@localhost.localdomain>
  <20060510204928.GA31315@infradead.org> <1147297535.24029.114.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 11 May 2006 15:15:51.0860 (UTC) FILETIME=[CA792740:01C6750D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 May 2006, Adam Litke wrote:
> 
> Strict overcommit is there for shared mappings.  When private mapping

I presume that by "strict overcommit" you mean "strict no overcommit".

> support was added, people agreed that full overcommit should apply to
> private mappings for the same reasons normal page overcommit is desired.

I'm not sure how wide that agreement was.  But what I wanted to say is...

> For one: an application using lots of private huge pages should not be
> prohibited from forking if it's likely to just exec a small helper
> program.

This is an excellent use for madvise(start, length, MADV_DONTFORK).
Though it was added mainly for RDMA issues, it's a great way for a
program with a huge commitment to exclude areas of its address space
from the fork, so making that fork much more likely to succeed.

Hugh
