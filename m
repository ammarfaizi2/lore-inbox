Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270931AbRHSXcz>; Sun, 19 Aug 2001 19:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270932AbRHSXcp>; Sun, 19 Aug 2001 19:32:45 -0400
Received: from waste.org ([209.173.204.2]:33085 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S270931AbRHSXc3>;
	Sun, 19 Aug 2001 19:32:29 -0400
Date: Sun, 19 Aug 2001 18:32:36 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Theodore Tso <tytso@mit.edu>
cc: David Schwartz <davids@webmaster.com>,
        Andreas Dilger <adilger@turbolinux.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: /dev/random in 2.4.6
In-Reply-To: <20010819111357.A3504@thunk.org>
Message-ID: <Pine.LNX.4.30.0108191808350.740-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Aug 2001, Theodore Tso wrote:

> The bottom line is it really depends on how paranoid you want to be,
> and how much and how closely you want /dev/random to reliably replace
> a true hardware random number generator which relies on some physical
> process (by measuring quantum noise using a noise diode, or by
> measuring radioactive decay).  For most purposes, and against most
> adversaries, it's probably acceptable to depend on network interrupts,
> even if the entropy estimator may be overestimating things.

Can I propose an add_untrusted_randomness()? This would work identically
to add_timer_randomness but would pass batch_entropy_store() 0 as the
entropy estimate. The store would then be made to drop 0-entropy elements
on the floor if the queue was more than, say, half full. This would let us
take advantage of 'potential' entropy sources like network interrupts and
strengthen /dev/urandom without weakening /dev/random.

(Yes, I see dont_count_entropy, but it doesn't appear to be used, and
doesn't address flooding the queue with 0-entropy entries. I'd take it
out.)

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

