Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266840AbTBTWrv>; Thu, 20 Feb 2003 17:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266996AbTBTWrv>; Thu, 20 Feb 2003 17:47:51 -0500
Received: from serenity.mcc.ac.uk ([130.88.200.93]:43794 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S266840AbTBTWrs>; Thu, 20 Feb 2003 17:47:48 -0500
Date: Thu, 20 Feb 2003 22:57:52 +0000
From: John Levon <levon@movementarian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ingo Molnar <mingo@elte.hu>, Zwane Mwaikambo <zwane@holomorphy.com>,
       Chris Wedgwood <cw@f00f.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: doublefault debugging (was Re: Linux v2.5.62 --- spontaneous reboots)
Message-ID: <20030220225752.GB85293@compsoc.man.ac.uk>
References: <Pine.LNX.4.44.0302202258130.4400-100000@localhost.localdomain> <Pine.LNX.4.44.0302201428540.1159-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302201428540.1159-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18lzdY-000API-00*7FVnmmNr/CA*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2003 at 02:32:02PM -0800, Linus Torvalds wrote:

> I think the _real_ simplification is to just have the task switch do this 
> in the tail:
> 
> 	if (prev->state & TASK_DEAD)
> 		put_task_struct(prev);
> 
> suddenly we don't have any issues at all with possibly freeing stuff 
> before its time, since we're guaranteed to keep the process around untill 
> we've properly scheduled out of it.

Side note ... if there's a sleepable context in which oprofile can
synchronise its buffers (i.e. after the task can possible run on a CPU
again, and before the task_struct itself is freed/reused), that would be
very handy.

Currently we're masking out any samples when PF_EXITING is set for
current(), which is obviously less than ideal.

Would this be such a spot ? Basically somewhere that profile_exit_task
can sit.

regards
john

