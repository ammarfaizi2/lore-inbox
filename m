Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288986AbSAUAtB>; Sun, 20 Jan 2002 19:49:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288987AbSAUAsw>; Sun, 20 Jan 2002 19:48:52 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:34057 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S288986AbSAUAsf>;
	Sun, 20 Jan 2002 19:48:35 -0500
Date: Sun, 20 Jan 2002 22:47:39 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Hans Reiser <reiser@namesys.com>
Cc: Shawn Starr <spstarr@sh0n.net>, <linux-kernel@vger.kernel.org>
Subject: Re: Possible Idea with filesystem buffering.
In-Reply-To: <3C4B60A1.3030302@namesys.com>
Message-ID: <Pine.LNX.4.33L.0201202242240.32617-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jan 2002, Hans Reiser wrote:

> Suppose we do what you ask, and always write the page (as well as some
> other pages) to disk.  This will result in the filesystem cache as a
> whole receiving more pressure than other caches that only write one
> page in response to pressure.  This is unbalanced, leads to some
> caches having shorter average page lifetimes than others, and it is
> therefor suboptimal.  Yes?

If your ->writepage() writes pages to disk it just means
that reiserfs will be able to clean its pages faster than
the other filesystems.

This means the VM will not call reiserfs ->writepage() as
often as for the other filesystems, since more of the
pages it finds will already be clean and freeable.

I guess the only way to unbalance the caches is by actually
freeing pages in ->writepage, but I don't see any real reason
why you'd want to do that...

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

