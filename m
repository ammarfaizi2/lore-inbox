Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263072AbREWMgp>; Wed, 23 May 2001 08:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263073AbREWMgf>; Wed, 23 May 2001 08:36:35 -0400
Received: from [195.63.194.11] ([195.63.194.11]:3593 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S263072AbREWMgV>;
	Wed, 23 May 2001 08:36:21 -0400
Message-ID: <3B0BAE83.24DCBFC4@evision-ventures.com>
Date: Wed, 23 May 2001 14:35:15 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Jeff Garzik <jgarzik@mandrakesoft.com>, Andries.Brouwer@cwi.nl,
        linux-kernel@vger.kernel.org, viro@math.psu.edu, axboe@suse.de
Subject: Re: [PATCH] struct char_device
In-Reply-To: <Pine.LNX.4.21.0105221938080.4713-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Tue, 22 May 2001, Jeff Garzik wrote:
> >
> > IMHO it would be nice to (for 2.4) create wrappers for accessing the
> > block arrays, so that we can more easily dispose of the arrays when 2.5
> > rolls around...
> 
> No.
> 
> We do not create wrappers "so that we can easily change the implementation
> when xxx happens".
> 
> That way lies bad implementations.

However Linus please note that in the case of the bould arrays
used in device handling code we have code patterns like this:

	if (blah[major]) {
		size = blah[major][minor]
	} else
		size = some default;

And those have to by dragged throughout the whole places where
the arrays get used. Thus making some wrappers (many are already in
place):

1. Prevents typo kind of programming errors.

2. Possibly make the code more explicit.

and please don't forget:

3. Allows to change the underlying implementation in some soon point in
time.

However I agree that *without* the above arguments such kind of wrappers
would make the overall code as unreadable as C++ code frequently is,
which
tryies to preserve private: attributes at simple field cases..
