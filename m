Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267707AbRGRBoS>; Tue, 17 Jul 2001 21:44:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267708AbRGRBoI>; Tue, 17 Jul 2001 21:44:08 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:28939 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267707AbRGRBnz>; Tue, 17 Jul 2001 21:43:55 -0400
Date: Tue, 17 Jul 2001 18:43:08 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: <dpicard@rcn.com>
cc: <axboe@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: PATCH for Corrupted IO on all block devices
In-Reply-To: <3B54E85E.6E917925@psind.com>
Message-ID: <Pine.LNX.4.33.0107171840550.1175-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 17 Jul 2001, David J. Picard wrote:
>
> Basically, what is happening is the read requests are being pushed to
> the front of the IO queue - before the preceding write for the same
> sector.

This is a bug in the USER, not in the code.

The locking is NOT supposed to be done at the elevator level (or, indeed
at ANY _io_ level), but must be done by upper layers.

If upper layers do not do this locking, then THAT is the bug.

What filesystem do you see the bug with?

		Linus

