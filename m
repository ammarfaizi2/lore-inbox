Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268450AbRGXU2U>; Tue, 24 Jul 2001 16:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268449AbRGXU2K>; Tue, 24 Jul 2001 16:28:10 -0400
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:18525 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S268447AbRGXU1y>; Tue, 24 Jul 2001 16:27:54 -0400
Content-Type: text/plain; charset=US-ASCII
From: Patrick Dreker <patrick@dreker.de>
Organization: Chaos Inc.
To: Linus Torvalds <torvalds@transmeta.com>, phillips@bonn-fries.net,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] Optimization for use-once pages
Date: Tue, 24 Jul 2001 22:24:17 +0200
X-Mailer: KMail [version 1.2.9]
In-Reply-To: <200107241648.f6OGmqp29445@penguin.transmeta.com>
In-Reply-To: <200107241648.f6OGmqp29445@penguin.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E15P8jB-0000Au-00@wintermute>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hello...

Am Dienstag, 24. Juli 2001 18:48 schrieb Linus Torvalds:
> Please people, test this out extensively - I'd love to integrate it, but
> while it looks very sane I'd really like to hear of different peoples
> reactions to it under different loads.
I just decided to give this patch a try, as I have written a little 
application which does some statistics over traces dumped by another program 
by mmap()ing a large file and reading it sequentially. The trace file to be 
analyzed is about 240 megs in size and consists of records each 249 bytes 
long. The analysis program opens and the mmap()s the trace file doing some 
small calculations on the data (basically it adds up fields from the records 
to get overall values).

I have tested this on my Athlon 600 with 128 Megs of RAM, and it does not 
make any difference whether I use plain 2.4.7 or 2.4.5-use-once. The program 
always takes about 1 minute 6 seconds (+- 2 seconds) to complete, and the 
machine starts swapping out stuff (thus I have omitted further stats like 
vmstat output). I have just taken another look into my program to verify it 
does not do something silly, like keeping old data around, but the program 
cycle is always the same: copy a record from the mmap into a struct, perform 
analysis, and copy next record. The struct is always reused for the next 
struct (so there is only one struct at any time).

I can do further tests, if someone asks me to. I could even modify the 
analysis program to check changes in behaviour...

> 		Linus

Patrick
-- 
