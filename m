Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132796AbRAQLR7>; Wed, 17 Jan 2001 06:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132968AbRAQLRu>; Wed, 17 Jan 2001 06:17:50 -0500
Received: from web5202.mail.yahoo.com ([216.115.106.170]:58125 "HELO
	web5202.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S132796AbRAQLR3>; Wed, 17 Jan 2001 06:17:29 -0500
Message-ID: <20010117111727.3773.qmail@web5202.mail.yahoo.com>
Date: Wed, 17 Jan 2001 03:17:27 -0800 (PST)
From: Rob Landley <telomerase@yahoo.com>
Subject: Re: qlogicfc.c hard lockups in 2.4.0
To: Chris Loveland <chris.loveland@trebia.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

More data:

I changed QLOGICFC_REQ_QUEUE_LEN from 127 to 255, and
the lockup hasn't happened again yet, in circumstances
that fairly reliably reproduced it before.  (Could
just mean I have to hit it harder.)

BUT: I am still getting those "no handle slots, this
should not happen" messages.  (Especially when I play
with nicing my dd down to -20, although that may be
cheating...)  These seem to match with noticeable
stalls in the drive array light blinkiness, where
about every 2 seconds there's a visible pause in the
whole array.  If I do a read that's short enough to
NOT cause one of these stalls, I get 178
megabytes/second throughput (which is about up towards
the theoretical limit of the two qlogic fiber channel
cards and the ten drives per card).

With the stalls, it gets dragged down into the 150
megabyte per second range.  That's right on the border
of causing dropped capturing from the hdtv card, and
stalls playing to it.  (I forget exactly what I need,
something like 157 megabytes/second...  Bigger is
better, of course...)

According to top, at least one CPU is pegged during
all this, by the way.  dd uses 99.9% of available cpu
time, with bdflush taking another 32% or so (on the
other cpu, one assumes. :)  Guess: lots of copying of
the zero page to fill up dd's buffers?  I'm trying to
do an i/o bound test, may have to write my own it
seems.  Oh well, no biggie...  (The real applicatino
for this is dma into and out of a mondo ring buffer,
not particularly cpu intensive at all, you'd think...)

Fun fun fun...  Sun's coming up in an hour, I should
probably get some sleep.

Rob

__________________________________________________
Do You Yahoo!?
Get email at your own domain with Yahoo! Mail. 
http://personal.mail.yahoo.com/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
