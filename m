Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277366AbRJEMGm>; Fri, 5 Oct 2001 08:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277365AbRJEMGb>; Fri, 5 Oct 2001 08:06:31 -0400
Received: from [195.223.140.107] ([195.223.140.107]:20718 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S277363AbRJEMGP>;
	Fri, 5 Oct 2001 08:06:15 -0400
Date: Fri, 5 Oct 2001 14:06:00 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Benjamin LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org
Subject: 2.4.11pre4 and oom
Message-ID: <20011005140600.G724@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

as far I can tell the oom patch you included in pre4 can deadlock the
machine during oom. Obviously, think if the oom-selected task is looping
trying to free memory, it won't care about the signal you sent to it.
This ignoring the fact it can be in D state and the fact oom() cannot
know know when we're oom or not by only looking at the incomplete stats
anyways.

Now it's obvious you don't care and that most people won't notice the
problem (and the problem is always been in -ac VM too most probably for
ages and again nobody is complaining) and that it is going to cure the
oom faliures and that we could just ignore any seldom oom deadlock
bugreport with Ben's argument that people shouldn't run oom in first
place, but despite of this I prefer not to take that route in -aa
because I strongly believe that people is allowed to run oom without
turning down the machine, infact I also dislike the PF_MEMALLOC logic
that doesn't mathematically "guarantee" that there's enough memory to
"release memory", there should be proper reservation done by each
filesystem that can be involved in the ram freeing (like we do with
highmem), but ok, that's invasive change so I'm living with PF_MEMALLOC
for now, let's assume there's really enough memory in the pf_memalloc
reserved pool.

Andrea
