Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131480AbRDSRLz>; Thu, 19 Apr 2001 13:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131498AbRDSRLq>; Thu, 19 Apr 2001 13:11:46 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:25614 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131480AbRDSRLc>; Thu, 19 Apr 2001 13:11:32 -0400
Subject: Re: light weight user level semaphores
To: torvalds@transmeta.com (Linus Torvalds)
Date: Thu, 19 Apr 2001 18:12:42 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), alonz@nolaviz.org (Alon Ziv),
        linux-kernel@vger.kernel.org (Kernel Mailing List),
        mkravetz@sequent.com (Mike Kravetz),
        drepper@cygnus.com (Ulrich Drepper)
In-Reply-To: <Pine.LNX.4.31.0104190944090.4074-100000@penguin.transmeta.com> from "Linus Torvalds" at Apr 19, 2001 09:46:17 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14qHz3-0007cZ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > libc is entitled to, and most definitely does exactly that. Take a look at
> > things like gethostent, getpwent etc etc.
> 
> Ehh.. I will bet you $10 USD that if libc allocates the next file
> descriptor on the first "malloc()" in user space (in order to use the
> semaphores for mm protection), programs _will_ break.
> 
> You want to take the bet?

Its not normally a good idea to take a Linus bet, but this time Im obviously
missing something. fd0-2 will be passed in (and if not then shit already
happens - see old bugtraq on the matter for setuid apps, glibc bugs)

So the C library gets fd 3
My first fopen gets fd 4.

That can already happen and isnt new. Several profiling libraries on Unix have
precisely this effect already. They dynamic link/loader will also open file
handles to do mmaps although generally you wont see those as they are closed
again after mapping. 

Internationalisation code in glibc will also open and map tables during startup


