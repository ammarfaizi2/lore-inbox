Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135538AbRAHSCz>; Mon, 8 Jan 2001 13:02:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136199AbRAHSCp>; Mon, 8 Jan 2001 13:02:45 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:13836 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S136080AbRAHSCj>; Mon, 8 Jan 2001 13:02:39 -0500
Date: Mon, 8 Jan 2001 10:02:12 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: linux-kernel@vger.kernel.org
Subject: Re: Subtle MM bug
In-Reply-To: <Pine.LNX.4.21.0101081518530.21675-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.10.10101080958440.3750-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 8 Jan 2001, Rik van Riel wrote:
> 
> You are right in that we need to refill the inactive list
> before calling page_launder(), but we'll also need a few
> other modifications:

NONE of your three additions do _anything_ to help us at all if we don't
even see the dirty bit because the page is on the active list and the
dirty bit is in somebodys VM space.

I agree that they look ok, but they are all complicating the code. I
propose getting rid of complications, and getting rid of the precarious
"when do we actually scan the VM tables" balancing issue.

Quite frankly, I'd rather see somebody try the vmscan stuff FIRST. Your
suggestions look fine, but apart from the "let dirty pages go twice
through the list" they look like tweaks that would need re-tweaking after
the balancing stuff is ripped out.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
