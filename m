Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271105AbRIFPIR>; Thu, 6 Sep 2001 11:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271106AbRIFPIG>; Thu, 6 Sep 2001 11:08:06 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:20752 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S271105AbRIFPHt>;
	Thu, 6 Sep 2001 11:07:49 -0400
Date: Thu, 6 Sep 2001 12:07:47 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Cc: Stephan von Krawczynski <skraw@ithnet.com>, <phillips@bonn-fries.net>,
        <jaharkes@cs.cmu.edu>, <marcelo@conectiva.com.br>,
        <linux-kernel@vger.kernel.org>
Subject: Re: page_launder() on 2.4.9/10 issue
In-Reply-To: <598034578.999792124@[10.132.112.53]>
Message-ID: <Pine.LNX.4.33L.0109061206020.31200-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Sep 2001, Alex Bligh - linux-kernel wrote:

> >> IE, in theory you could have half your memory free, but
> >> not be able to allocate a single 8k block. Nothing would cause
> >> cache, or InactiveDirty stuff to be written.
> >
> > Which is obviously not the right way to go. I guess we agree in that.
>
> Well, I agree that this is not desirable. I am not sure whether
> the right course is
>  (a) to avoid getting here,
>  (b) to do traditional page_launder() stuff, i.e. write stuff out,
>      and hope that fixes it
>  (c) to actively go defragment (Daniel P's prefered approach)
>  (d) some combination of the above.

On many systems, higher-order allocations are a really really
small fraction of the allocations, so ideally we'd have them
take the burden of memory fragmentation and won't punish the
normal allocations.

That pretty much rules out very strong forms of (a), things
like (b) and (c) are very possible to do and maybe even easy.

They also won't cause any overhead for normal allocations
since we'd only call them when needed.

regards,

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

