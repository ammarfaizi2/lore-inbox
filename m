Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129130AbQJaRjI>; Tue, 31 Oct 2000 12:39:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129185AbQJaRi5>; Tue, 31 Oct 2000 12:38:57 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:51216 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129130AbQJaRip>; Tue, 31 Oct 2000 12:38:45 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: test10-pre7
Date: 31 Oct 2000 09:38:31 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8tn02n$ig3$1@cesium.transmeta.com>
In-Reply-To: <20001031075506.B1041@wire.cadcamlab.org> <Pine.LNX.4.10.10010310912050.6866-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.10.10010310912050.6866-100000@penguin.transmeta.com>
By author:    Linus Torvalds <torvalds@transmeta.com>
In newsgroup: linux.dev.kernel
> 
> On Tue, 31 Oct 2000, Peter Samuelson wrote:
> > 
> > The thing that Keith's patch does is flush these things out into the
> > open.  By using LINK_FIRST/LINK_LAST, we declare that "these are the
> > known issues" -- and then the rest of the objects are reordered, and if
> > something breaks, we track it down and add it to LINK_FIRST.
> 
> But it doesn't even WORK.
> 
> You need to have 
> 
> 	LINK_FIRST1
> 	LINK_FIRST2
> 	LINK_FIRST3
> 	...
> 
> etc to get the proper ordering.
> 
> USB is the _easy_ case. There happen sto be only one file that cares about
> ordering.
> 
> In many other cases, like SCSI, we need almost _total_ ordering. For such
> a case, theer is no "first" or "last" - there is a well-specific ORDER.
> 

Sounds like what you actually need is LINK_BEFORE() LINK_AFTER() and a
topological sort.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
