Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318139AbSHIDXA>; Thu, 8 Aug 2002 23:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318140AbSHIDW7>; Thu, 8 Aug 2002 23:22:59 -0400
Received: from fly.hiwaay.net ([208.147.154.56]:58638 "EHLO mail.hiwaay.net")
	by vger.kernel.org with ESMTP id <S318139AbSHIDW6>;
	Thu, 8 Aug 2002 23:22:58 -0400
Date: Thu, 8 Aug 2002 22:26:38 -0500
From: Chris Adams <cmadams@hiwaay.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Linux-2.5 fix/improve get_pid()
Message-ID: <20020808222638.B296691@hiwaay.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200208082309.g78N9Xs38843@saturn.cs.uml.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Once upon a time, Albert D. Cahalan <acahalan@cs.uml.edu> said:
>Mind sharing what "ps -fj", "ps -lf", and "ps j" look like?
>The standard tty is 80x24 BTW, and we already have serious
>problems due to ever-expanding tty names.
>
>How about a default limit of 9999, to be adjusted by
>sysctl as needed?

I hope you meant 99999 (since we already have 5 digit PIDs).  It would
also seem to me that if it is adjustable, then "ps" would have to handle
it anyway, and making "ps" deal with adjustable size PIDs would be more
complex and error-prone.

Tru64 Unix 5.x uses 19 bit pids (up to 524288, so up to six digits - the
rest of the 32 bits go for cluster node, node sequence, and an unused
sign bit) without significant problems.  Their "ps" args aren't an exact
match, but they're close (lots of processes snipped):

$ ps -fj | head -2
UID         PID   PPID    C STIME    TTY             TIME CMD
cmadams  272363 301021  0.0 20:47:46 pts/1        0:00.09 -bash (bash)
$ ps -lf | head -2
       F S           UID    PID   PPID %CPU PRI  NI  RSS WCHAN    STARTED         TIME COMMAND
80c08001 I           200 272363 301021  0.0  44   0 520K wait     20:47:46     0:00.09 -bash (bash)
$ ps j | head -2
USER        PID   PPID   PGID   SESS JOBC S    TTY             TIME COMMAND
cmadams  272363 301021 272363 272363    0 I    pts/1        0:00.09 -bash (bash)
$ 

I had exactly one problem moving to 5.x with larger PIDs: the free "top"
program (Tru64 doesn't include "top") assumed 5 digit PIDs so the
columns didn't line up until I changed the output format by one column.

I routinely have 1000+ processes running on this server (many of them
short-lived things like POP checks, short CGIs, sendmail background
delivery, etc.), so having a larger PID space is important (having the
same PID reused within 15-30 seconds would be annoying).

I would like to see Linux running on this server (or at least this class
of server), and limiting the number of PIDs because of "ps" formatting
is not the way to go.

-- 
Chris Adams <cmadams@hiwaay.net>
Systems and Network Administrator - HiWAAY Internet Services
I don't speak for anybody but myself - that's enough trouble.
