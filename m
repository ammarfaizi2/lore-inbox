Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263437AbRFNRs1>; Thu, 14 Jun 2001 13:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263485AbRFNRsS>; Thu, 14 Jun 2001 13:48:18 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:30002 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S263437AbRFNRsF>; Thu, 14 Jun 2001 13:48:05 -0400
Date: Thu, 14 Jun 2001 19:47:57 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Richard Henderson <rth@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Ingo Molnar <mingo@elte.hu>,
        linux-kernel@vger.kernel.org
Subject: Re: unregistered changes to the user<->kernel API
Message-ID: <20010614194757.B715@athlon.random>
In-Reply-To: <20010614191219.A30567@athlon.random> <20010614191634.B30567@athlon.random> <20010614192122.C30567@athlon.random> <20010614103249.A28852@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010614103249.A28852@redhat.com>; from rth@redhat.com on Thu, Jun 14, 2001 at 10:32:49AM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2001 at 10:32:49AM -0700, Richard Henderson wrote:
> within glibc, and (2) making these accesses slower since they
> will be considered O_DIRECT after the change.

and then read/write will return -EINVAL which is life-threatening.
O_DIRECT like rawio via /dev/raw imposes special buffer size and
alignment (size multiple of softblocksize of the fs and softblocksize
alignment, at max I can turn it down to hardblocksize without intensive
changes and guaranteeing zerocopy [modulo bounce buffers on x86 of
course]).

So in short at least glibc would need to be replaced...

Andrea
