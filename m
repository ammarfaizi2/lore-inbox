Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129066AbQKCFwq>; Fri, 3 Nov 2000 00:52:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129112AbQKCFwg>; Fri, 3 Nov 2000 00:52:36 -0500
Received: from twinlark.arctic.org ([204.107.140.52]:28689 "HELO
	twinlark.arctic.org") by vger.kernel.org with SMTP
	id <S129066AbQKCFwY>; Fri, 3 Nov 2000 00:52:24 -0500
Date: Thu, 2 Nov 2000 21:52:22 -0800 (PST)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Paul Marquis <pmarquis@iname.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: select() bug
In-Reply-To: <E13rUD4-00026g-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0011022141330.30081-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Semantic issues aside, since Apache does the test I mentionned earlier
> > to determine child status and since it could be misled, should this
> > feature be turned off?
> 
> Or made smarter yes

i'm scratching my head wondering what i was thinking when i wrote that
code.  the specific thing the parent wants to handle there is the case of
a stuck logger... you'd think i would have at least put some debouncing
logic in there.

(the parent is able to replace a logger without disturbing the children
because it keeps a copy of both halves of the logging pipes.)

an alternative would be to look for many children stuck in the logging
state (they make a note in the scoreboard before going into it).

paul -- if you want to just eliminate that feature (it'll still be able to
replace the logger if the logger exits) go into src/http_log.c,
piped_log_maintenance and comment out the OC_REASON_UNWRITEABLE.

-dean

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
