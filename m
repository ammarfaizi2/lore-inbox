Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319088AbSHMSLE>; Tue, 13 Aug 2002 14:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319090AbSHMSLE>; Tue, 13 Aug 2002 14:11:04 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:62733 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S319088AbSHMSLC>; Tue, 13 Aug 2002 14:11:02 -0400
Date: Tue, 13 Aug 2002 11:17:10 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] exit_free(), 2.5.31-A0
In-Reply-To: <Pine.LNX.4.44.0208131959160.5990-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0208131112270.7411-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 13 Aug 2002, Ingo Molnar wrote:
> > 
> > That still doesn't make it any les crap: because any thread that exits
> > without calling the "magic exit-flag interface" will then silently be
> > lost, with no information left around anywhere.
> 
> that should be a pretty rare occurance: with the upcoming signals patch
> any segmentation fault zaps all threads and does a proper (and
> deadlock-free) multithreaded coredump.

That still doesn't change the fact that the interface is broken
_by_design_.

If the parent wants to get notified on child death, it should damn well 
get notified on child death. Not "in case the child exists politely".

We don't depend on processes calling "exit()" to clean up all the stuff 
they left behind. The VM gets cleaned up even for bad processes. 

		Linus

