Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318044AbSIJTYk>; Tue, 10 Sep 2002 15:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318045AbSIJTYk>; Tue, 10 Sep 2002 15:24:40 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:49162 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S318044AbSIJTYi>; Tue, 10 Sep 2002 15:24:38 -0400
Date: Tue, 10 Sep 2002 12:29:13 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pid_max hang again...
Message-ID: <20020910192913.GB6085@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.33.0209091836470.14828-100000@ccvsbarc.wipro.com> <307667352.1031558825@[10.10.2.3]> <20020909223956.GA2093@pegasys.ws> <20020910095423.GA12068@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020910095423.GA12068@win.tue.nl>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2002 at 11:54:23AM +0200, Andries Brouwer wrote:
> On Mon, Sep 09, 2002 at 03:39:56PM -0700, jw schultz wrote:
> 
> > The current repeated scanning is awful.
> 
> I don't know what the problem is. The present scheme is very
> efficient on the average (since the pid space is very large,
> much larger than the number of processes, this scan is hardly
> ever done). All proposed alternatives are clumsy, incorrect,
> and much less efficient.

The scan itself i don't mind.  It is the rescan that bothers
me.  That is bother as in almost, but not quite, an itch.
"Awful" is perhaps an overstatement.  I agree the space
should be sparse enough to make rescans infrequent and i
have trouble imagining what these systems must be like that
the rescanning actually loops interminably.  Increasing
PID_MAX should make the pid space sparse enough to make the
problem implausible.

I was just responding to the frequent discussions of
"get_pid hang" and when i looked at get_pid said "yuck".

One of the bigger problems i have with the scan is the very
idea that there are pids that cannot be used because they
are still referenced but don't exist.  That sounds lax to
me.  I can understand the advantage of it.  The only place
it seems to impact is get_pid.  Keeping the task structs
around would mean coping with them in several other places.
It does occur to me that there could be some advantage to
having these terminated session, thread and process group
leaders show up in ps.

Well, i've put in my $0.02 plus interest.


-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
