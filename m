Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274896AbRIVMgx>; Sat, 22 Sep 2001 08:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274898AbRIVMgn>; Sat, 22 Sep 2001 08:36:43 -0400
Received: from u-68-18.karlsruhe.ipdial.viaginterkom.de ([62.180.18.68]:16275
	"EHLO dea.linux-mips.net") by vger.kernel.org with ESMTP
	id <S274896AbRIVMg1>; Sat, 22 Sep 2001 08:36:27 -0400
Date: Sat, 22 Sep 2001 14:28:47 +0200
From: Ralf Baechle <ralf@conectiva.com.br>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Rik van Riel <riel@conectiva.com.br>,
        Manfred Spraul <manfred@colorfullife.com>,
        Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, torvalds@transmeta.com
Subject: Re: Purpose of the mm/slab.c changes
Message-ID: <20010922142847.A20641@dea.linux-mips.net>
In-Reply-To: <Pine.LNX.4.33L.0109091745130.21049-100000@duckman.distro.conectiva> <XFMail.20010909135844.davidel@xmailserver.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <XFMail.20010909135844.davidel@xmailserver.org>; from davidel@xmailserver.org on Sun, Sep 09, 2001 at 01:58:44PM -0700
X-Accept-Language: de,en,fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 09, 2001 at 01:58:44PM -0700, Davide Libenzi wrote:

> >> Do You see it as a plus ?
> >> The new allocated slab will be very likely written ( w/o regard
> >> about the old content ) and an L2 mapping will generate
> >> invalidate traffic.
> > 
> > If your invalidates are slower than your RAM, you should
> > consider getting another computer.
> 
> You mean a Sun, that uses a separate bus for snooping ? :)
> Besides to not under estimate the cache coherency traffic ( that on many CPUs
> uses the main memory bus ) there's the fact that the old data eventually
> present in L2 won't be used by the new slab user.

That's actually what having a slab cache of pre-initialized elements tries
to achieve.

On anything that uses a MESI-like cache coherence protocol a cached dirty
cache line that is written to will not cause any coherency traffic and
thus be faster.

  Ralf

--
"Embrace, Enhance, Eliminate" - it worked for the pope, it'll work for Bill.
