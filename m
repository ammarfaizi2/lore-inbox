Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265421AbSJRUEl>; Fri, 18 Oct 2002 16:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265427AbSJRUEl>; Fri, 18 Oct 2002 16:04:41 -0400
Received: from [195.39.17.254] ([195.39.17.254]:9220 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S265421AbSJRUEj>;
	Fri, 18 Oct 2002 16:04:39 -0400
Date: Fri, 18 Oct 2002 17:25:14 +0200
From: Pavel Machek <pavel@ucw.cz>
To: jw schultz <jw@pegasys.ws>, linux-kernel@vger.kernel.org
Subject: Re: Better fork() (and possbly others) failure diagnostics
Message-ID: <20021018152512.GC237@elf.ucw.cz>
References: <20021015115517.GA2514@atrey.karlin.mff.cuni.cz> <20021015061610.A986@pegasys.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021015061610.A986@pegasys.ws>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >   Several times I had real problems with batch jobs failing with EAGAIN,
> > printed as "Resource temporarily unavailable". Not with the failure, but to
> > determine the real cause is really a pain. Usually, the problem is in
> > resource limits (rlimit, set by ulimit), but the returned error code is
> > misleading.
> > 
> >   There are two ways. One is to print something to syslog, when some rlimit
> > is reached. This is already done when limit of open files in system is
> > reached.
> > 
> >   The second is more subtle - define error code for reaching the rlimit
> > (possibly one errorcode for each rlimit) and slightly change the code to
> > return correct error code.
> > 
> >   What do you think about this subject?
> 
> Bad idea at this time.  In 1980 it might have been ok.

I believe it is still good idea.

> Take a look at the manpages.  It is very clear there that
> EAGAIN has two meanings: try again because what you request
> isn't available yet, and request exceeds resource limits (at
> the moment).  Basically POSIX and SUS direct that EAGAIN is
> the correct error code for resource limit exceedance.
> 
> I agree it would be nice if rlimit caused its own error code
> but such a change at this time would break far to many things.

What would break?

> Your alternative of a klogging an error is not appropriate
> either.  Hitting an rlimit is not a system, but a user
> error.  There is nothing for the admin to do, the message

If it is user error, than it is okay if system returns something else
than EAGAIN. We could for example return EUSERERROR_LIMITREACHED. But
I do not really think it is user error.
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
