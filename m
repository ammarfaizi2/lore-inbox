Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279086AbRJ2Jas>; Mon, 29 Oct 2001 04:30:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279087AbRJ2Jaj>; Mon, 29 Oct 2001 04:30:39 -0500
Received: from mail.anu.edu.au ([150.203.2.7]:14765 "EHLO mail.anu.edu.au")
	by vger.kernel.org with ESMTP id <S279086AbRJ2JaY>;
	Mon, 29 Oct 2001 04:30:24 -0500
Message-ID: <3BDD20E3.6AF58BBB@anu.edu.au>
Date: Mon, 29 Oct 2001 20:26:59 +1100
From: Robert Cohen <robert.cohen@anu.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Misaligned write performance
In-Reply-To: <Pine.LNX.4.33.0110181850001.1489-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> > I believe that this is an odd situation and sure it only happens for
> > badly written program. I can see that it would be stupid to optimise for
> > this situation.
> > But do we really need to do this badly for this case?
> 
> Well, if you find a real application that cares, I might change my mind,
> but right now read-ahead looks like a waste of time to me.. Does anybody
> really do re-write in practice?

You're right. I don't have a real world program that cares.
The program I have is a thing named lantest which is the standard
benchmark benchmark for macintosh file server performace. Actually as
far as I can tell, the only benchmark available.

The reason am bothered by this case is that I feel its bad practise to
leave degenerate performance situations where the kernel performance
really sucks if it can be easily avoided. If you have a hole in kernel
performce where people can get into degenerate performance, sooner or
later someone is going to fall into it and then they're going to blame
the kernel. Sure this may only happen to badly written programs, but its
not as if the world is exactly short of them.

If you take my situation as a case in point, I was asked to evaluate
Linux and Solaris a potential file serving platforms for Mac clients. So
as part of my testing, I fired up lantest as a benchmark. Solaris was
fine, Linux sucked. My conclusion was that Linux was an immature
operating system that still needed some work and we went with Solaris.
Its only because I devoted time and effort into understanding why Linux
did so badly that I now understand that this is not a Linux problem per
se. And I only did that because I wanted to report the problem and help
Linux become a better operating system.

Anyway, as far as I can tell, it would barely affect Linux performance
to do some read ahead in this case. The disk head is already there, it
costs almost nothing to read a few extra 10's or 100's of K's of data.
And it would help eliminate this potentially degenerate case.


--
Robert Cohen
Unix Support
TLTSU
Australian National University
Ph: 612 58389
