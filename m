Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129807AbQLMASm>; Tue, 12 Dec 2000 19:18:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129828AbQLMASV>; Tue, 12 Dec 2000 19:18:21 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:8459 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129807AbQLMASP>; Tue, 12 Dec 2000 19:18:15 -0500
Date: Tue, 12 Dec 2000 15:47:09 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
cc: Jasper Spaans <jasper@spaans.ds9a.nl>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] raid5 crash with 2.4.0-test12 [Was: Linux-2.4.0-test12]
In-Reply-To: <14902.45844.964925.199379@notabene.cse.unsw.edu.au>
Message-ID: <Pine.LNX.4.10.10012121539000.2348-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 13 Dec 2000, Neil Brown wrote:
>
> Could you add this test to the top of md_make_request as well, because
> requests to raid5 don't go through generic_make_request.

Sure they do. Everything that calls ll_rw_block() or submit_bh() will go
through generic_make_request.

Neil, you're probably thinking about __make_request(), which only triggers
for "normal" devices.

The fact that the buffer doesn't go through generic_make_request() implies
that it is some buffer that is completely internal to the raid5
processing. I don't see anything like that, though.

Jasper, sorry about even asking this, but where did you add the check for
b_end_io? Maybe you put it in __make_request() by mistake?

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
