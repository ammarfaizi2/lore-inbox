Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277022AbRJQSGD>; Wed, 17 Oct 2001 14:06:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276695AbRJQSFw>; Wed, 17 Oct 2001 14:05:52 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:33287 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S277022AbRJQSFk>; Wed, 17 Oct 2001 14:05:40 -0400
Date: Wed, 17 Oct 2001 14:44:39 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Paul Gortmaker <p_gortmaker@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Making diff(1) of linux kernels faster
In-Reply-To: <Pine.LNX.4.33.0110170949370.17757-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0110171442580.11099-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 17 Oct 2001, Linus Torvalds wrote:

> 
> On Wed, 17 Oct 2001, Paul Gortmaker wrote:
> >
> > Oh, and prereading the dirs of both trees (vs. just one and letting
> > normal execution read in the 2nd) seems to offer better improvements.
> > (Steady stream of requests results in better merging perhaps?)
> 
> That doesn't make much sense, but I'll take your word for it. Does this
> behaviour show up on 2.4.x too? It sounds like a performance buglet in the
> kernel or some infrastructure, really.
> 
> The one problem with pre-reading is that it will now artificially touch
> the data twice, and when running on 2.4.x it will activate the pages.
> That's going to be exactly what _I_ want it to do on my machine, but
> others are likely to be less happy about it.
> 
> Btw, why use "slurp()" and actually doing the memory allocations etc, only
> to throw it away again? It would be better to either really keep the
> allocation around (which would also fix the touch-twice issue but would
> cause much more changes to 'diff'), or to just read into the same buffer
> over and over again..
> 
> And I've for a long time thought about adding a "readahead()" system call.
> There are just too many uses for it, it has come up in many different
> areas..

There is a paper on USENIX 2001 which does implement directory readahead
and it shows huge improvements for some workload. 

I'll dig it down and see if I can find that. 

