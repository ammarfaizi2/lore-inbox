Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964833AbWEJUtb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964833AbWEJUtb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 16:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964824AbWEJUtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 16:49:31 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:60585 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964833AbWEJUta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 16:49:30 -0400
Date: Wed, 10 May 2006 21:49:28 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Adam Litke <agl@us.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Hugetlb demotion for x86
Message-ID: <20060510204928.GA31315@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Adam Litke <agl@us.ibm.com>, linux-mm@kvack.kernel.org,
	linux-kernel@vger.kernel.org
References: <1147287400.24029.81.camel@localhost.localdomain> <20060510200516.GA30346@infradead.org> <1147293156.24029.95.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1147293156.24029.95.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2006 at 03:32:36PM -0500, Adam Litke wrote:
> By smart fallback do you mean we should convert the hugetlb fault code
> back to using VM_FAULT_SIGBUS and writing userspace sighandlers to do
> the same thing I am, but in userspace?  FWIW I did implement that in
> libhugetlbfs to try it out, but that seems much dirtier to me than
> handling faults in the kernel.

Umm, why do these faults happen at all?  When all the hugetlb code went
in it we allocated at mmap time.  Later it was converted to demand faulting
but under the premise that we keep the strict overcommit accounting.  When
did that part go away aswell?  With strict overcommit handling for huge
pages no fault should happen when the pool is exausted.

