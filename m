Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277260AbRJIOcG>; Tue, 9 Oct 2001 10:32:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277262AbRJIOb5>; Tue, 9 Oct 2001 10:31:57 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:26922 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S277259AbRJIObq>; Tue, 9 Oct 2001 10:31:46 -0400
Date: Tue, 9 Oct 2001 16:31:26 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: pre6 VM issues
Message-ID: <20011009163126.D15943@athlon.random>
In-Reply-To: <Pine.LNX.4.21.0110091031470.5604-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0110091031470.5604-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Tue, Oct 09, 2001 at 10:44:37AM -0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2001 at 10:44:37AM -0200, Marcelo Tosatti wrote:
> 
> Hi, 
> 
> I've been testing pre6 (actually its pre5 a patch which Linus sent me
> named "prewith 16GB of RAM (thanks to OSDLabs for that), and I've found
> out some problems. First of all, we need to throttle normal allocators
> more often and/or update the low memory limits for normal allocators to a
> saner value. I already said I think allowing everybody to eat up to
> "freepages.min" is too low for a default.
> 
> I've got atomic memory failures with _22GB_ of swap free (32GB total):
> 
>  eth0: can't fill rx buffer (force 0)!
> 
> Another issue is the damn fork() special case. Its failing in practice:
> 
> bash: fork: Cannot allocate memory
> 
> Also with _LOTS_ of swap free. (gigs of them)
> 
> Linus, we can introduce a "__GFP_FAIL" flag to be used by _everyone_ which
> wants to do higher order allocations as an optimization (eg allocate big
> scatter-gather tables or whatever). Or do you prefer to make the fork()
> allocation a separate case ?
> 
> I'll take a closer look at the code now and make the throttling/limits to
> what I think is saner for a default.

I've also finished last night to fix all highmem troubles that I could
reproduce on 128mbyte with highmem emulation, I'm confidetn it will work
fine on real highmem too now, I hope to get access soon to some highmem
machine too to test it.

I guess you're not interested to test my patches since they're not in
the mainline direction though.

Andrea
