Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277232AbRJIOGg>; Tue, 9 Oct 2001 10:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277234AbRJIOG0>; Tue, 9 Oct 2001 10:06:26 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:20239 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S277232AbRJIOGN>; Tue, 9 Oct 2001 10:06:13 -0400
Date: Tue, 9 Oct 2001 10:44:37 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrea Arcangeli <andrea@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: pre6 VM issues
Message-ID: <Pine.LNX.4.21.0110091031470.5604-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, 

I've been testing pre6 (actually its pre5 a patch which Linus sent me
named "prewith 16GB of RAM (thanks to OSDLabs for that), and I've found
out some problems. First of all, we need to throttle normal allocators
more often and/or update the low memory limits for normal allocators to a
saner value. I already said I think allowing everybody to eat up to
"freepages.min" is too low for a default.

I've got atomic memory failures with _22GB_ of swap free (32GB total):

 eth0: can't fill rx buffer (force 0)!

Another issue is the damn fork() special case. Its failing in practice:

bash: fork: Cannot allocate memory

Also with _LOTS_ of swap free. (gigs of them)

Linus, we can introduce a "__GFP_FAIL" flag to be used by _everyone_ which
wants to do higher order allocations as an optimization (eg allocate big
scatter-gather tables or whatever). Or do you prefer to make the fork()
allocation a separate case ?

I'll take a closer look at the code now and make the throttling/limits to
what I think is saner for a default.


