Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269808AbRHDGDh>; Sat, 4 Aug 2001 02:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269809AbRHDGD1>; Sat, 4 Aug 2001 02:03:27 -0400
Received: from www.wen-online.de ([212.223.88.39]:11788 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S269808AbRHDGDJ>;
	Sat, 4 Aug 2001 02:03:09 -0400
Date: Sat, 4 Aug 2001 08:02:23 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Rik van Riel <riel@conectiva.com.br>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Jeremy Linton <jlinton@interactivesi.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Free memory starvation in a zone?
In-Reply-To: <Pine.LNX.4.33L.0108040243040.2526-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.LNX.4.33.0108040749010.1063-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Aug 2001, Rik van Riel wrote:

> On Sat, 4 Aug 2001, Mike Galbraith wrote:
>
> > > Are you sure you're seeing kreclaimd looping too much here ?
> >
> > Snippet from one of Dirk's logs.
> >
> >   PID  PPID USER     PRI  SIZE SWAP  RSS SHARE   D STAT %CPU %MEM   TIME COMMA
> >     3     1 root      20     0    0    0     0   0 RW   58.8  0.0   2:41 kswapd
> >  1494  1421 novatest  15 2009M 640M 1.3G 51476  0M R N  40.8 34.5   6:26 ceqsim
> >  1751  1747 root      14  1048    4 1044   824  55 R    28.0  0.0   0:02 top
> >     4     1 root      14     0    0    0     0   0 SW   27.1  0.0   1:06 krecla
>
> I'm pretty sure this is because kreclaimd is woken up from
> __alloc_pages() all the time and cannot find anything useful
> to do ...

Yes, it could be bouncing (eg) referenced pages instead of looping.

In any case though, seems it would it be better to take locks, evaluate
once and free in batch.  With the possibility to bounce off of locks,
it does look like looping is possible (if unlikely).  Just picking a
quantity and freeing it instead of reevaluating constantly would close
off that possibility without batch freeing.

	-Mike

