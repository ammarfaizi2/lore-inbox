Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129601AbRATTkV>; Sat, 20 Jan 2001 14:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129664AbRATTkM>; Sat, 20 Jan 2001 14:40:12 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:12295 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129601AbRATTjy>; Sat, 20 Jan 2001 14:39:54 -0500
Date: Sat, 20 Jan 2001 11:39:30 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: kuznet@ms2.inr.ac.ru, mingo@elte.hu, raj@cup.hp.com,
        linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: [Fwd: [Fwd: Is sendfile all that sexy? (fwd)]]
In-Reply-To: <20010120203023.A5274@athlon.random>
Message-ID: <Pine.LNX.4.10.10101201138100.10317-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 20 Jan 2001, Andrea Arcangeli wrote:

> On Sat, Jan 20, 2001 at 10:05:45PM +0300, kuznet@ms2.inr.ac.ru wrote:
> > It makes. One small packet is allowed to fly, not depending on packets_out.
> 
> So this mean if I do:
> 
> 	write(100000*MSS)
> 	write(1)
> 	write(1)
> 
> 2.4 can send 100000 packet with MSS large payload plus two packets with a
> payload of 1 byte even if during the two write(1) the previous packets were
> still out (not acknowledged yet). Classical nagle would send 100000 packet with
> MSS large payload plus 1 packet with a two bytes payload in the same
> scenario.

As far as I can tell, the second "write(1)" will always merge with the
first one - unless the first one has already been sent out, of course (in
which classical nagle would have done the same thing).

So I think we'd do TheRightThing(tm) regardless. But maybe I misread.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
