Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319238AbSIFPy4>; Fri, 6 Sep 2002 11:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319234AbSIFPy4>; Fri, 6 Sep 2002 11:54:56 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:16358 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S319238AbSIFPyy>; Fri, 6 Sep 2002 11:54:54 -0400
Subject: Re: pid_max hang again...
From: Paul Larson <plars@linuxtestproject.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0209061738330.24094-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0209061738330.24094-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 06 Sep 2002 10:47:23 -0500
Message-Id: <1031327243.30451.7.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-09-06 at 10:39, Ingo Molnar wrote:
> 
> On 6 Sep 2002, Paul Larson wrote:
> 
> > It looks like this change dropped us back to the same error all this was
> > originally supposed to fix.  When you hit PID_MAX, get_pid() starts
> > looping forever looking for a free pid and hangs.  I could probably make
> > my original fix work on this very easily if you'd like.
> 
> yes please send a patch for this. Reintroduction of the looping bug was
> unintended.
> 
> > I wonder though, would it be possible to do this in a more simple way by
> > just throttling max_threads back to something more sane if it gets
> > defaulted too high?  Since it gets checked before we even get to the
> > get_pid call in copy_process().  That would keep the number of processes
> > down to a sane level without the risk.
> 
> this is a good approach as well, but now pid_max can be adjusted runtime
> so truncating max_threads as a side-effect looks a bit problematic. We
> should rather fail the fork() cleanly.
I agree, unless this was just going to be temporary.  I'll pull the
get_pid() fix up to the current version and send it in a bit.

Thanks,
Paul Larson

