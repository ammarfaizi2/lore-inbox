Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269933AbRHEHZS>; Sun, 5 Aug 2001 03:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269932AbRHEHZJ>; Sun, 5 Aug 2001 03:25:09 -0400
Received: from weta.f00f.org ([203.167.249.89]:26768 "EHLO weta.f00f.org")
	by vger.kernel.org with ESMTP id <S269933AbRHEHYz>;
	Sun, 5 Aug 2001 03:24:55 -0400
Date: Sun, 5 Aug 2001 19:25:46 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.8-pre3 fsync entire path (+reiserfs fsync semantic change patch)
Message-ID: <20010805192546.C20821@weta.f00f.org>
In-Reply-To: <01080315090600.01827@starship> <Pine.GSO.4.21.0108031400590.3272-100000@weyl.math.psu.edu> <9keqr6$egl$1@penguin.transmeta.com>, <9keqr6$egl$1@penguin.transmeta.com> <20010804100143.A17774@weta.f00f.org> <3B6B4B21.B68F4F87@zip.com.au>, <3B6B4B21.B68F4F87@zip.com.au> <20010804131904.E18108@weta.f00f.org> <3B6C642F.D0358401@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B6C642F.D0358401@zip.com.au>
User-Agent: Mutt/1.3.20i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 04, 2001 at 02:07:59PM -0700, Andrew Morton wrote:

    Sorry, Chris - I was being even more than usually stupid.  All you
    need do is overload the return value from file_operations.fsync().
    It currently returns zero on success or negative error.  You can
    just define a return value of "1" to mean that the fs has taken
    care of syncing the directory info and no further action is needed
    at the fs layer.

Seems quite reasonable.  I'm quite keen on ehat approach except it
seems for some filesystems, walking the path is expensive.  How about
a flag in the superblock on whether we do this or not?

That said, it's been pointed out it doesn't actually help in several
cases (link/unlink) for example, so maybe I should forget the whole
thing?




  --cw
