Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272558AbTGZPeo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 11:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272537AbTGZPcC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 11:32:02 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:4525 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id S272554AbTGZP3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 11:29:13 -0400
From: Daniel Phillips <phillips@arcor.de>
To: Ed Sweetman <ed.sweetman@wmich.edu>, Eugene Teo <eugene.teo@eugeneteo.net>
Subject: Re: Ingo Molnar and Con Kolivas 2.6 scheduler patches
Date: Sun, 27 Jul 2003 10:46:30 -0500
User-Agent: KMail/1.5.2
Cc: LKML <linux-kernel@vger.kernel.org>, kernel@kolivas.org
References: <1059211833.576.13.camel@teapot.felipe-alfaro.com> <20030726101015.GA3922@eugeneteo.net> <3F2264DF.7060306@wmich.edu>
In-Reply-To: <3F2264DF.7060306@wmich.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307271046.30318.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 26 July 2003 06:24, Ed Sweetman wrote:
> I'd really wish people would use examples other than a single player to
> generalize the performance of the kernel. For all you know xmms's
> decoder for the type of music you listen to could be written unoptimally
> to put it as nice as possible.  If all players and different types of
> pcm audio decoders are skipping in the situations you experience then
> that's different, but i hardly think that will be the case as it is not
> with me nor, ever has been that i can remember (maybe in early 2.3.x).

Audio players fall into a special category of application, the kind where it's 
not unreasonable to change the code around to take advantage of new kernel 
features to make them work better.  Remember this word: audiophile.  An 
audiophile will do whatever it takes to attain more perfect reproduction.  
Furthermore, where goes the audophile, soon follows the regular user.  Just 
go into a stereo store if you need convincing about that.

Now to translate this into concrete terms.  Audio reproduction is a realtime 
task - there is no way to argue it's not.  Ergo, perfect audo reproduction 
requires a true realtime scheduler.  Hence we require realtime scheduling.

The definition of a realtime scheduler is that the worst case latency is 
bounded.  The current crop of interactive tweaks do not do that.  So we need 
a scheduler with a bounded worst case.  Davide Libenzi's recent patch that 
implements a new SCHED_SOFTRR scheduler policy, usable by non-root users, 
provides such a bound.  Please don't lose sight of the fact that this is the 
correct solution to the problem, and that interactive tweaking, while it may 
produce good results for some or even most users in some or even most 
situations, will never magically transform Linux into an operating system 
that an audiophile could love.

Note: none of the above should be construed as discouragement for Con's work 
on improving interactive performance.  Just don't lump audio playback into 
the "interactive" category, please, it's not.  It's realtime.  By keeping 
this firmly in mind we will end up with better interactive performance, 
excellent audio reproduction, and simpler, better code overall.

Another note: I have not tested Davide's patch, nor have I read it in detail, 
or Ingo's scheduling code for that matter.  For that I plead "road trip". 
I'll do all of the above as soon as I get back to Berlin.  I do know that the 
Linux Audio guys I talked to at Linuxtag are excited about Davide's patch, 
and think it's exactly the right way to go.

Regards,

Daniel

