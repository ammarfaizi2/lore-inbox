Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316464AbSEWMRk>; Thu, 23 May 2002 08:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316471AbSEWMRj>; Thu, 23 May 2002 08:17:39 -0400
Received: from alfie.demon.co.uk ([158.152.44.128]:24070 "HELO
	bagpuss.pyrites.org.uk") by vger.kernel.org with SMTP
	id <S316464AbSEWMRj>; Thu, 23 May 2002 08:17:39 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Nick.Holloway@pyrites.org.uk (Nick Holloway)
Newsgroups: list.linux-kernel
Subject: Re: Linux-2.5.17
Date: 23 May 2002 13:17:34 +0100
Organization: Alfie's Internet Node
Message-ID: <acimku$qh2$1@alfie.demon.co.uk>
In-Reply-To: <86256BC1.0076F247.00@smtpnotes.altec.com>
X-Newsreader: NN version 6.5.0 CURRENT #120
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In <86256BC1.0076F247.00@smtpnotes.altec.com> Wayne.Brown@altec.com writes:
> In comparing /proc/meminfo in 2.4.19-pre8 and 2.5.17 I see that there is very
> little difference except that the information gtop relies upon is missing.  The
> lines it needs aren't changed or rearranged, just gone altogether.  Was there
> any particular purpose for that, other than breaking programs like gtop?

I confess to submitting the patch to Linus to remove the compatability
lines when 2.5.0 was created.

The change that made the first two lines redundant was originally made in
1.3.68[1], and the intention was that they would removed -- the comment
in get_meminfo had:

    Tagged format, for easy grepping and expansion. The above will go away
    eventually, once the tools have been updated.

As I had an application that parsed /proc/meminfo around the time of
the change, I wrote the parser to handle the new format in preparation
for the old format going away.  Others would have done the same.

Someone mentioned that this compatability was still present during
2.4 development, so I made a mental note to submit a patch when 2.5
development started.

> I'm a firm believer that adding something new to a system should
> never break existing functionality unless absolutely necessary.  Was it
> necessary in this case, or was it done because someone was offended that
> it wasn't "clean" enough?

Where possible, interfaces should not be changed for the sake of change,
but you shouldn't keep old interfaces because that way lies bloat.

One of the beauties of Linux (IMO) is that broken interfaces don't have
to be maintained ad-infinitum.  It should be expected that interfaces
may be broken during the development series of kernels, and the tools
have a chance to catch up during this cycle.

The interface that gtop (implicitly) required is that "Swap:" should be
the 3rd line in /proc/meminfo.  You'll never get anyone to admit that
this is the interface to /proc/meminfo that should be maintained.

-
[1] http://groups.google.com/groups?selm=4glagm%24pno%40treflan.shout.net

-- 
 `O O'  | Nick.Holloway@pyrites.org.uk
// ^ \\ | http://www.pyrites.org.uk/
