Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271232AbRHTOMp>; Mon, 20 Aug 2001 10:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271233AbRHTOM0>; Mon, 20 Aug 2001 10:12:26 -0400
Received: from waste.org ([209.173.204.2]:14896 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S271232AbRHTOMX>;
	Mon, 20 Aug 2001 10:12:23 -0400
Date: Mon, 20 Aug 2001 09:12:33 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
cc: Theodore Tso <tytso@mit.edu>, David Schwartz <davids@webmaster.com>,
        Andreas Dilger <adilger@turbolinux.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: /dev/random in 2.4.6
In-Reply-To: <2247427940.998318254@[10.132.112.53]>
Message-ID: <Pine.LNX.4.30.0108200903580.4612-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Aug 2001, Alex Bligh - linux-kernel wrote:

> > Can I propose an add_untrusted_randomness()? This would work identically
> > to add_timer_randomness but would pass batch_entropy_store() 0 as the
> > entropy estimate. The store would then be made to drop 0-entropy elements
> > on the floor if the queue was more than, say, half full. This would let us
> > take advantage of 'potential' entropy sources like network interrupts and
> > strengthen /dev/urandom without weakening /dev/random.
>
> Am I correct in assuming that in the absence of other entropy sources, it
> would use these (potentially inferior) sources, and /dev/random would
> then not block? In which case fine, it solves my problem.

No, /dev/random would always keep a conservative estimate of entropy.
Assuming that network entropy > 0, this would add more real (but
unaccounted) entropy to the pool, and if you agree with this assumption,
you would be able to take advantage of it by reading /dev/urandom.

The only case where it would make things worse is if you're getting so
many entropy events batched that the queue fills up and high entropy
events get discarded in favor of earlier low entropy ones.

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

