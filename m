Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261310AbSLCNr5>; Tue, 3 Dec 2002 08:47:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261346AbSLCNr5>; Tue, 3 Dec 2002 08:47:57 -0500
Received: from uucp.cistron.nl ([62.216.30.38]:54022 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id <S261310AbSLCNr4>;
	Tue, 3 Dec 2002 08:47:56 -0500
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: [PATCH] 2.4.20-rmap15a
Date: Tue, 3 Dec 2002 13:55:26 +0000 (UTC)
Organization: Cistron
Message-ID: <asid4e$ci$1@ncc1701.cistron.net>
References: <Pine.LNX.4.44L.0212011833310.15981-100000@imladris.surriel.com>
Content-Type: text/plain; charset=iso-8859-15
X-Trace: ncc1701.cistron.net 1038923726 402 62.216.29.67 (3 Dec 2002 13:55:26 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.44L.0212011833310.15981-100000@imladris.surriel.com>,
Rik van Riel  <riel@conectiva.com.br> wrote:
>This is a merge of rmap15a with marcelo's 2.4 bitkeeper tree,
>which is identical to 2.4.20-rc4 (he didn't push the makefile
>update).  The only thing left out of the merge for now is
>Andrew Morton's read_latency patch, both because I'm not sure
>how needed it is with the elevator updates and because this
>part of the merge was too tricky to do at merge time; I'll port
>over Andrew Morton's read_latency patch later...

Just FYI:

I've tried this on our peering newsserver, you know, the same one
I tried a couple of 2.5.4X kernels on (Andrew knows ...)

Basically, performance sucks with rmap15a, with or without readlatency2.
See http://stats.cistron.nl/mrtg/html/wormhole.html

Monday  2-dec 16:00 -- Tuesday 3-dec 12:00	rmap15a + rl2
Tuesday 3-dec 12:00 -- Tuesday 3-dec 14:00	rmap15a
Tuesday 3-dec 14:20 -- now			2.4.20 vanilla

As you can see, the server accepted a lot less articles when
running rmap, as a result outgoing bandwidth dropped too.

I have no idea how to find out what the exact cause of this is,
so I didn't (it's still a production server and I can't let
it limp along for a too long period of time) that's why I
started with 'just FYI'. BTW, the server is not into swap - it
just looks like the working set of innd (the main article
accepting process) which includes mmap()s of the history
database is getting pushed out of memory by streaming IO,
which is really bad for performance. 2.4.20 does better on
this, and 2.5 a bit more even (but isn't stable)

Mike.
-- 
They all laughed when I said I wanted to build a joke-telling machine.
Well, I showed them! Nobody's laughing *now*! -- acesteves@clix.pt

