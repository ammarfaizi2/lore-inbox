Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285093AbSAUMMg>; Mon, 21 Jan 2002 07:12:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285226AbSAUMM1>; Mon, 21 Jan 2002 07:12:27 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:42244 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S285093AbSAUMMO>;
	Mon, 21 Jan 2002 07:12:14 -0500
Date: Mon, 21 Jan 2002 10:12:03 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Hans Reiser <reiser@namesys.com>
Cc: Shawn Starr <spstarr@sh0n.net>, <linux-kernel@vger.kernel.org>
Subject: Re: Possible Idea with filesystem buffering.
In-Reply-To: <3C4BF71D.4010209@namesys.com>
Message-ID: <Pine.LNX.4.33L.0201211003000.32617-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jan 2002, Hans Reiser wrote:

> >It seems you're still assuming that different filesystems will
> >all see the same kind of load.
>
> I don't understand this comment.

[snip]

> The VM should apply pressure to the caches.  It should define an
> interface that subcache managers act in response to.  The larger a
> subcache is, the more percentage of total memory pressure it should
> receive.

Wrong.  If one filesystem is actively being used (eg. kernel
compile) and the other filesystem's cache isn't being used
(this one held the tarball of the kernel source) then the
cache which is being used actively should receive less
pressure than the cache which doesn't hold any active pages.

We really want to evict the kernel tarball from memory while
keeping the kernel source and object files resident.

This is exactly the reason why each filesystem cannot manage
its own cache ... it doesn't know anything about what the
system as a whole is doing.

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

