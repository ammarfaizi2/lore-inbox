Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbRADE5X>; Wed, 3 Jan 2001 23:57:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129436AbRADE5E>; Wed, 3 Jan 2001 23:57:04 -0500
Received: from waste.org ([209.173.204.2]:4366 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S129324AbRADE4v>;
	Wed, 3 Jan 2001 23:56:51 -0500
Date: Wed, 3 Jan 2001 22:56:48 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: <richbaum@acm.org>
cc: <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Remove more compile warnings in 2.4.0-prerelease
In-Reply-To: <3A523DDE.23101.AC9EBA@localhost>
Message-ID: <Pine.LNX.4.30.0101032249440.1971-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jan 2001, Rich Baum wrote:

> Here is a patch that removes more compile warnings from 2.4.0-
> prerelease. I left out files that have been fixed by Alan or myself in
> the ac kernels. I'll add more options to my config tomorrow to try to
> find more of these warnings.

> -#endif I2C_PCF8584_H
> +#endif /* I2C_PCF8584_H */
[etc.]

Here, try this:

find -name "*.[ch]" | xargs perl -ne 'print "$ARGV:$_" if /#endif\s+\w/i'

You'll find a few hundred of them. Then try this (untested):

find -name "*.[ch]" |
 xargs perl -i -pe 's/#endif\s+(\w.*)/#endif \/\* $1 \/\*/i'

..and save yourself quite a bit of tedium.

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
