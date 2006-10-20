Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751615AbWJTFyg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751615AbWJTFyg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 01:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751678AbWJTFyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 01:54:36 -0400
Received: from gate.crashing.org ([63.228.1.57]:16321 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751615AbWJTFyf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 01:54:35 -0400
Subject: Re: BUG: about flush TLB during unmapping a page in memory
	subsystem
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: yunfeng zhang <zyf.zeroos@gmail.com>
Cc: David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org
In-Reply-To: <4df04b840610192210x3d7de930k7be7dbf9e38819bd@mail.gmail.com>
References: <4df04b840610191947r2b48c2ddo45f0cd94d94a614b@mail.gmail.com>
	 <20061019.200211.88476455.davem@davemloft.net>
	 <4df04b840610192210x3d7de930k7be7dbf9e38819bd@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 20 Oct 2006 15:54:27 +1000
Message-Id: <1161323667.10524.147.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-10-20 at 13:10 +0800, yunfeng zhang wrote:
> Maybe, the solution is below
> 
> ...
> // >>> ptep_clear((__vma)->vm_mm, __address, __ptep);
> // >>> flush_tlb_page(__vma, __address);
> // >>> __ptep;
> ...
> 
> And even so, we also get a pte with present = 0 AND its dirty = 1, an odd pte.
> 
> Remember B dirtied the pte before A executes flush_tlb_page.

It's very much architecture specific. I suppose x86 must have some HW
requirements of checking if the PTE is still present atomically when
setting the dirty bit but I can't tell for sure :)

On PowerPC, we don't use HW dirty bits, we use SW for that, thus the
ptep_get_and_clear will be enough to prevent any further dirty bit to be
set.

Ben.


