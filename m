Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750928AbVKDVbY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750928AbVKDVbY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 16:31:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750933AbVKDVbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 16:31:24 -0500
Received: from xproxy.gmail.com ([66.249.82.200]:16750 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750923AbVKDVbX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 16:31:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JlDWuKcm1QcElHrLfYWfC5Ct1YV7P59vfIeaEjwDdi7yG0vj7QPZqBbqG9U4tFFT/n6PCarkJuFwdABmPIRXb8uw9oTGg94/9xF0jYNfP9Lu8EB5AxtCiMcQMbeLatD4Kq0axjwz8z8xJ14U05hKJtE17N3KxSNNvCtOEBi2a54=
Message-ID: <e692861c0511041331ge5dd1abq57b6c513540fa200@mail.gmail.com>
Date: Fri, 4 Nov 2005 16:31:23 -0500
From: Gregory Maxwell <gmaxwell@gmail.com>
To: Andy Nelson <andy@thermo.lanl.gov>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Cc: mingo@elte.hu, akpm@osdl.org, arjan@infradead.org, arjanv@infradead.org,
       haveblue@us.ibm.com, kravetz@us.ibm.com,
       lhms-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, mbligh@mbligh.org, mel@csn.ul.ie,
       nickpiggin@yahoo.com.au, torvalds@osdl.org
In-Reply-To: <20051104210418.BC56F184739@thermo.lanl.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051104201248.GA14201@elte.hu>
	 <20051104210418.BC56F184739@thermo.lanl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/4/05, Andy Nelson <andy@thermo.lanl.gov> wrote:
> I am not enough of a kernel level person or sysadmin to know for certain,
> but I have still big worries about consecutive jobs that run on the
> same resources, but want extremely different page behavior. I

Thats the idea. The 'hugetlb zone' will only be usable for allocations
which are guaranteed reclaimable.  Reclaimable includes userspace
usage (since at worst an in use userspace page can be swapped out then
paged back into another physical location).

For your sort of mixed use this should be a fine solution. However
there are mixed use cases that that this will not solve, for example
if the system usage is split between HPC uses and kernel allocation
heavy workloads (say forking 10quintillion java processes) then the
hugetlb zone will need to be made small to keep the kernel allocation
heavy workload happy.
