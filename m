Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267392AbTBXU5e>; Mon, 24 Feb 2003 15:57:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267466AbTBXU5d>; Mon, 24 Feb 2003 15:57:33 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:64776 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267392AbTBXU5b>; Mon, 24 Feb 2003 15:57:31 -0500
Date: Mon, 24 Feb 2003 13:02:39 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Martin Schwidefsky <schwidefsky@de.ibm.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] s390 (7/13): gcc 3.3 adaptions.
In-Reply-To: <Pine.LNX.3.95.1030224143236.14614A-100000@chaos>
Message-ID: <Pine.LNX.4.44.0302241259320.13406-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 24 Feb 2003, Richard B. Johnson wrote:
> 
> I think you must keep these warnings in! There are many bugs
> that these uncover uncluding loops that don't terminate correctly
> but seem to work for "most all" cases. These are the hard-to-find
> bugs that hit you six months after release.

At least historically gcc has been so f*cking bad at the "unsigned vs 
signed" warnings that they are totally useless.

Maybe things are better in gcc-3.3.

Maybe not.


> size_t i;
> 
>    while((i = do_forever()) > 0)
>           ;
> 
> ... do_forever() finally errors out and returns -1 stuck(forever).

Does gcc still warn about things like

	#define COUNT (sizeof(array)/sizeof(element))

	int i;
	for (i = 0; i < COUNT; i++)
		...

where COUNT is obviously unsigned (because sizeof is size_t and thus 
unsigned)?

Gcc used to complain about things like that, which is a FUCKING DISASTER. 

Any compiler that complains about the above should be shot in the head, 
and the warning should be killed.

		Linus

