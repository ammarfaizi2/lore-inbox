Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030293AbWEKP75@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030293AbWEKP75 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 11:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030300AbWEKP75
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 11:59:57 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:57741 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030293AbWEKP75 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 11:59:57 -0400
Subject: Re: [RFC] Hugetlb demotion for x86
From: Adam Litke <agl@us.ibm.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0605111607250.24407@blonde.wat.veritas.com>
References: <1147287400.24029.81.camel@localhost.localdomain>
	 <20060510200516.GA30346@infradead.org>
	 <1147293156.24029.95.camel@localhost.localdomain>
	 <20060510204928.GA31315@infradead.org>
	 <1147297535.24029.114.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0605111607250.24407@blonde.wat.veritas.com>
Content-Type: text/plain
Organization: IBM
Date: Thu, 11 May 2006 10:59:53 -0500
Message-Id: <1147363194.24029.128.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-05-11 at 16:15 +0100, Hugh Dickins wrote:
> On Wed, 10 May 2006, Adam Litke wrote:
> > 
> > Strict overcommit is there for shared mappings.  When private mapping
> 
> I presume that by "strict overcommit" you mean "strict no overcommit".
> 
> > support was added, people agreed that full overcommit should apply to
> > private mappings for the same reasons normal page overcommit is desired.
> 
> I'm not sure how wide that agreement was.  But what I wanted to say is...
> 
> > For one: an application using lots of private huge pages should not be
> > prohibited from forking if it's likely to just exec a small helper
> > program.
> 
> This is an excellent use for madvise(start, length, MADV_DONTFORK).
> Though it was added mainly for RDMA issues, it's a great way for a
> program with a huge commitment to exclude areas of its address space
> from the fork, so making that fork much more likely to succeed.

I guess it's time for me to take a step back and explain why I am doing
this.  libhugetlbfs (announced here recently) has the ability to remap
an executable's ELF segments into huge pages.  So madvise(MADV_DONTFORK)
would be pretty bad ;)

-- 
Adam Litke - (agl at us.ibm.com)
IBM Linux Technology Center

