Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275398AbRJYQbY>; Thu, 25 Oct 2001 12:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275126AbRJYQbE>; Thu, 25 Oct 2001 12:31:04 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:2824 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S274255AbRJYQbB>; Thu, 25 Oct 2001 12:31:01 -0400
Date: Thu, 25 Oct 2001 09:31:12 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Zlatko Calusic <zlatko.calusic@iskon.hr>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>, <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: xmm2 - monitor Linux MM active/inactive lists graphically
In-Reply-To: <dnvgh351i1.fsf@magla.zg.iskon.hr>
Message-ID: <Pine.LNX.4.31.0110250920270.2184-100000@cesium.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 25 Oct 2001, Zlatko Calusic wrote:
>
> Yes, I definitely have DMA turned ON. All parameters are OK. :)

I suspect it may just be that "queue_nr_requests"/"batch_count" is
different in -ac: what happens if you tweak them to the same values?

(See drivers/block/ll_rw_block.c)

I think -ac made the queues a bit deeper the regular kernel does 128
requests and a batch-count of 16, I _think_ -ac does something like "2
requests per megabyte" and batch_count=32, so if you have 512MB you should
try with

	queue_nr_requests = 1024
	batch_count = 32

Does that help?

		Linus

