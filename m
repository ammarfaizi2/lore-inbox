Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267921AbRGWUop>; Mon, 23 Jul 2001 16:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267923AbRGWUof>; Mon, 23 Jul 2001 16:44:35 -0400
Received: from [47.129.117.131] ([47.129.117.131]:40576 "HELO
	pcard0ks.ca.nortel.com") by vger.kernel.org with SMTP
	id <S267921AbRGWUo3>; Mon, 23 Jul 2001 16:44:29 -0400
Message-ID: <3B5C8C96.FE53F5BA@nortelnetworks.com>
Date: Mon, 23 Jul 2001 16:44:06 -0400
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Jeff Dike <jdike@karaya.com>,
        user-mode-linux-user <user-mode-linux-user@lists.sourceforge.net>,
        linux-kernel <linux-kernel@vger.kernel.org>, Jan Hubicka <jh@suse.cz>
Subject: Re: user-mode port 0.44-2.4.7
In-Reply-To: <Pine.LNX.4.33.0107231259520.13272-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Linus Torvalds wrote:
> 
> On Mon, 23 Jul 2001, Andrea Arcangeli wrote:
> >
> > gcc can assume 'state' stays constant in memory not just during the
> > 'case'.
> 
> The point is that if the kernel has _any_ algorithm where it cares, it's a
> kernel bug. With volatile or without.
> 
> SHOW ME THE CASE WHERE IT CARES. Let's fix it. Let's not just hide it with
> "volatile".

If I understand correctly, xtime is updated asynchronously.  If it isn't, then
ignore this message totally.  However, if it is, then *not* specifying it as
volatile could easily cause problems in technically correct but poorly written
code.

Suppose I loop against xtime reaching a particular value.  While this is
definately not good practice, if xtime is not specified as volatile then since I
never modify it within the loop the compiler is free to move the initial load
out of the loop when optimizing.  In this example the case where it is marked as
volatile will run (though inefficiently), but the non-volatile case can hang
totally.

Do we want to get ourselves into something like this?

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
