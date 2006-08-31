Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751137AbWHaKZ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137AbWHaKZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 06:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751071AbWHaKZ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 06:25:27 -0400
Received: from ns.suse.de ([195.135.220.2]:16546 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751428AbWHaKZ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 06:25:26 -0400
From: Andi Kleen <ak@suse.de>
To: Akinobu Mita <mita@miraclelinux.com>
Subject: Re: [patch 3/6] fault-injection capability for alloc_pages()
Date: Thu, 31 Aug 2006 12:25:02 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, okuji@enbug.org
References: <20060831100756.866727476@localhost.localdomain> <20060831100820.697247381@localhost.localdomain>
In-Reply-To: <20060831100820.697247381@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608311225.02101.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 31 August 2006 12:07, Akinobu Mita wrote:
> This patch provides fault-injection capability for alloc_pages()
> 
> boot option:
> 
> 	fail_page_alloc=<probability>,<interval>,<times>,<space>
> 
> 	<probability>
> 
> 		specifies how often it should fail in percent.
> 
> 	<interval>
> 
> 		specifies the interval of failures.
> 
> 	<times>
> 
> 		specifies how many times failures may happen at most.
> 
> 	<space>
> 
> 		specifies the size of free space where memory can be allocated
> 		safely in pages.
> 
> Example:
> 
> 	fail_page_alloc=100,10,-1,0
> 
> page allocation fails once per 10 times.

I still think this will need some better filters to be useful. At least
a optional uid filter perhaps (make sure to handle the interrupt case
correctly, interrupts don't belong to the uid) , and perhaps an option to only 
fail GFP_ATOMIC.

With arbitary failing the system will just be unusable, right? Or would
you run some system you use this way? @)

Another possibility would be to look up __builtin_return_address(0) in 
the module table and allow failing only for a specific module.


-andi
