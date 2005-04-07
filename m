Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262455AbVDGNNQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262455AbVDGNNQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 09:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262457AbVDGNNQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 09:13:16 -0400
Received: from zone4.gcu-squad.org ([213.91.10.50]:56266 "EHLO
	zone4.gcu-squad.org") by vger.kernel.org with ESMTP id S262455AbVDGNM0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 09:12:26 -0400
Date: Thu, 7 Apr 2005 15:07:40 +0200 (CEST)
To: ladis@linux-mips.org
Subject: Re: [PATCH] i2c: new driver for ds1337 RTC
X-IlohaMail-Blah: khali@localhost
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.14 (On: webmail.gcu.info)
Message-ID: <hOrXV5wl.1112879260.3338120.khali@localhost>
In-Reply-To: <20050407111631.GA21190@orphique>
From: "Jean Delvare" <khali@linux-fr.org>
Bounce-To: "Jean Delvare" <khali@linux-fr.org>
CC: "Greg KH" <greg@kroah.com>, "LKML" <linux-kernel@vger.kernel.org>,
       "LM Sensors" <sensors@Stimpy.netroedge.com>,
       "James Chapman" <jchapman@katalix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Ladislav,

> > Please slice this into separarte patches. Adding support for the DS1339
> > is one thing, bug fixes are another. I can't review patches which do
> > that many different things at once.
>
> I have objection ;-) Nothing in kernel seems to use that driver (...)

How would you know? It has a user-space interface
(ds1337_driver.command), which anyone might be using.

> (...) and driver wasn't reviewed well enough before including.

I did review this driver. Thanks for the compliment, I really appreciate.

The driver went through several review and update steps between James
Chapman and I, part of which can be seen here (there were a couple of
additional private mails IIRC):
  http://archives.andrew.net.au/lm-sensors/msg29709.html
It got as good a review as one would ask for, or so I believe.

> Therefore I'm still considering it as a new driver which can be easily
> reviewed as whole.

Reviewing small, individual patches is always easier than reviewing one
big patch doing several things at once, it has nothing to do with the
age of the code. And at any rate you shouldn't consider anything is
easy when you are not the one doing it.

> > As a side note, please avoid noise in your patch. Converting constants
> > from decimal to hexadecimal or renaming variables makes my review job
> > way harder, as it distracts me from the real point of your patch.
>
> Hexadecimal constant are there to match datasheet, (...)

And anyone may argue that decimal values are easier to read, or whatever,
and send a revert patch next week? James did it that way, values are
correct. I see no point in changing them.

> (...) local variables should be short and with new_client is was
> reaching 80 column limit, that's coding style and that's why I made
> that change.

You changed other variable names with no reason (unless you are going to
argue that "tm" is shorter than "dt", of course).

I *do* agree that "new_client" is a poor variable name in this context,
and "client" carries the very same amount of information. That's not
specific to this driver though, almost all i2c chip driver use that name.

> Please consider that I would suggest these changes to driver author
> before his patch went in tree in case I would read all that mailing
> lists around. I'm lazy, my bad...

Sure you would have been welcome to review James Chapman's original
patch. But you didn't, so the fact that you would have objected if you
did is irrelevant. The code is in the kernel tree now.

You are very welcome to review future patches, though.

> Driver's author should have probably last word anyway.

Not necessarily. I had similarly hairsplitting objections to James'
driver when he first posted his patch, and we reached a state of
agreement on everything quite easily. He is a very pleasant person to
work with.

> Here is patch which does cleanup/fixes only. It is still hard to review,
> but that's living. I won't split it to smaller parts just because I had
> to touch each single line in get/set date functions. Sorry if it sounds
> impolite, but now I can't spend more time on it. Perhaps later, if
> anyone don't buy it as is meanwhile...

I'm not sure if it qualifies as impolite, but I can tell you won't get
anywhere with such an attitude. Trust me, I've been there before, and
changed.

Cleanups and fixes belong to separate patches. Your current patch, even
without the DS1339 support, is a mess, mixing useful cleanups, useless
cleanups and actual fixes - unfortunately undocumented so we can't even
say what exactly you are trying to fix.

> Please let me know when/if you will accept support for DS1339.

After this patch has been split, reviewed and modified enough to be
accepted. Your time might be limited, this won't change a thing, sorry.
Patches are accepted when we think they are good, and not before. You
can't tell that the original ds1337 driver wasn't properly reviewed
and at the same time ask me to accept this random patch of yours while I
an not able to review it in its current state.

Thanks,
--
Jean Delvare
