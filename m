Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273565AbRJQBPs>; Tue, 16 Oct 2001 21:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273619AbRJQBPi>; Tue, 16 Oct 2001 21:15:38 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:13152 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S273565AbRJQBPX>; Tue, 16 Oct 2001 21:15:23 -0400
Date: Wed, 17 Oct 2001 03:15:42 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Stephan von Krawczynski <skraw@ithnet.com>,
        Patrick McFarland <unknown@panax.com>, linux-kernel@vger.kernel.org
Subject: Re: VM
Message-ID: <20011017031542.X2380@athlon.random>
In-Reply-To: <20011017013856.R2380@athlon.random> <Pine.LNX.4.33L.0110162247210.6440-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.33L.0110162247210.6440-100000@imladris.surriel.com>; from riel@conectiva.com.br on Tue, Oct 16, 2001 at 10:49:28PM -0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2001 at 10:49:28PM -0200, Rik van Riel wrote:
> The VM just doesn't have the information it needs to
> determine what to do...

additional page aging cannot make it different as far I can tell.
The twekaing I'm speaking about is a number. After probing the cache and
after getting many faliures I need to choose when it's time to start
the pagetable scanning. Additional bit of aging can only influence the number of
faliures, I cannot see how can it help to know when to start the
pagetable scanning. It's a _ratio_ between the faliures and the size of
the scan that tells me when it's the time. You need the same logic too
somewhere in -ac vm. Now if I turn the ratio very high the cache will
shrink more before we start pagetable scanning.  If I make it low we'll
swapout very easily. This ratio doesn't need to be perfect, it will
never trigger anyways most of the time, but it must be a sane number,
and it can make some difference during swapout.

Andrea
