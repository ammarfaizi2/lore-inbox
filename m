Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131239AbRAISil>; Tue, 9 Jan 2001 13:38:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131230AbRAISic>; Tue, 9 Jan 2001 13:38:32 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:62223 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130902AbRAISiP>; Tue, 9 Jan 2001 13:38:15 -0500
Date: Tue, 9 Jan 2001 10:37:44 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Christoph Rohland <cr@sap.com>
cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Rik van Riel <riel@conectiva.com.br>,
        "Sergey E. Volkov" <sve@raiden.bancorp.ru>,
        linux-kernel@vger.kernel.org
Subject: Re: VM subsystem bug in 2.4.0 ?
In-Reply-To: <qwwlmskya2f.fsf@sap.com>
Message-ID: <Pine.LNX.4.10.10101091036360.2070-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 9 Jan 2001, Christoph Rohland wrote:

> Hi Stephen,
> 
> On Tue, 9 Jan 2001, Stephen C. Tweedie wrote:
> > D'oh, right --- so can't you lock a segment just by bumping
> > page_count on its pages?
> 
> Looks like a good idea. 
> 
> Oh, and my last posting was partly bogus: I can directly get the pages
> with page cache lookups on the file.

Even more appropriately, you have the inode->i_mapping lists that you can
use directly (no need to do lookups, just walk the list).

Note that bumping the counts is _NOT_ as easy as you seem to think. The
problem: vmtruncate() and friends. It's much easier to just have a flag
that gets cleared on truncate.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
