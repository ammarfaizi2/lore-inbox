Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318650AbSIFPhf>; Fri, 6 Sep 2002 11:37:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318744AbSIFPhf>; Fri, 6 Sep 2002 11:37:35 -0400
Received: from mx1.elte.hu ([157.181.1.137]:15497 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S318650AbSIFPhb>;
	Fri, 6 Sep 2002 11:37:31 -0400
Date: Fri, 6 Sep 2002 17:39:55 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Paul Larson <plars@linuxtestproject.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: pid_max hang again...
In-Reply-To: <1031320378.24570.44.camel@plars.austin.ibm.com>
Message-ID: <Pine.LNX.4.44.0209061738330.24094-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 6 Sep 2002, Paul Larson wrote:

> It looks like this change dropped us back to the same error all this was
> originally supposed to fix.  When you hit PID_MAX, get_pid() starts
> looping forever looking for a free pid and hangs.  I could probably make
> my original fix work on this very easily if you'd like.

yes please send a patch for this. Reintroduction of the looping bug was
unintended.

> I wonder though, would it be possible to do this in a more simple way by
> just throttling max_threads back to something more sane if it gets
> defaulted too high?  Since it gets checked before we even get to the
> get_pid call in copy_process().  That would keep the number of processes
> down to a sane level without the risk.

this is a good approach as well, but now pid_max can be adjusted runtime
so truncating max_threads as a side-effect looks a bit problematic. We
should rather fail the fork() cleanly.

	Ingo

