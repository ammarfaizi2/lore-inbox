Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281165AbRLIBaf>; Sat, 8 Dec 2001 20:30:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281160AbRLIBaZ>; Sat, 8 Dec 2001 20:30:25 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:56075 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S281157AbRLIBaP>; Sat, 8 Dec 2001 20:30:15 -0500
Subject: Re: Linux HMT analysis
To: anton@samba.org (Anton Blanchard)
Date: Sun, 9 Dec 2001 01:39:11 +0000 (GMT)
Cc: rusty@rustcorp.com.au (Rusty Russell), alan@lxorguk.ukuu.org.uk (Alan Cox),
        davej@suse.de, marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
In-Reply-To: <20011209001729.GA3934@krispykreme> from "Anton Blanchard" at Dec 09, 2001 11:17:29 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Csvv-0003Tp-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Since HMT is not an intel only problem it would be nice to solve this in
> a slightly more generic way than #if defined(__i386__) && defined(CONFIG_SMP).
> Otherwise there will shortly be yet another hack in the scheduler
> surrounded by #ifdef CONFIG_PPC64_HMT :)

Right but instead of saying "it doesnt work" it might be worth saying "it
doesnt work for me on ppc64". The latter I can well believe

> Its pretty obvious what they are trying to achieve (its always
> preferrable to schedule 2 tasks on separate physical cpus rather than
> sharing the same one), but their change does not seem to have the
> required outcome.

It's trying to ensure we make use of idle cpu units. Right now it doesn't
also consider the matching mm check to be per chip not per scheduling unit.
I've suggested that to Intel but not yet had any definitive answer stating
that it is an improvement.

[Actually it isnt always preferable there is a reverse argument in two
 cases

	1.	Where both threads share the same mm
	2.	When you are trying to save power over performance

]

> Do we have any results showing the improvement this change made or did
> we just accept the changes?

Its based on real world runs with things like Oracle with a constraint that
the change must be clear and provably correct to get into a stable kernel
tree. For 2.5 we know the scheduler has to be rewritten somewhat and getting
it generically right is very important.

Alan
