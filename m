Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288921AbSAUBWY>; Sun, 20 Jan 2002 20:22:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288954AbSAUBWP>; Sun, 20 Jan 2002 20:22:15 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:52234 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S288921AbSAUBWA>;
	Sun, 20 Jan 2002 20:22:00 -0500
Date: Sun, 20 Jan 2002 23:21:14 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Hans Reiser <reiser@namesys.com>
Cc: Shawn Starr <spstarr@sh0n.net>, <linux-kernel@vger.kernel.org>
Subject: Re: Possible Idea with filesystem buffering.
In-Reply-To: <3C4B6867.8070302@namesys.com>
Message-ID: <Pine.LNX.4.33L.0201202318090.32617-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jan 2002, Hans Reiser wrote:
> Rik van Riel wrote:

> >If your ->writepage() writes pages to disk it just means
> >that reiserfs will be able to clean its pages faster than
> >the other filesystems.
>
> the logical extreme of this is that no write caching should be done at
> all, only read caching?

You know that's bad for write clustering ;)))

> >This means the VM will not call reiserfs ->writepage() as
> >often as for the other filesystems, since more of the
> >pages it finds will already be clean and freeable.
> >
> >I guess the only way to unbalance the caches is by actually
> >freeing pages in ->writepage, but I don't see any real reason
> >why you'd want to do that...
>
> It would unbalance the write cache, not the read cache.

Many workloads tend to read pages again after they've written
them, so throwing away pages immediately doesn't seem like a
good idea.

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

