Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131067AbQLJRSg>; Sun, 10 Dec 2000 12:18:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131254AbQLJRS0>; Sun, 10 Dec 2000 12:18:26 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:34575 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131067AbQLJRSS>; Sun, 10 Dec 2000 12:18:18 -0500
Date: Sun, 10 Dec 2000 08:47:36 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: David Woodhouse <dwmw2@infradead.org>
cc: Andrew Morton <andrewm@uow.edu.au>, lkml <linux-kernel@vger.kernel.org>,
        linux-usb-devel@lists.sourceforge.net
Subject: Re: [patch] hotplug fixes
In-Reply-To: <Pine.LNX.4.30.0012101238120.25294-100000@imladris.demon.co.uk>
Message-ID: <Pine.LNX.4.10.10012100846170.2635-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 10 Dec 2000, David Woodhouse wrote:
> 
> That's sick. Do we have to? The PCMCIA coded obviously wants an async
> call_usermodehelper() or it wouldn't have been using schedule_task()
> for it in the first place, would it? Can't we pass an 'int async' arg to
> call_usermodehelper() instead of doing it this way?

All user-mode-helpers are async as of this patch.

The reason for the serialization is that we need to wait until the exec()
has taken place - so that the arguments that the caller set up haven't
disappeared from the caller stack. The actual execution is asynchronous
anyway.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
