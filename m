Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277738AbRJIOu0>; Tue, 9 Oct 2001 10:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277740AbRJIOuQ>; Tue, 9 Oct 2001 10:50:16 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:35632 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S277737AbRJIOuK>; Tue, 9 Oct 2001 10:50:10 -0400
Date: Tue, 9 Oct 2001 16:50:02 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: pre6 VM issues
Message-ID: <20011009165002.H15943@athlon.random>
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

It could be just fragmentation but the fact it doesn't happen in
non-highmem pretty much shows that shows the memory balancing isn't
doing the right thing, you hide the problem with the infinite loop for
non atomic order 0 allocations and that's just broken, as best it will
be slower in collecting the right pages away.

My approch shouldn't fail so easily in fork despite I'm not looping in
fork either, because I'm trying to do better decisions since the first
place in the memory balancing, I don't wait the infinite loop to
eventually collect away the right pages.

Andrea
