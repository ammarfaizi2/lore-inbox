Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263019AbVALF7k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263019AbVALF7k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 00:59:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263023AbVALF7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 00:59:40 -0500
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:29303 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263019AbVALF7f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 00:59:35 -0500
Message-ID: <41E4BCBE.2010001@yahoo.com.au>
Date: Wed, 12 Jan 2005 16:59:26 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
CC: torvalds@osdl.org, Andi Kleen <ak@muc.de>, Hugh Dickins <hugh@veritas.com>,
       akpm@osdl.org, linux-mm@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: page table lock patch V15 [0/7]: overview
References: <Pine.LNX.4.44.0411221457240.2970-100000@localhost.localdomain> <Pine.LNX.4.58.0411221343410.22895@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0411221419440.20993@ppc970.osdl.org> <Pine.LNX.4.58.0411221424580.22895@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0411221429050.20993@ppc970.osdl.org> <Pine.LNX.4.58.0412011539170.5721@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0412011545060.5721@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0501041129030.805@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0501041137410.805@schroedinger.engr.sgi.com> <m1652ddljp.fsf@muc.de> <Pine.LNX.4.58.0501110937450.32744@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.58.0501110937450.32744@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> Changes from V14->V15 of this patch:

Hi,

I wonder what everyone thinks about moving forward with these patches?
Has it been decided that they'll be merged soon? Christoph has been
working fairly hard on them, but there hasn't been a lot of feedback.


And for those few people who have looked at my patches for page table
lock removal, is there is any preference to one implementation or the
other?

It is probably fair to say that my patches are more comprehensive
(in terms of ptl removal, ie. the complete removal**), and can allow
architectures to be more flexible in their page table synchronisation
methods.

However, Christoph's are simpler and probably more widely tested and
reviewed at this stage, and more polished. Christoph's implementation
probably also covers the most pressing performance cases.

On the other hand, my patches *do* allow for the use of a spin-locked
synchronisation implementation, which is probably closer to the
current code than Christoph's spin-locked pte_cmpxchg fallback in
terms of changes to locking semantics.


[** Aside, I didn't see a very significant improvement in mm/rmap.c
functions from ptl removal. Mostly I think due to contention on
mapping->i_mmap_lock (I didn't test anonymous pages, they may have
a better yield)]

