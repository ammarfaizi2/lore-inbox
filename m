Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288638AbSADOMM>; Fri, 4 Jan 2002 09:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288639AbSADOMC>; Fri, 4 Jan 2002 09:12:02 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:60270 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S288638AbSADOLp>; Fri, 4 Jan 2002 09:11:45 -0500
Date: Fri, 4 Jan 2002 15:11:27 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "M.H.VanLeeuwen" <vanl@megsinet.net>
Cc: Stephan von Krawczynski <skraw@ithnet.com>, andihartmann@freenet.de,
        riel@conectiva.com.br, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020104151127.L1561@athlon.random>
In-Reply-To: <Pine.LNX.4.33L.0112292256490.24031-100000@imladris.surriel.com> <3C2F04F6.7030700@athlon.maya.org> <3C309CDC.DEA9960A@megsinet.net> <20011231185350.1ca25281.skraw@ithnet.com> <3C351012.9B4D4D6@megsinet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3C351012.9B4D4D6@megsinet.net>; from vanl@megsinet.net on Thu, Jan 03, 2002 at 08:14:42PM -0600
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03, 2002 at 08:14:42PM -0600, M.H.VanLeeuwen wrote:
> Stephan von Krawczynski wrote:
> > 
> > On Mon, 31 Dec 2001 11:14:04 -0600
> > "M.H.VanLeeuwen" <vanl@megsinet.net> wrote:
> > 
> > > [...]
> > > vmscan patch:
> > >
> > > a. instead of calling swap_out as soon as max_mapped is reached, continue to
> > try>    to free pages.  this reduces the number of times we hit
> > try_to_free_pages() and>    swap_out().
> > 
> > I experimented with this some time ago, but found out it hit performance and
> > (to my own surprise) did not do any good at all. Have you tried this
> > stand-alone/on top of the rest to view its results?
> > 
> > Regards,
> > Stephan
> 
> Stephan,
> 
> Here is what I've run thus far.  I'll add nfs file copy into the mix also...
> 
> System: SMP 466 Celeron 192M RAM, running KDE, xosview, and other minor apps.
> 
> Each run after clean & cache builds has 1 more setiathome client running upto a
> max if 8 seti clients.  No, this isn't my normal way of running setiathome, but
> each instance uses a nice chunk of memory.
> 
> Note: this is a single run for each of the columns using "make -j2 bzImage" each time.
> 
> I will try to run aa and rmap this evening and/or tomorrow.

The design changes Linus did was explicitly to left the mapped pages
into the inactive list so we learn when we should trigger swapout. Also
it is nicer to swapout over the shrinking. rc2aa2 should work just fine.
Have a look at how such logic is implemented there. (btw, I will shortly
sync with 18pre, 2.2 and 2.5)

Andrea
