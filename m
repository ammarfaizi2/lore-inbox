Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315265AbSELAjI>; Sat, 11 May 2002 20:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315266AbSELAjH>; Sat, 11 May 2002 20:39:07 -0400
Received: from hq.fsmlabs.com ([209.155.42.197]:48135 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S315265AbSELAjF>;
	Sat, 11 May 2002 20:39:05 -0400
Date: Sat, 11 May 2002 18:36:16 -0600
From: yodaiken@fsmlabs.com
To: Lincoln Dale <ltd@cisco.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Larry McVoy <lm@bitmover.com>,
        Gerrit Huizenga <gh@us.ibm.com>, Andrew Morton <akpm@zip.com.au>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Padraig Brady <padraig@antefacto.com>,
        Anton Altaparmakov <aia21@cantab.net>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: O_DIRECT performance impact on 2.4.18 (was: Re: [PATCH] 2.5.14 IDE 56)
Message-ID: <20020511183616.A10381@hq.fsmlabs.com>
In-Reply-To: <20020511111935.B30126@work.bitmover.com> <Pine.LNX.4.44.0205111130080.879-100000@home.transmeta.com> <5.1.0.14.2.20020512092751.02bcca40@mira-sjcm-3.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



We did some i/o profiling about 6 years ago on a big scientific
 app that had started in fortran and had been rewritten in c++ 
the fortran code used r/w on files and used temp files
the c++ did memmaps and had big data structures - taking advantage of 
memory management.
one thing I thought was interesting is that it was easy to see how a smart
algorithm, not even such a smart one, could adapt i/o to the patterns of
i/o in the fortran code, but the c++ i/o patters were really complex. 

when everything goes into the page cache, it seems like you will loose
information.


On Sun, May 12, 2002 at 09:38:12AM +1000, Lincoln Dale wrote:
> as the person who started this whole thread and made the assertion that 
> copying from A to B is common:
> 
> At 11:35 AM 11/05/2002 -0700, Linus Torvalds wrote:
> >And I personally believe that "generate the data yourself" is actually a
> >very common case. A pure pipe between two places is not what a computer is
> >good at, or what a computer should be used for.
> 
> i think you'd be surprised.  if we include "pipe from disk to network" then 
> a large number of 'server' applications do exactly this.
> webservers do.  fileservers do. http caches do.  streaming-media servers do.
> 
> sure, they may add additional headers on the front and still generate 
> dynamic content in some cases, but the "common case" is 'pipe from disk to 
> network' or 'pipe from network to disk'.
> 'network' is typically TCP but can be UDP (with rate-limiting) in some cases.
> 
> 
> its very good to see this being discussed.  thats a large step forward from 
> many people believing the problem was nonexistent.
> 
> i'm skeptical that continuing to use the page-cache is the correct way to 
> go -- many of these kinds of applications are doing their own form of 
> memory-management and hot-content 'caching' so are happy to manage a 
> few-to-several hundred megabytes of "page cache equivalent" data themselves.
> at least on many of the 2.3.xx linux releases, that was one of the big 
> attractions of 'raw' devices -- they didn't get the box into an OOM situation.
> if 2.5.xx and recent 2.4.xx has the issues of 
> page-cache-doesn't-shrink-fast-enough solved, then its forseeable it will fly.
> 
> 
> cheers,
> 
> lincoln.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com

