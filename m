Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130359AbRATKzp>; Sat, 20 Jan 2001 05:55:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131212AbRATKzf>; Sat, 20 Jan 2001 05:55:35 -0500
Received: from ezri.xs4all.nl ([194.109.253.9]:31178 "HELO ezri.xs4all.nl")
	by vger.kernel.org with SMTP id <S130359AbRATKz0>;
	Sat, 20 Jan 2001 05:55:26 -0500
Date: Sat, 20 Jan 2001 11:55:24 +0100 (CET)
From: Eric Lammerts <eric@lammerts.org>
To: Felix von Leitner <leitner@convergence.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Off-Topic: how do I trace a PID over double-forks?
In-Reply-To: <20010119013649.A30163@convergence.de>
Message-ID: <Pine.LNX.4.32.0101201146050.14165-100000@ally.lammerts.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 19 Jan 2001, Felix von Leitner wrote:
> Now, the back channel for my init has a function that allows to set the
> PID of a process.  The idea is that the init does not start sendmail but
> a wrapper.  The wrapper forks, runs sendmail, does some magic trickery
> to find the real PID of the daemonized sendmail and tells init this PID
> so init will know it has to restart sendmail when it exits and won't
> restart the wrapper when that exits.

> Someone suggested using fcntl to create a lock and then use fcntl again
> to see who holds the lock.  That sounded good at first, but fork() does
> not seem to inherit locks.  Does anyone have another idea?

Take a look at fghack (http://cr.yp.to/daemontools/fghack.html). It
opens a pipe, gives the write end to the daemon (but the daemon is not
aware of that) and monitors the read end. When the daemon process
exits, the read end of the pipe gets EOF.

If the daemon closes all filehandles, you're out of luck.

Eric

-- 
Eric Lammerts <eric@lammerts.org> | The best way to accelerate a computer
http://www.lammerts.org           | running Windows is at 9.8 m/s^2.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
