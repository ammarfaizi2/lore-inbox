Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129608AbQKFXYA>; Mon, 6 Nov 2000 18:24:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129496AbQKFXXu>; Mon, 6 Nov 2000 18:23:50 -0500
Received: from deliverator.sgi.com ([204.94.214.10]:17491 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S129608AbQKFXXc>; Mon, 6 Nov 2000 18:23:32 -0500
From: "Nathan Scott" <nathans@wobbly.melbourne.sgi.com>
Message-Id: <10011071020.ZM117549@wobbly.melbourne.sgi.com>
Date: Tue, 7 Nov 2000 10:20:18 -0400
In-Reply-To: bobyetman@att.net
        "Loadavg calculation" (Nov, 5  12:55pm)
X-Mailer: Z-Mail (3.2.3 08feb96 MediaMail)
To: bobyetman@att.net
Subject: Re: Loadavg calculation
Cc: linux-kernel@vger.kernel.org, pcp@oss.sgi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

As you've suggested, you'd be better off not using the load
average but rather some other measure (or combination of
measures) to figure out when you have enough spare cycles or
bandwidth.

The "pmie" tool might be useful to you - here's a contrived
example I just knocked up (instead of a "print" you'd want
to run your program via the "shell" keyword) with an
occassional artificial load in the background.

kernel.all.cpu.idle is aggregate idle time across all cpus.
pmie converts it to a rate (#idle milliseconds / 8 seconds)
so it will always have a value between 0 (no idle time) and
1 (lots of idle time).


$ pmie -t 8sec -v
( kernel.all.cpu.idle > 0.5 ) -> print "start a new job";
^D
expr_1: ?

Tue Nov  7 09:33:36 2000: start a new job
expr_1: true

Tue Nov  7 09:33:44 2000: start a new job
expr_1: true

Tue Nov  7 09:33:52 2000: start a new job
expr_1: true

expr_1: false

expr_1: false

expr_1: false

Tue Nov  7 09:34:24 2000: start a new job
expr_1: true

Tue Nov  7 09:34:32 2000: start a new job
expr_1: true

expr_1: false

expr_1: false

Tue Nov  7 09:34:56 2000: start a new job
expr_1: true


pmie is one of the gpl'd pcp tools which you can get from
the sgi oss site... hope its useful to you.  mailto the
pcp list if you need any more info.

cheers.


bobyetman@att.net wrote:
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
> 00:00:00                fire off 4 programs
> 00:01:00                loadavg goes up to 4
> 00:01:30                3 of the 4 programs finish loadavg still at 4
> 00:02:20                load avg goes down to 1, below our threshold
> 00:02:21                we fire off 3 more programs.
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

-- 
Nathan

-- 
Nathan
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
