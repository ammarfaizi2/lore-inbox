Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131720AbQKJV3Q>; Fri, 10 Nov 2000 16:29:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131808AbQKJV3G>; Fri, 10 Nov 2000 16:29:06 -0500
Received: from [194.213.32.137] ([194.213.32.137]:12292 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S131720AbQKJV27>;
	Fri, 10 Nov 2000 16:28:59 -0500
Message-ID: <20001106233957.A392@bug.ucw.cz>
Date: Mon, 6 Nov 2000 23:39:57 +0100
From: Pavel Machek <pavel@suse.cz>
To: Sean Hunter <sean@dev.sportingbet.com>, bobyetman@att.net,
        linux-kernel@vger.kernel.org
Subject: Re: Loadavg calculation
In-Reply-To: <Pine.LNX.4.21.0011050746090.634-100000@juryrig.worldnet.att.net> <20001106081426.I6131@bart.dev.sportingbet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20001106081426.I6131@bart.dev.sportingbet.com>; from Sean Hunter on Mon, Nov 06, 2000 at 08:14:26AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I'm working a project a work that is using Linux to run some very
> > math-intensive calculations.   One of the things we do is use the 1-minute
> > loadavg to determine how busy the machine is and can we fire off another
> > program to do more calculations.    However, there's a problem with that.
> > 
> > Because it's a 1 minute load average, there's quite a bit of lag time from
> > when 1 program finishes until the loadavg goes down below a threshold for
> > our control mechanism to fire off another program.
> > 
> > Let me give an example (all on a 1-cpu PC)
> > 
> > HH:MM:SS
> > 00:00:00    		fire off 4 programs 
> > 00:01:00		loadavg goes up to 4
> > 00:01:30		3 of the 4 programs finish loadavg still at 4
> > 00:02:20		load avg goes down to 1, below our threshold
> > 00:02:21		we fire off 3 more programs.
> > 
> > We'd like to reduce that almost 50 second lag time.  Is it possible, in
> > user-space, to duplicate the loadavg calculation period, say to a 15
> > second load average, using the information in /proc?

pavel@bug:~$ cat /proc/loadavg
0.00 0.00 0.00 2/46 395
pavel@bug:~$

The three values of 0.00 are loadavg averaged over different
time. Select the right one and you are done.
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
