Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277143AbRJ3RjX>; Tue, 30 Oct 2001 12:39:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277119AbRJ3RjN>; Tue, 30 Oct 2001 12:39:13 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:56854 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S277039AbRJ3Ri7>; Tue, 30 Oct 2001 12:38:59 -0500
Date: Tue, 30 Oct 2001 18:39:12 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Hugh Dickins <hugh@veritas.com>,
        Frank Dekervel <Frank.dekervel@student.kuleuven.ac.Be>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: need help interpreting 'free' output.
Message-ID: <20011030183912.P1340@athlon.random>
In-Reply-To: <20011030180616.M1340@athlon.random> <Pine.LNX.4.33.0110300917520.8603-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.33.0110300917520.8603-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Oct 30, 2001 at 09:28:29AM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2001 at 09:28:29AM -0800, Linus Torvalds wrote:
> Does anybody see why we have to remove it from the swap cache at all?

the only reason is to avoid wasting the swap space, so at least Rik's
vm_swap_full logic should be added to it. The only advantage of dirty
swap cache persistence is that it will maintain the same position on
disk across a swapin/swapout cycle.

But anyways you can do that "swap persistence" work in do_swap_page too
to save a page fault for the write swapins. Ok, it's in one more place
but it will be less costly than running into another pagefault just
after returning to userspace.

Andrea
