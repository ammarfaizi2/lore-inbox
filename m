Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131172AbQKNW2B>; Tue, 14 Nov 2000 17:28:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131509AbQKNW1w>; Tue, 14 Nov 2000 17:27:52 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:9936 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S131172AbQKNW1l>;
	Tue, 14 Nov 2000 17:27:41 -0500
Date: Tue, 14 Nov 2000 16:57:20 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
        William Stearns <wstearns@pobox.com>
Subject: Re: PATCH 2.4.0.11.4: loopback block device fixes
In-Reply-To: <200011142121.QAA01124@havoc.gtf.org>
Message-ID: <Pine.GSO.4.21.0011141646500.5482-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 14 Nov 2000, Jeff Garzik wrote:

> Since I am not a block device expert, I am interested to know if
> these fixes look ok, and if they fix the reported loopback deadlocks.
> 
> I added calls to deactive_page and flush_dcache_page, and made sure
> that any error returns were propagated back to the caller.

The former looks fine (but I'ld rather cc that to VM folks). The latter
is patently useless - for one thing, caller doesn't give a damn for
the exact error value, for another it couldn't pass it further even
if it wanted. We have no way to tell what went wrong when IO request
fails - every async error turns into -EIO.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
