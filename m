Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319003AbSHMRyH>; Tue, 13 Aug 2002 13:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319004AbSHMRyG>; Tue, 13 Aug 2002 13:54:06 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:36364 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S319003AbSHMRyG>; Tue, 13 Aug 2002 13:54:06 -0400
Date: Tue, 13 Aug 2002 11:00:12 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] exit_free(), 2.5.31-A0
In-Reply-To: <Pine.LNX.4.44.0208131944280.5298-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0208131057390.9145-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 13 Aug 2002, Ingo Molnar wrote:
> 
> we dont really want any signal overhead, and we also dont want any extra
> context-switching to the 'master thread'. And there's no master thread
> anymore either.

That still doesn't make it any les crap: because any thread that exits 
without calling the "magic exit-flag interface" will then silently be 
lost, with no information left around anywhere.

The whole interface is bogus.

If you want to do this, you can do it at _clone_ time, by extending on the
notion of "when I die, tell the parent using signal X" and making that
notion be a more generic "when I die, do X", where "X" migh include 
updating some parent tables instead of sending a signal.

But the magic "exit_write()" has to die.

			Linus

