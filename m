Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318190AbSIEUao>; Thu, 5 Sep 2002 16:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318196AbSIEUan>; Thu, 5 Sep 2002 16:30:43 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:17417 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318190AbSIEUan>; Thu, 5 Sep 2002 16:30:43 -0400
Date: Thu, 5 Sep 2002 13:38:05 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <akpm@zip.com.au>
cc: Suparna Bhattacharya <suparna@in.ibm.com>, Jens Axboe <axboe@suse.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: One more bio for for floppy users in 2.5.33..
In-Reply-To: <Pine.LNX.4.33.0209051310190.5983-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0209051336440.5983-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 5 Sep 2002, Linus Torvalds wrote:
> 
> With partial results, it would need to do only a slightly different 
> traversal:
> 
> 	end = bio->bi_io_vec + bio->bi_vcnt*PAGE_SIZE - bio->bi_size
> 
> 	start = end - nr_sectors * 512
> 
> 	PAGE_ALIGN(start)
> 	PAGE_ALIGN(end)
> 
> but it's otherwise the exact same code (doing all the edge calculations in 
> bytes, and then only traversing pages that have now been fully done and 
> weren't fully done last time).
> 
> It _looks_ like it literally needs just a few lines of changes.

Ok, so we now have two "few lines of code" changes. Who wants to actually
_do_ these? I'll do it if nobody else wants to, but I'd much rather see
somebody else _do_ want to do this and test it out and just send me a
tested patch ;)

		Linus

