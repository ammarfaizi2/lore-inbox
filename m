Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262317AbSKHUEF>; Fri, 8 Nov 2002 15:04:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262322AbSKHUEF>; Fri, 8 Nov 2002 15:04:05 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:55822 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262317AbSKHUEF>; Fri, 8 Nov 2002 15:04:05 -0500
Date: Fri, 8 Nov 2002 12:10:14 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Dipankar Sarma <dipankar@gamebox.net>
cc: Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>
Subject: Re: [TRIVIAL] Re: UP went into unexpected trashing
In-Reply-To: <20021109012336.A25293@dikhow>
Message-ID: <Pine.LNX.4.44.0211081206140.4471-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 9 Nov 2002, Dipankar Sarma wrote:
> 
> Or add a check in there. I can't figure out a way to avoid the extra 
> conditional branch anyway :)

I'd actually rather change the calling convention, and say that the only 
valid test is for testing the return value "being in range".

And it's not strictly even a calling convention _change_ - it's always
been that way. See the original user, ie the minix filesystem:

	if ((j = minix_find_first_zero_bit(bh->b_data, 8192)) < 8192) {
		...

and it's really a documentation fix/update to just tell people about this.

		Linus

