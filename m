Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286187AbRLJIFo>; Mon, 10 Dec 2001 03:05:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286188AbRLJIFe>; Mon, 10 Dec 2001 03:05:34 -0500
Received: from dsl092-237-176.phl1.dsl.speakeasy.net ([66.92.237.176]:3849
	"EHLO whisper.qrpff.net") by vger.kernel.org with ESMTP
	id <S286187AbRLJIFY>; Mon, 10 Dec 2001 03:05:24 -0500
Message-Id: <5.1.0.14.2.20011210024959.01c81c20@whisper.qrpff.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 10 Dec 2001 03:00:26 -0500
To: Robert Love <rml@tech9.net>
From: Stevie O <stevie@qrpff.net>
Subject: Re: "Colo[u]rs"
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1007969208.1237.32.camel@phantasy>
In-Reply-To: <5.1.0.14.2.20011210020236.01cca428@whisper.qrpff.net>
 <5.1.0.14.2.20011210020236.01cca428@whisper.qrpff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 02:26 AM 12/10/2001 -0500, Robert Love wrote:
>Cache color is how many indexes there are into a cache.  Caches
>typically aren't direct mapped: they are indexed into cache lines by a
>hash.  This means that certain memory values (of the 2^32 on your PC)
>will map to the same cache line.  This means only one can be there at
>the same time, and the newer one throws the old one out.
>
>Coloring of data structures is down to give random offsets to data such
>that they are not are multiples of the some value and thus don't map to
>the same cache line.  This is what Linux's slab allocator is meant to
>do.

(I'm not too familiar with how this caching stuff works, so if anyone could 
give me a URL describing it to a relative newbie, i'd be quite grateful)

So lemme see if I got this straight from what you and Larry have told me:

For the direct map deal:

For every byte (probably page?) in the CPU's cache, say byte(page) 0x31337 
can be used to cache the bytes(pages) at:
0x00031337, 0x00131337, 0x00231337, ... 0xfff31337

So, if a program ran, and happened to have its pages #0-4095 mapped to 
physical pages:
0x00031337, 0x00131337, 0x00231337, ... 0xfff31337

and the program went through an array and accessed each of those pages in 
sequence, every successive iteration would have to replace the previous 
page in the cache with the new one; i.e. exactly one of those pages would 
be in cache at any given time. Which would obviously make the program's 
performance suck majorly.

For the n-way associative deal:

Don't quite get it enough to make an example yet ;)


--
Stevie-O

Real programmers use COPY CON PROGRAM.EXE

