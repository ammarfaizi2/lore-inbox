Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318101AbSIES4P>; Thu, 5 Sep 2002 14:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318113AbSIES4O>; Thu, 5 Sep 2002 14:56:14 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:53266 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318101AbSIES4O>; Thu, 5 Sep 2002 14:56:14 -0400
Date: Thu, 5 Sep 2002 12:03:30 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <akpm@zip.com.au>
cc: Suparna Bhattacharya <suparna@in.ibm.com>, Jens Axboe <axboe@suse.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: One more bio for for floppy users in 2.5.33..
In-Reply-To: <3D77A58F.B35779A1@zip.com.au>
Message-ID: <Pine.LNX.4.33.0209051155091.1307-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 5 Sep 2002, Andrew Morton wrote:
>
> It would be simpler if it was nr_of_pages_completed.

Well.. Maybe.

I actually think that you in practice really only have two cases:

 - we only care about full completion. Easily tested for by just looking 
   at bi_size, and leaving the code as it is right now.

 - the code really cares about and uses the incremental information. At 
   which point it will already have "handled" any previous incremental 
   stuff, and the only thing it really cares about is the "new increment".

So I'd suggest making at least the first cut only have the incremental 
information, since the global information already exists through bi_size.

		Linus

