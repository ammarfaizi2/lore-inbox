Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316765AbSEUUw4>; Tue, 21 May 2002 16:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316766AbSEUUwz>; Tue, 21 May 2002 16:52:55 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:53777 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316765AbSEUUwz>; Tue, 21 May 2002 16:52:55 -0400
Date: Tue, 21 May 2002 13:52:37 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Dave McCracken <dmccr@us.ibm.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] POSIX personality
In-Reply-To: <64270000.1022012868@baldur.austin.ibm.com>
Message-ID: <Pine.LNX.4.33.0205211349100.3073-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 21 May 2002, Dave McCracken wrote:
>
> In a discussion today an alternate idea was proposed by Ben LaHaise.  He
> suggested creating a POSIX personality, or execution domain.  This would
> take some pressure off the clone flag space as well as allowing some
> optimizations in the code. It could also be used in situations where
> POSIX-compatible behavior entails more than just sharing extra resources
> between tasks.

I don't see any reason to start using some fixed-mode semantics without 
seeing some stronger arguments on exactly why that would be a good idea. 
We have used up 11 of 24 bits (and more can be made available) over the 
last five years, and there are no obvious inefficiencies that I can see.

Also, stateful computing is usually a _bad_ idea. System calls that behave
differently depending on some external state should be avoided. Yes, it's
largely unavoidable if the external state is "we now emulate some other OS
behaviour", but that's not an excuse to create new such state, imnsho.

		Linus

