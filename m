Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129325AbRADQoI>; Thu, 4 Jan 2001 11:44:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129450AbRADQn7>; Thu, 4 Jan 2001 11:43:59 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:49673 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129325AbRADQnn>; Thu, 4 Jan 2001 11:43:43 -0500
Date: Thu, 4 Jan 2001 08:43:23 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: try_to_swap_out() return value problem?
In-Reply-To: <Pine.LNX.4.21.0101041429130.1188-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.10.10101040835360.15597-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 4 Jan 2001, Rik van Riel wrote:
> 
> Then again, in theory the current VM should already be
> unbalanced and we haven't felt any bad effects yet ;)

The current VM is in fact very nice - I spent quite a long time running
with 32MB and for the first time in ages I didn't mind all that much. It
was painful when doing a recursive kernel diff (which takes me 2 seconds
with both threes cached, which they tend to be with a gig of RAM), but X
was fine.

The way to really hurt the current VM is to have a process dirty working
set that is large and changes rapidly. Then we'll do badly, apparently
because we'll end up having a large portion of the freeable pages in the
page tables, but we still seem to try to do most of the work in the lists.

I'd like somebody to try out a more aggressive "drop this from the page
tables, but don't actively swap it out until needed" approach eventually.
For now, 2.4.0 seems to be quite nice on "normal" loads, though. 

(Or maybe my loads weren't normal, who knows)

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
