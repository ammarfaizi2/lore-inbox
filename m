Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750956AbVKKS5E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbVKKS5E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 13:57:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751020AbVKKS5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 13:57:04 -0500
Received: from nproxy.gmail.com ([64.233.182.206]:43333 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750956AbVKKS5D convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 13:57:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=b9b7bwwx9GY8/hRnEa4ndz84YDnXf6E1Kse4jZNwYmDpEedSDDMsDK0iEoCyIUymxygYb9SK1KAmtPRxcexf/68TzWo1900bAEyjfjBmJ4T+qb5ec+6aNku7y5VWxFGIe0iSXFbL0kQ8pxiS35waHqrJ5nq3GF+0JMNf9v4+TyQ=
Message-ID: <2cd57c900511111057n3a7741ddw@mail.gmail.com>
Date: Sat, 12 Nov 2005 02:57:02 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [patch 02/02] Debug option to write-protect rodata: the write protect logic and config option
Cc: Josh Boyer <jdub@us.ibm.com>, linux-kernel@vger.kernel.org, ak@suse.de,
       akpm@osdl.org, coywolf@sosdg.org
In-Reply-To: <1131702428.2833.8.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051107105624.GA6531@infradead.org>
	 <20051107105807.GB6531@infradead.org>
	 <1131372374.23658.1.camel@windu.rchland.ibm.com>
	 <1131373248.2858.17.camel@laptopd505.fenrus.org>
	 <2cd57c900511110139v221ed3f3m@mail.gmail.com>
	 <1131702428.2833.8.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/11/11, Arjan van de Ven <arjan@infradead.org>:
> > people objecting to that.
> > >
> > > (It's not clear cut: while the last bit of the kernel no longer is
> > > covered by a 2Mb tlb, most intel cpus have very few of such tlbs in the
> > > first place and this would free up one such tlb for other things (say
> > > the stack data) or even the userspace database), so it's not all that
> > > clear cut what the cost of this is)
> >
> > I'm dumb. But how is "the last bit of the kernel no longer is covered
> > by a 2Mb tlb"? Could you explain a bit more?
>
> in memory it'll look something like this
>
> 0                 2                   4                         6
> -- kernel text -- + -- kernel text -- + --- k. text-- rodata -- + --
>
> normally the range from 0 to 6 is covered with 2Mb tlb's.
> Now to make rodata read only, the hugetlb entry covering 4-6 Mb range
> needs to be split into 4Kb entries, so that the rodata portion can have
> different permissions than the rest of that range.

Indeed. Thanks.

And we could also mark text section read-only and data/stack section
noexec if NX is supported. But I doubt the whole thing would really
help much. Kill the kernel thread? We can't. We only run into a panic.
Anyway I'd attach a quick patch to mark text section read only in the
next mail.

If it's ok, I'd add Kconfig support. Comments?
--
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
