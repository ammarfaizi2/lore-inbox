Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316803AbSEVAx4>; Tue, 21 May 2002 20:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316804AbSEVAxz>; Tue, 21 May 2002 20:53:55 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:63250 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316803AbSEVAxy>; Tue, 21 May 2002 20:53:54 -0400
Date: Tue, 21 May 2002 17:54:18 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Roman Zippel <zippel@linux-m68k.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.17
In-Reply-To: <Pine.LNX.4.21.0205220227280.23394-100000@serv>
Message-ID: <Pine.LNX.4.44.0205211752350.3589-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 22 May 2002, Roman Zippel wrote:
> >
> > x86, to be exact ;(
>
> IMO that's not really problem, the pmd tables are created and destroyed
> with the pgd table.

unmap()?

That's the big one, actually. The exit case we _could_ do very differently
anyway, and there are reasons that we probably should try to.

(When we exit, we could flush the TLB and at the same time do a
"speculative" switch to the mm of the next process on the run-queue of
this CPU, so that when we actually tear down the MM we would have no TLB
issues at all any more).

		Linus

