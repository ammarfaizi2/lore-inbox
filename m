Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269739AbRHDBSi>; Fri, 3 Aug 2001 21:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269740AbRHDBS1>; Fri, 3 Aug 2001 21:18:27 -0400
Received: from weta.f00f.org ([203.167.249.89]:13968 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S269739AbRHDBSQ>;
	Fri, 3 Aug 2001 21:18:16 -0400
Date: Sat, 4 Aug 2001 13:19:04 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Andrew Morton <akpm@zip.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Chris Mason <mason@suse.com>
Subject: Re: [PATCH] 2.4.8-pre3 fsync entire path (+reiserfs fsync semantic change patch)
Message-ID: <20010804131904.E18108@weta.f00f.org>
In-Reply-To: <01080315090600.01827@starship> <Pine.GSO.4.21.0108031400590.3272-100000@weyl.math.psu.edu> <9keqr6$egl$1@penguin.transmeta.com>, <9keqr6$egl$1@penguin.transmeta.com> <20010804100143.A17774@weta.f00f.org> <3B6B4B21.B68F4F87@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B6B4B21.B68F4F87@zip.com.au>
User-Agent: Mutt/1.3.20i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2001 at 06:08:49PM -0700, Andrew Morton wrote:

    Ow.  You just crippled ext3.

How so? The Flush all transactions on fsync behaviour that resierfs
did/does have at present too?  (There are 'fixes' to reiserfs for
this).

    I don't think an ext2 problem (which I don't think is a problem at
    all) should be "fixed" at the VFS layer when other filesystems are
    perfectly happy without it, no?

If you want to be sure that when you fsync a file, that, silly bugger
rename games further up the path aside, the entire path is also on
disk, the VFS is the only place to do it with the current fs API.

really, there is _some_ merit in the argument that

        open
        fsync
        close
<crash>

shouldn't loose the file...

    This whole thread, talking about "linux this" and "linux that" is
    off-base.  It's ext2 we're talking about.  This MTA requirement is
    a highly unusual and specialised thing - I don't see why the
    general-purpose ext2 should bear the burden of supporting it when
    other filesystems such as reiserfs (I think?) and ext3 support it
    naturally and better than ext2 ever will.

Well, since it will only sync dirty blocks, it will hardly hurt ext2
that much at all --- and it will only force the dirty blocks in path
components to be written when you fsync the file, thats probably only
a single block anyhow.

FWIW, I don't think it's unreasonable we do this, nor does it fix all
the potential MTA problems :)



Anyhow, that patch was bogus.  As soon as I get some more clues, I'll
send another one (trying to get more clueful now, not having much
success!).




  --cw
