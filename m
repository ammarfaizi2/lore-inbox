Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751396AbVJQP17@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396AbVJQP17 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 11:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbVJQP17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 11:27:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12471 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751396AbVJQP16 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 11:27:58 -0400
Date: Mon, 17 Oct 2005 08:27:40 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@suse.de>
cc: Andrew Morton <akpm@osdl.org>, Ravikiran G Thirumalai <kiran@scalex86.org>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org, tglx@linutronix.de,
       shai@scalex86.org
Subject: Re: x86_64: 2.6.14-rc4 swiotlb broken
In-Reply-To: <200510171153.56063.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0510170819290.23590@g5.osdl.org>
References: <20051017093654.GA7652@localhost.localdomain>
 <20051017025007.35ae8d0e.akpm@osdl.org> <200510171153.56063.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 17 Oct 2005, Andi Kleen wrote:
> 
> The patch is actually not quite correct - in theory node 0 could be too small 
> to contain the full swiotlb bounce buffers.

Is node 0 guaranteed to be all low-memory? What if it allocates stuff at 
the end of memory on NODE(0)?

Anyway, it sounds like "alloc_bootmem_low_pages()" is seriously buggered 
if it allocates non-low pages, if only because of its name...

> The real fix would be to get rid of the pgdata lists and just walk the 
> node_online_map on bootmem.c. The memory hotplug guys have
> a patch pending for this.

Argh. Which one should I pick? The NODE(0) one looks simpler, but is it 
sufficient for now in practice (with the real one going into 2.6.14+)?

		Linus
