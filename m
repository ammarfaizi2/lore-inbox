Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266353AbRGYBV2>; Tue, 24 Jul 2001 21:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266381AbRGYBVS>; Tue, 24 Jul 2001 21:21:18 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:34316 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S266339AbRGYBVA>; Tue, 24 Jul 2001 21:21:00 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Patrick Dreker <patrick@dreker.de>,
        Linus Torvalds <torvalds@transmeta.com>, phillips@bonn-fries.net,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] Optimization for use-once pages
Date: Wed, 25 Jul 2001 02:18:02 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <200107241648.f6OGmqp29445@penguin.transmeta.com> <E15P8jB-0000Au-00@wintermute>
In-Reply-To: <E15P8jB-0000Au-00@wintermute>
MIME-Version: 1.0
Message-Id: <0107250218020A.00520@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tuesday 24 July 2001 22:24, Patrick Dreker wrote:
> I just decided to give this patch a try, as I have written a little
> application which does some statistics over traces dumped by another
> program by mmap()ing a large file and reading it sequentially. The
> trace file to be analyzed is about 240 megs in size and consists of
> records each 249 bytes long. The analysis program opens and the
> mmap()s the trace file doing some small calculations on the data
> (basically it adds up fields from the records to get overall values).
>
> I have tested this on my Athlon 600 with 128 Megs of RAM, and it does
> not make any difference whether I use plain 2.4.7 or 2.4.5-use-once.
> The program always takes about 1 minute 6 seconds (+- 2 seconds) to
> complete, and the machine starts swapping out stuff

In this case that's an excellent result:

  - The optimization doesn't include mmap's (yet)
  - It doesn't break swap.  (Good, I didn't check that myself)

This is a case of "no news is good news".

> (thus I have
> omitted further stats like vmstat output). I have just taken another
> look into my program to verify it does not do something silly, like
> keeping old data around, but the program cycle is always the same:
> copy a record from the mmap into a struct, perform analysis, and copy
> next record. The struct is always reused for the next struct (so
> there is only one struct at any time).
>
> I can do further tests, if someone asks me to. I could even modify
> the analysis program to check changes in behaviour...

(Already read your mail where you picked up the 20% improvement, 
thanks, it warms my heart:-)

--
Daniel

