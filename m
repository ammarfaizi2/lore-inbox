Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316184AbSEKA4J>; Fri, 10 May 2002 20:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316185AbSEKA4I>; Fri, 10 May 2002 20:56:08 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:51401 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S316184AbSEKA4I>;
	Fri, 10 May 2002 20:56:08 -0400
To: Linus Torvalds <torvalds@transmeta.com>
cc: Lincoln Dale <ltd@cisco.com>, Andrew Morton <akpm@zip.com.au>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Padraig Brady <padraig@antefacto.com>,
        Anton Altaparmakov <aia21@cantab.net>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: O_DIRECT performance impact on 2.4.18 (was: Re: [PATCH] 2.5.14 IDE 56) 
In-Reply-To: Your message of Fri, 10 May 2002 08:55:32 PDT.
             <Pine.LNX.4.44.0205100854370.2230-100000@home.transmeta.com> 
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <10065.1021078877.1@us.ibm.com>
Date: Fri, 10 May 2002 18:01:17 -0700
Message-Id: <E176LG9-0002cP-00@w-gerrit2>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0205100854370.2230-100000@home.transmeta.com>, > : Li
nus Torvalds writes:
> 
> 
> On Fri, 10 May 2002, Lincoln Dale wrote:
> >
> > so O_DIRECT in 2.4.18 still shows up as a 55% performance hit versus no
> > O_DIRECT. anyone have any clues?
> 
> Yes.
> 
> O_DIRECT isn't doing any read-ahead.
> 
> For O_DIRECT to be a win, you need to make it asynchronous.
> 
> 		Linus

O_DIRECT is especially useful for applications which maintain their
own cache, e.g. a database.  And adding Async to it is an even bigger
bonus (another Oracleism we did in PTX).  No read ahead, no attempt
to keep the buffer in memory until memory pressure kicks in.  Just
a good tool for doing random IO (like an OLTP database would do).

gerrit
