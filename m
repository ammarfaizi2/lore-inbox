Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319112AbSIDJV1>; Wed, 4 Sep 2002 05:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319113AbSIDJV0>; Wed, 4 Sep 2002 05:21:26 -0400
Received: from gate.in-addr.de ([212.8.193.158]:27664 "HELO mx.in-addr.de")
	by vger.kernel.org with SMTP id <S319112AbSIDJVY>;
	Wed, 4 Sep 2002 05:21:24 -0400
Date: Wed, 4 Sep 2002 11:26:45 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: "Peter T. Breuer" <ptb@it.uc3m.es>
Cc: root@chaos.analogic.com, Rik van Riel <riel@conectiva.com.br>,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] mount flag "direct" (fwd)
Message-ID: <20020904092645.GE7836@marowsky-bree.de>
References: <20020903185344.GA7836@marowsky-bree.de> <200209032107.g83L71h10758@oboe.it.uc3m.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200209032107.g83L71h10758@oboe.it.uc3m.es>
User-Agent: Mutt/1.4i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002-09-03T23:07:01,
   "Peter T. Breuer" <ptb@it.uc3m.es> said:

> > *ouch* Sure. Right. You just have to read it from scratch every time. How
> > would you make readdir work?
> Well, one has to read it from scratch. I'll set about seeing how to do.
> CLues welcome.

Yes, use a distributed filesystem. There are _many_ out there; GFS, OCFS,
OpenGFS, Compaq has one as part of their SSI, Inter-Mezzo (sort of), Lustre,
PvFS etc.

Any of them will appreciate the good work of a bright fellow.

Noone appreciates reinventing the wheel another time, especially if - for
simplification - it starts out as a square.

> > Just please, tell us why.
> You don't really want the whole rationale.

Yes, I do.

You tell me why Distributed Filesystems are important. I fully agree.

You fail to give a convincing reason why that must be made to work with
"all" conventional filesystems, especially given the constraints this implies.

Conventional wisdom seems to be that this can much better be handled specially
by special filesystems, who can do finer grained locking etc because they
understand the on disk structures, can do distributed journal recovery etc.

What you are starting would need at least 3-5 years to catch up with what
people currently already can do, and they'll improve in this time too. 

I've seen your academic track record and it is surely impressive. I am not
saying that your approach won't work within the constraints. Given enough
thrust, pigs fly. I'm just saying that it would be nice to learn what reasons
you have for this, because I believe that "within the constraints" makes your
proposal essentially useless (see the other mails).

In particular, they make them useless for the requirements you seem to have. A
petabyte filesystem without journaling? A petabyte filesystem with a single
write lock? Gimme a break.

Please, do the research and tell us what features you desire to have which are
currently missing, and why implementing them essentially from scratch is
preferrable to extending existing solutions.

You are dancing around all the hard parts. "Don't have a distributed lock
manager, have one central lock." Yeah, right, has scaled _really_ well in the
past. Then you figure this one out, and come up with a lock-bitmap on the
device itself for locking subtrees of the fs. Next you are going to realize
that a single block is not scalable either because one needs exclusive write
lock to it, 'cause you can't just rewrite a single bit. You might then begin
to explore that a single bit won't cut it, because for recovery you'll need to
be able to pinpoint all locks a node had and recover them. Then you might
begin to think about the difficulties in distributed lock management and
recovery. ("Transaction processing" is an exceptionally good book on that I
believe)

I bet you a dinner that what you are going to come up with will look
frighteningly like one of the solutions which already exist; so why not
research them first in depth and start working on the one you like most,
instead of wasting time on an academic exercise?

> So, start thinking about general mechanisms to do distributed storage.
> Not particular FS solutions.

Distributed storage needs a way to access it; in the Unix paradigm,
"everything is a file", that implies a distributed filesystem. Other
approaches would include accessing raw blocks and doing the locking in the
application / via a DLM (ie, what Oracle RAC does).


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
Immortality is an adequate definition of high availability for me.
	--- Gregory F. Pfister

