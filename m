Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129977AbQLVXnv>; Fri, 22 Dec 2000 18:43:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130133AbQLVXnm>; Fri, 22 Dec 2000 18:43:42 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:33037 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S129977AbQLVXne>;
	Fri, 22 Dec 2000 18:43:34 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200012222311.eBMNBgr459298@saturn.cs.uml.edu>
Subject: Re: bigphysarea support in 2.2.19 and 2.4.0 kernels
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Fri, 22 Dec 2000 18:11:42 -0500 (EST)
Cc: middelink@polyware.nl (Pauline Middelink), linux-kernel@vger.kernel.org,
        jmerkey@timpanogas.org
In-Reply-To: <E149O2D-0004M0-00@the-village.bc.nu> from "Alan Cox" at Dec 22, 2000 08:58:39 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> bigmem is 'last resort' stuff. I'd much rather it is as now a
> seperate allocator so you actually have to sit and think and
> decide to give up on kmalloc/vmalloc/better algorithms and
> only use it when the hardware sucks

It isn't just for sucky hardware. It is for performance too.

1. Linux isn't known for cache coloring ability. Even if it was,
   users want to take advantage of large pages or BAT registers
   to reduce TLB miss costs. (that is, mapping such areas into
   a process is needed... never mind security for now)

2. Programming a DMA controller with multiple addresses isn't
   as fast as programming it with one.

Consider what happens when you have the ability to make one
compute node DMA directly into the physical memory of another.
With a large block of physical memory, you only need to have
the destination node give the writer a single physical memory
address to send the data to. With loose pages, the destination
has to transmit a great big list. That might be 30 thousand!

The point of all this is to crunch data as fast as possible,
with Linux mostly getting out of the way. Perhaps you want
to generate real-time high-resolution video of a human heart
as it beats inside somebody. You process raw data (audio, X-ray,
magnetic resonance, or whatever) on one group of processors,
then hand off the data to another group of processors for the
rendering task. Actually there might be many stages. Playing
games with individual pages will cut into your performance.
The data stream is fat and relentless.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
