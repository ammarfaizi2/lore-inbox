Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317634AbSFRVuP>; Tue, 18 Jun 2002 17:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317635AbSFRVuO>; Tue, 18 Jun 2002 17:50:14 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:13581 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317634AbSFRVuN>; Tue, 18 Jun 2002 17:50:13 -0400
Date: Tue, 18 Jun 2002 14:47:24 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Cort Dougan <cort@fsmlabs.com>
cc: Benjamin LaHaise <bcrl@redhat.com>, Rusty Russell <rusty@rustcorp.com.au>,
       Robert Love <rml@tech9.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: latest linus-2.5 BK broken
In-Reply-To: <20020618150840.Q13770@host110.fsmlabs.com>
Message-ID: <Pine.LNX.4.33.0206181442050.2562-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jun 2002, Cort Dougan wrote:
>
> I agree with you there.  It's not easy, and I'd claim it's not possible
> given that no-one has done it yet, to have a select() call that is speedy
> for both 0-10 and 1k file descriptors.

Actually, select() scales a lot better than poll() for _dense_ bitmaps.

The problem with non-scalability ends up being either sparse bitmaps
(minor problem, poll() can help) or just the work involved in watching a
large number of fd's (major problem, but totally unrelated to the bitmap
itself, and poll() usually makes it worse thanks to more data to be
moved).

Anyway, I was talking about the scalability of the _data_structure_, not 
the scalability performance-wise. Performance scalability is a non-issue 
for something like setaffinity(), since it's just not called at any rate 
approaching poll.

>From a data structure standpoint, bitmaps are clearly the simplest dense 
representation, and scale perfectly well to any reasonable number of 
CPU's.

If we end up using a default of 1024, maybe you'll have to recompile that
part of the system that has anything to do with CPU affinity in about
10-20 years by just upping the number a bit. Quite frankly, that's going
to be the _least_ of the issues.

		Linus

