Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932308AbVLAQK0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308AbVLAQK0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 11:10:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932307AbVLAQK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 11:10:26 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:12719 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932304AbVLAQKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 11:10:24 -0500
Subject: Re: Better pagecache statistics ?
From: Arjan van de Ven <arjan@infradead.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-mm <linux-mm@kvack.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1133452790.27824.117.camel@localhost.localdomain>
References: <1133377029.27824.90.camel@localhost.localdomain>
	 <20051201152029.GA14499@dmt.cnet>
	 <1133452790.27824.117.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 01 Dec 2005 17:10:11 +0100
Message-Id: <1133453411.2853.67.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1.8 (+)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (1.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[213.93.14.173 listed in dnsbl.sorbs.net]
	1.7 RCVD_IN_NJABL_DUL      RBL: NJABL: dialup sender did non-local SMTP
	[213.93.14.173 listed in combined.njabl.org]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Out of "Cached" value - to get details like
> 
> 	<mmap> - xxx KB
> 	<shared mem> - xxx KB
> 	<text, data, bss, malloc, heap, stacks> - xxx KB
> 	<filecache pages total> -- xxx KB
> 		(filename1 or <dev>, <ino>) -- #of pages
> 		(filename2 or <dev>, <ino>) -- #of pages
> 		
> This would be really powerful on understanding system better.

to some extend it might be useful.
I have a few concerns though
1) If we make these stats into an ABI then it becomes harder to change
the architecture of the VM radically since such concepts may not even
exist in the new architecture. As long as this is some sort of advisory,
humans-only file I think this isn't too much of a big deal though.

2) not all the concepts you mention really exist as far as the kernel is
concerned. I mean.. a mmap file is file cache is .. etc.
malloc/heap/stacks are also not differentiated too much and are mostly
userspace policy (especially thread stacks). 

A split in
* non-file backed
  - mapped once
  - mapped more than once
* file backed
  - mapped at least once
  - not mapped
I can see as being meaningful. Assigning meaning to it beyond this is
dangerous; that is more an interpretation of the policy userspace
happens to use for things and I think coding that into the kernel is a
mistake.

Knowing which files are in memory how much is, as debug feature,
potentially quite useful for VM hackers to see how well the various VM
algorithms work. I'm concerned about the performance impact (eg you can
do it only once a day or so, not every 10 seconds) and about how to get
this data out in a consistent way (after all, spewing this amount of
debug info will in itself impact the vm balances)

Greetings,
    Arjan van de Ven

