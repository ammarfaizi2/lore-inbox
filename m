Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314444AbSEFOEp>; Mon, 6 May 2002 10:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314446AbSEFOEo>; Mon, 6 May 2002 10:04:44 -0400
Received: from unthought.net ([212.97.129.24]:56517 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S314444AbSEFOEo>;
	Mon, 6 May 2002 10:04:44 -0400
Date: Mon, 6 May 2002 16:04:43 +0200
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IO stats in /proc/partitions
Message-ID: <20020506160443.P26111@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	Mark Hahn <hahn@physics.mcmaster.ca>, linux-kernel@vger.kernel.org
In-Reply-To: <HBEHIIBBKKNOBLMPKCBBCEAOEMAA.znmeb@aracnet.com> <Pine.LNX.4.33.0205041718290.4175-100000@coffee.psychology.mcmaster.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 04, 2002 at 05:25:53PM -0400, Mark Hahn wrote:
> > I'm with Andries on this one! Linux can't survive if anyone can change it
> > and break all the supporting software in user space that reads stuff from
> 
> there is no serious breakage issue, since the extra fields would
> not break any competent parsing code.

That is ridiculous. Parsers parse a grammar, and fails when the input doesn't
obey the grammar.  Creating grammars that will satisfy *anything* that people
might think of putting into /proc files late saturday nights (take a look at
the ASCII art in /proc/mdstat for example !!) is not just something you can do
with any certainty.

You may think that you will be parsing a list of partitions - next week someone
felt that drawing a flowchart with ISO-8859-8 characters would be cooler, and
then you're stuck fixing your parser.

This was why we had a very long thread about creating an API for getting this
information out, something like kstat or pstat from some real 'NIX systems.

Let's not bring that thread up again - it's besides the point of this argument.
Read on.

> 
> > Linux has *got* to mature to the point where the documentation is *accurate*
> > and *available* and the APIs don't wobble under the feet of their users. I
> 
> nah.  changing APIs and internals is exactly the reason Linux wins.

No.  Changing APIs *when* and *where* it makes sense, is why Linux is winning.

There is a world of difference.

Disk statistics should *NOT* go into a partition-table-listing file.  Put the
statistics in a file for, say, *statistics*.    How hard can this be ?

It is
1)  Simple
2)  No more change than the original change
3)  Doesn't break parsers (neither the good or the bad ones)
4)  Logical.  Think of files as "name spaces", statistics in the statistics
    files, partitions in the partition files

What is the downside ?

Think about the BSD Socket API - sendfile() wasn't hacked into send() either. It could
have been - anything could have been hacked into send, but it was saner not to.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
