Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261670AbVAISQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbVAISQt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 13:16:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261663AbVAISQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 13:16:48 -0500
Received: from [213.85.13.118] ([213.85.13.118]:17537 "EHLO tau.rusteko.ru")
	by vger.kernel.org with ESMTP id S261670AbVAISQl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 13:16:41 -0500
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Andrew Morton <akpm@osdl.org>, pmarques@grupopie.com, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, hch@infradead.org
Subject: Re: [RFC] per thread page reservation patch
References: <1105019521.7074.79.camel@tribesman.namesys.com>
	<20050107144644.GA9606@infradead.org>
	<1105118217.3616.171.camel@tribesman.namesys.com>
	<41DEDF87.8080809@grupopie.com> <m1llb5q7qs.fsf@clusterfs.com>
	<20050107132459.033adc9f.akpm@osdl.org> <m1d5wgrir7.fsf@clusterfs.com>
	<20050107150315.3c1714a4.akpm@osdl.org> <m18y74rfqs.fsf@clusterfs.com>
	<20050107154305.790b8a51.akpm@osdl.org> <20050109113551.GB9144@logos.cnet>
From: Nikita Danilov <nikita@clusterfs.com>
Date: Sun, 09 Jan 2005 21:16:24 +0300
In-Reply-To: <20050109113551.GB9144@logos.cnet> (Marcelo Tosatti's message
 of "Sun, 9 Jan 2005 09:35:51 -0200")
Message-ID: <m1k6qmcvt3.fsf@clusterfs.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.5 (chayote, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo.tosatti@cyclades.com> writes:

[...]

>
> - all instances of an allocator from the current thread will eat from the perthread
>   reserves, you probably want only a few special allocations to eat from the reserves?
>   Thing is its not really a reservation intended for emergency situations,
>   rather a "generic per-thread pool" the way things are now.

Per-thread reservations are only useful when they are transparent. If
users have to call special function, or to pass special flag to
__alloc_pages() they might just use mempool as well. Idea is to reserve
some number of pages before starting complex operation so that generic
function (like find_get_page()) called as part of this operation are
guaranteed to succeed.

>
> - its a real fast path, we're adding quite some instructions there which are only
>   used by reiserfs now.

Yes, this worries me too. Possibly we should move this check below in
__alloc_pages(), so that per-thread reservation is only checked if
fast-path allocation failed.

Nikita.
