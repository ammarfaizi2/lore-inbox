Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287177AbSATV0L>; Sun, 20 Jan 2002 16:26:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287189AbSATVZw>; Sun, 20 Jan 2002 16:25:52 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:17425 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S287177AbSATVZc>;
	Sun, 20 Jan 2002 16:25:32 -0500
Date: Sun, 20 Jan 2002 19:24:57 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Hans Reiser <reiser@namesys.com>
Cc: Shawn <spstarr@sh0n.net>, <linux-kernel@vger.kernel.org>,
        Josh MacDonald <jmacd@CS.Berkeley.EDU>
Subject: Re: Possible Idea with filesystem buffering.
In-Reply-To: <3C4B3370.7020303@namesys.com>
Message-ID: <Pine.LNX.4.33L.0201201924020.32617-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jan 2002, Hans Reiser wrote:
> Rik van Riel wrote:
> >On Sun, 20 Jan 2002, Hans Reiser wrote:

> >Agreed on these points, but you really HAVE TO work towards
> >flushing the page ->writepage() gets called for.
> >
> >Think about your typical PC, with memory in ZONE_DMA,
> >ZONE_NORMAL and ZONE_HIGHMEM. If we are short on DMA pages
> >we will end up calling ->writepage() on a DMA page.
> >
> >If the filesystem ends up writing completely unrelated pages
> >and marking the DMA page in question referenced the VM will
> >go in a loop until the filesystem finally gets around to
> >making a page in the (small) DMA zone freeable ...
>
> This is a bug in VM design, yes?  It should signal that it needs the
> particular page written, which probnably means that it should use
> writepage only when it needs that particular page written,

That is exactly what the VM does.

> and should otherwise check to see if the filesystem supports something
> like pressure_fs_cache(), yes?

That's incompatible with the concept of memory zones.

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

