Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131669AbRDMURE>; Fri, 13 Apr 2001 16:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131691AbRDMUQz>; Fri, 13 Apr 2001 16:16:55 -0400
Received: from ike-ext.ab.videon.ca ([206.75.216.35]:15859 "HELO
	ike-ext.ab.videon.ca") by vger.kernel.org with SMTP
	id <S131669AbRDMUQi>; Fri, 13 Apr 2001 16:16:38 -0400
Date: Fri, 13 Apr 2001 14:16:36 -0600 (MDT)
From: Jason Gunthorpe <jgg@debian.org>
To: Philippe Troin <phil@fifi.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Lost O_NONBLOCK (Bug?)
In-Reply-To: <87wv8p70xb.fsf@tantale.fifi.org>
Message-ID: <Pine.LNX.3.96.1010413141220.7113E-100000@wakko.deltatee.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 12 Apr 2001, Philippe Troin wrote:

> Apt I guess ? It has a very strange behavior when backgrounded...

Not really, just want it tries to run dpkg it hangs.

> > The last read was after the process was forgrounded. The read waits
> > forever, the non-block flag seems to have gone missing. It is also a
> > little odd I think that it repeated to get SIGTTIN which was never
> > actually delivered to the program.. Shouldn't SIGTTIN suspend the process?
 
> Strace can perturbate signal delivery, especially for terminal-related
> signals, I wouldn't trust it...

I know, the problem still happens without strace.

> O_NONBLOCK is not lost... Attempting to read from the controlling tty
> even from a O_NONBLOCK descriptor will trigger SIGTTIN.

I don't really care about the SIGTTIN, what bugs me is that the read that
happens after the process has been foregrounded blocks - and that should
not be.

> Why not use tcflush(STDIN_FILENO, TCIFLUSH) rather than using
> O_NONBLOCK ?

Mm, thats probably better.
 
> But why would you want to flush stdin if you're in the background ?

Well, overall, I don't even want to fork if I'm in the background. Getting
suspsended before forking is perfectly fine.

Jason

