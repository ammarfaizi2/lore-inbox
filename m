Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264714AbSJOPi1>; Tue, 15 Oct 2002 11:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264715AbSJOPi1>; Tue, 15 Oct 2002 11:38:27 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:30986 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S264714AbSJOPiY>; Tue, 15 Oct 2002 11:38:24 -0400
Date: Tue, 15 Oct 2002 17:46:21 +0200
From: Michal Kara <lemming@atrey.karlin.mff.cuni.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: Better fork() (and possbly others) failure diagnostics
Message-ID: <20021015154621.GA10243@atrey.karlin.mff.cuni.cz>
References: <20021015115517.GA2514@atrey.karlin.mff.cuni.cz> <20021015061610.A986@pegasys.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021015061610.A986@pegasys.ws>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Take a look at the manpages.  It is very clear there that
> EAGAIN has two meanings: try again because what you request
> isn't available yet, and request exceeds resource limits (at
> the moment).  Basically POSIX and SUS direct that EAGAIN is
> the correct error code for resource limit exceedance.

  The fork() manpage says:

EAGAIN fork cannot allocate sufficient memory to copy the
parent's page tables and allocate a task  structure
for the child.

  No word about limits. But that may classify as a manpage problem.

> I agree it would be nice if rlimit caused its own error code
> but such a change at this time would break far to many things.

  I can think only of some applications retrying when they get EAGAIN...

> Your alternative of a klogging an error is not appropriate
> either.  Hitting an rlimit is not a system, but a user
> error.

  On workstation or multi-user server yes. But not on, say, web server.
There hitting the limit is a problem and administrator should do something
about it. When your nightly processing job hits limit (and when you run it
by hand, it doesn't) , "Something wrong" is not to much helpful to solve the
problem.

> Optimally whatever hit the rlimit should have reported a
> more useful message.  That many applications don't have
> special processing for EAGAIN isn't surprising as it doesn't
> occur that often.  I suppose a change to the error message
> to read "Resource temporarily unavailable or user limits
> exceeded" might help newer users but that is a property of
> libc.

  But WHICH limit. This is what this is all about. If there was only one,
then it is OK. And you cannot even display the limit/usage for running
process to give you a hint.

							Michal Kara

-- 
PING 111.111.111.111 (111.111.111.111): 56 data bytes
...
---- Waiting for outstanding packets ----
No outstanding packets received, just two ordinary.

