Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317444AbSGTQl7>; Sat, 20 Jul 2002 12:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317446AbSGTQl7>; Sat, 20 Jul 2002 12:41:59 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:47881 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317444AbSGTQl6>; Sat, 20 Jul 2002 12:41:58 -0400
Date: Sat, 20 Jul 2002 09:45:40 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Florian Weimer <Weimer@CERT.Uni-Stuttgart.DE>
cc: "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: close return value
In-Reply-To: <8765zazv5r.fsf@CERT.Uni-Stuttgart.DE>
Message-ID: <Pine.LNX.4.44.0207200936160.2342-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 20 Jul 2002, Florian Weimer wrote:
>
> Returning an error and still doing the operation is slightly awkward.
> Are there any other syscalls which do similar things?

mmap(MAP_FIXED) may have already unmapped any underlying old area if an
error occurs.

And EFAULT may have strange behaviour for left-over stuff. If I remember
correctly, at some point, for example, EFAULT on a write to a TCP socket
(if the fault happened in the middle) would still send out the full-sized
packet zero-padded, because not doing so would have screwed up the state
machine.

(But EFAULT is a special case in general, it's documented to be undefined
behaviour).

I can't think of any others, but at least close() isn't _completely_
alone.

And as you say, we really cannot change it anyway, even if we wanted to
(which I'm personally convinced we do not).

		Linus

