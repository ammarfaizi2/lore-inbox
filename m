Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129054AbQJaSW4>; Tue, 31 Oct 2000 13:22:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129041AbQJaSWq>; Tue, 31 Oct 2000 13:22:46 -0500
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:41711 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S129029AbQJaSWc>; Tue, 31 Oct 2000 13:22:32 -0500
Date: Tue, 31 Oct 2000 19:22:30 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
        Linux kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: kmalloc() allocation.
Message-ID: <20001031192229.G7204@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <20001031161753.F7204@nightmaster.csn.tu-chemnitz.de> <Pine.LNX.4.21.0010311410440.23139-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.21.0010311410440.23139-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Tue, Oct 31, 2000 at 02:11:24PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2000 at 02:11:24PM -0200, Rik van Riel wrote:
[PCAC]
> It's a nice idea, but you still want to be sure you won't
> allocate eg. page tables randomly in the middle of the
> PCACs ;)

Yes. That's why we check later, whether our hint is still true.

If we cannot free or move all pages from this area, we retry by
looking up the PCAC again (which I forgot to show, because I was
in a hurry :-/ ), or try the old method and might fail there.

So we have only an idea, where we MIGHT have an physical area of
this size, but have no idea whether it is STILL freeable or
movable.

That's why I didn't care about ANY locking[1]. The only thing, that
I take for granted, is that all struct phys_page are linked
together and represent the whole systems physical memory
including holes. Anything that breaks these assumption must be
fixed in my code.

Once you have implemented physical page scanning, I'll try to
implement this. I just needed to know, whether you like the idea,
or it is total crap ;-)

Another problem is, that the PCAC needs memory to store these
areas. One possibility is to store in in struct phys_page and
have a global hash table for the sizes. But these are details for
2.5 and not for now ;-)

Regards

Ingo Oeser

[1] Later I have to lock the PCAC related structures of course.
-- 
Feel the power of the penguin - run linux@your.pc
<esc>:x
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
