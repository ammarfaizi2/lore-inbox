Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285127AbRLLJqc>; Wed, 12 Dec 2001 04:46:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285129AbRLLJqV>; Wed, 12 Dec 2001 04:46:21 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:53006 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S285127AbRLLJqI>;
	Wed, 12 Dec 2001 04:46:08 -0500
Date: Wed, 12 Dec 2001 07:45:45 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@zip.com.au>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.16 & OOM killer screw up (fwd)
In-Reply-To: <20011212102141.Q4801@athlon.random>
Message-ID: <Pine.LNX.4.33L.0112120739380.20576-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Dec 2001, Andrea Arcangeli wrote:
> On Wed, Dec 12, 2001 at 12:44:17AM -0800, Andrew Morton wrote:
> > Oh.  Maybe the core design (whatever it is :)) is not finished,
> > because it retains the bone-headed, dumb-to-the-point-of-astonishing
> > misfeature which Linux VM has always had:
> >
> > If someone is linearly writing (or reading) a gigabyte file on a 64
> > megabyte box they *don't* want the VM to evict every last little scrap
> > of cache on behalf of data which they *obviously* do not want
> > cached.
>
> The current design tries to detect this, at least much much better than
> 2.2. This is why I disagree with Rik's patch of yesterday.  detecting
> cache pollution is good also on the lowmem boxes (not only for DB).

Oh, absolutely. The problem just is that the current design
has even worse problems where it doesn't put any pressure on
pages which were touched twice an hour ago.

This leads to the situation that applications get OOM-killed
to preserve buffer cache memory which hasn't been touched
since bootup time.

There are ways to both have good behaviour on bulk IO and
flush out old data which was in active use but no longer is.
I believe these are called page aging and drop-behind.
I've been thinking about achieving the wanted behaviour
without these two, but haven't been able to come up with
any algorithm which doesn't have some very bad side effects.

If you know a way of doing bulk IO properly and flushing out
an old working set correctly, please let us know.

regards,

Rik
-- 
Shortwave goes a long way:  irc.starchat.net  #swl

http://www.surriel.com/		http://distro.conectiva.com/

