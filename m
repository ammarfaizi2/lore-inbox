Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265486AbTF2AUQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 20:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265489AbTF2AUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 20:20:16 -0400
Received: from franka.aracnet.com ([216.99.193.44]:50308 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S265486AbTF2AUN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 20:20:13 -0400
Date: Sat, 28 Jun 2003 17:34:05 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Christoph Hellwig <hch@infradead.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.73-mm2
Message-ID: <56960000.1056846845@[10.10.2.4]>
In-Reply-To: <20030628170837.A10514@infradead.org>
References: <20030627202130.066c183b.akpm@digeo.com> <20030628155436.GY20413@holomorphy.com> <20030628170837.A10514@infradead.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Christoph Hellwig <hch@infradead.org> wrote (on Saturday, June 28, 2003 17:08:37 +0100):

> On Sat, Jun 28, 2003 at 08:54:36AM -0700, William Lee Irwin III wrote:
>> +config HIGHPMD
>> +	bool "Allocate 2nd-level pagetables from highmem"
>> +	depends on HIGHMEM64G
>> +	help
>> +	  The VM uses one pmd entry for each pagetable page of physical
>> +	  memory allocated. For systems with extreme amounts of highmem,
>> +	  this cannot be tolerated. Setting this option will put
>> +	  userspace 2nd-level pagetables in highmem.
> 
> Does this make sense for !HIGHPTE?  In fact does it make sense to
> carry along HIGHPTE as an option still? ..

Last time I measured it, it had about a 10% overhead in kernel time.
Seems like a good thing to keep as an option to me. Bill said he
had some other code to alleviate the overhead, but I don't think
it's merged ... I'd rather see UKVA (permanently map the pagetables
on a per-process basis) merged before it becomes "not an option" -
that gets rid of all the kmapping.
 
M.
