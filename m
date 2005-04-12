Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261806AbVDLA07@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261806AbVDLA07 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 20:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbVDLA07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 20:26:59 -0400
Received: from smtp.Lynuxworks.com ([207.21.185.24]:33798 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S261806AbVDLA0z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 20:26:55 -0400
Date: Mon, 11 Apr 2005 17:27:41 -0700
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: "Bill Huey (hui)" <bhuey@lnxw.com>, Ingo Molnar <mingo@elte.hu>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org,
       Steven Rostedt <rostedt@goodmis.org>, Esben Nielsen <simlo@phys.au.dk>,
       Joe Korty <joe.korty@ccur.com>
Subject: Re: [PATCH] Priority Lists for the RT mutex
Message-ID: <20050412002741.GA12094@nietzsche.lynx.com>
References: <F989B1573A3A644BAB3920FBECA4D25A02FA3BFF@orsmsx407>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F989B1573A3A644BAB3920FBECA4D25A02FA3BFF@orsmsx407>
User-Agent: Mutt/1.5.8i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2005 at 04:28:25PM -0700, Perez-Gonzalez, Inaky wrote:
> >From: Bill Huey (hui) [mailto:bhuey@lnxw.com]
...
> API than once upon a time was made multithreaded by just adding
> a bunch of pthread_mutex_[un]lock() at the API entry point...
> without realizing that some of the top level API calls also 
> called other top level API calls, so they'd deadlock.

Oh crap.

> Quick fix: the usual. Enable deadlock detection and if it
> returns deadlock, assume it is locked already and proceed (or
> do a recursive mutex, or a trylock).

You have to be joking me ? geez.
... 
> It is certainly something to explore, but I'd better drive your
> way than do it. It's cleaner. Hides implementation details.
>
> I agree, but it doesn't work that well when talking about legacy 
> systems...that's the problem.

Yeah, ok, I understand what's going on now. There isn't a notion
of projecting priority across into the Unix/Linux kernel traditionally
which is why it seemed so bizarre.

> Sure--and because most was for legacy reasons that adhered to 
> POSIX strictly, it was very simple: we need POSIX this, that and
> that (PI, proper adherence to scheduler policy wake up/rt-behaviour,
> deadlock detection, etc). 

Some of this stuff sounds like recursive locking. Would this be a
better expression to solve the "top level API locking" problem
you're referring to ?

> Fortunately in those areas POSIX is not too gray; code to the book.
> Deal. 

I would think that there will have to be a graph discontinuity
between user/kernel spaces at kernel entry and exit for the deadlock
detector. Can't say about issues at fork time, but I would expect
that those objects would have to be destroyed when the process exits.

The current RT (Ingo's) lock isn't recursive nor is the deadlock
detector the last time I looked. Do think that this is a problem
for legacy apps if it gets overload for being the userspace futex
as well ? (assuming I'm understanding all of this correctly)

> Of course, selling it to the lkml is another story.

I would think that pushing as much of this into userspace would
make the kernel hooks for it more acceptable. Don't know.

/me thinks more

bill

