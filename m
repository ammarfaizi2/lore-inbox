Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265377AbRGSRNr>; Thu, 19 Jul 2001 13:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265402AbRGSRNh>; Thu, 19 Jul 2001 13:13:37 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:58885 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265377AbRGSRNX>; Thu, 19 Jul 2001 13:13:23 -0400
Date: Thu, 19 Jul 2001 10:12:25 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: lkml <linux-kernel@vger.kernel.org>, Rik van Riel <riel@conectiva.com.br>
Subject: Re: Inclusion of zoned inactive/free shortage patch 
In-Reply-To: <Pine.LNX.4.21.0107190419280.9510-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0107191008160.8055-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


On Thu, 19 Jul 2001, Marcelo Tosatti wrote:
>
> Well, here is a patch on top of -ac5 (which already includes the first
> zoned based approach patch).

Looks ok.

I'd like to see what the patch looks on top of a virgin tree, as it should
now be noticeably smaller (no need to pas extra parameters etc).

> I changed inactive_plenty() to use "zone->size / 3" instead "zone->size /
> 2".
>
> Under _my_ tests using half of the perzone total pages as the inactive
> target was too high.

This is one of the reasons I'd like to see the virtgin patch - if the "/2"
is too high, then that should mean that the behaviour is basically
unchanged from before, right? Which would be a good sign that this kicks
in gently - and I agree that "/3" sounds saner (or even "/4" - but we
should double-check that the global inactive function is guaranteed to
never trigger with all zones close to the "/4" target if so).

I haven't checked what your changes to "total_free_shortage()" are in the
-ac tree, so I don't know what the effect of that would be.

		Linus

