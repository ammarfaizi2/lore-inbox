Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130289AbQKFIWd>; Mon, 6 Nov 2000 03:22:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130293AbQKFIWX>; Mon, 6 Nov 2000 03:22:23 -0500
Received: from sportingbet.gw.dircon.net ([195.157.147.30]:24329 "HELO
	sysadmin.sportingbet.com") by vger.kernel.org with SMTP
	id <S130289AbQKFIWM>; Mon, 6 Nov 2000 03:22:12 -0500
Date: Mon, 6 Nov 2000 08:14:26 +0000
From: Sean Hunter <sean@dev.sportingbet.com>
To: bobyetman@att.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Loadavg calculation
Message-ID: <20001106081426.I6131@bart.dev.sportingbet.com>
Mail-Followup-To: Sean Hunter <sean@dev.sportingbet.com>, bobyetman@att.net,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0011050746090.634-100000@juryrig.worldnet.att.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0011050746090.634-100000@juryrig.worldnet.att.net>; from bobyetman@att.net on Sun, Nov 05, 2000 at 07:55:40AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I know this is a little left-field, but how about redesigning your
process so that instead of using a load_avg, you start all your calculations
from a single server on each node?  It could queue up incoming calculations,
and fork a child to do each one.

Of course, it would catch a signal when the child died, so you'd immediately
know when to start up another calculation.  If you liked, it could check the
one-minute load avg from time to time to see what would be a friendly level of
calculations overall, adjust the overall level of concurrent child processes
accordingly.

The timing, however, would still come from a signal, and would thus be
instantaneous.

Or am I being totally dumb?

Sean

On Sun, Nov 05, 2000 at 07:55:40AM -0500, bobyetman@att.net wrote:
> 
> I'm working a project a work that is using Linux to run some very
> math-intensive calculations.   One of the things we do is use the 1-minute
> loadavg to determine how busy the machine is and can we fire off another
> program to do more calculations.    However, there's a problem with that.
> 
> Because it's a 1 minute load average, there's quite a bit of lag time from
> when 1 program finishes until the loadavg goes down below a threshold for
> our control mechanism to fire off another program.
> 
> Let me give an example (all on a 1-cpu PC)
> 
> HH:MM:SS
> 00:00:00    		fire off 4 programs 
> 00:01:00		loadavg goes up to 4
> 00:01:30		3 of the 4 programs finish loadavg still at 4
> 00:02:20		load avg goes down to 1, below our threshold
> 00:02:21		we fire off 3 more programs.
> 
> We'd like to reduce that almost 50 second lag time.  Is it possible, in
> user-space, to duplicate the loadavg calculation period, say to a 15
> second load average, using the information in /proc?
> 
> The other option we looked at, besides using loadavg, was using idle pct%,
> but if I read the source for top right, involves reading the entire
> process table to calculate clock ticks used and then figuring out how many
> weren't used.
> 
> Ideas, opinions welcome.  Yes, I read the list, so either respond direct
> to me, or to the list.
> 
> bobyetman@att.net (Robert A. Yetman)
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
