Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276576AbRJGSnd>; Sun, 7 Oct 2001 14:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276587AbRJGSnN>; Sun, 7 Oct 2001 14:43:13 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:53816 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S276576AbRJGSnK>; Sun, 7 Oct 2001 14:43:10 -0400
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Cc: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        Rik van Riel <riel@conectiva.com.br>,
        Krzysztof Rusocki <kszysiu@main.braxis.co.uk>, linux-xfs@oss.sgi.com,
        linux-kernel@vger.kernel.org,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: %u-order allocation failed
In-Reply-To: <Pine.LNX.3.96.1011006210743.7808D-100000@artax.karlin.mff.cuni. cz>
	<482450248.1002414411@[195.224.237.69]>
From: ebiederman@uswest.net (Eric W. Biederman)
In-Reply-To: <482450248.1002414411@[195.224.237.69]>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
Date: 07 Oct 2001 12:32:55 -0600
Message-ID: <m1u1xbwbag.fsf@frodo.biederman.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Bligh - linux-kernel <linux-kernel@alex.org.uk> writes:

> Mikulas,
> 
> > It uses vmalloc only when __GFP_VMALLOC flag is given - and so it is
> > expected to not use __GFP_VMALLOC flag in IRQ.
> 
> Ah OK. If your point is that people use GFP_ATOMIC when it's
> not needed, and demand physically contiguous memory when only
> virtually contiguous memory is needed, in several places in
> the kernel, then you are correct. [I am not convinced that
> vmalloc() is the best way to fix it though.]
> 
> Most of the order>0 users of __get_free_pages() don't
> 'need' to do that. For instance I was convinced that networking
> code needed this for larger than 4k packets (pre-fragmentation
> or post-prefragmentation) until someone pointed out that
> the kiovec stuff was there, waiting to be used, if someone
> made the code changes. But the code changes are non-trivial.

The zero copy stuff introduced in 2.4.4 allows for skb fragments.
I haven't seen any of the network drivers using it on their receive
path but it should be possible.

> Note also that something (not sure what) has made fragmentation
> increasingly prevalent over the years since the buddy allocator
> was originally put in. 

Actually it seems to be situations like the stack now being two
contiguous pages instead of one, where the demand for contiguous
memory has increased instead of the amount of fragmentation having
increased. 

Eric
