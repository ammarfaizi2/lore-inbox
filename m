Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261973AbTLCWJe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 17:09:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262123AbTLCWJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 17:09:34 -0500
Received: from mx2.it.wmich.edu ([141.218.1.94]:58502 "EHLO mx2.it.wmich.edu")
	by vger.kernel.org with ESMTP id S261973AbTLCWI5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 17:08:57 -0500
Message-ID: <3FCE5EF7.5010201@wmich.edu>
Date: Wed, 03 Dec 2003 17:08:55 -0500
From: Ed Sweetman <ed.sweetman@wmich.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: bill davidsen <davidsen@tmr.com>
CC: willy@w.ods.org, linux-kernel@vger.kernel.org
Subject: Re: XFS for 2.4
References: <20031202002347.GD621@frodo> <Pine.LNX.4.44.0312020919410.13692-100000@logos.cnet> <bqlbuj$j03$1@gatekeeper.tmr.com> <200312032117.QAA20238@gatekeeper.tmr.com>
In-Reply-To: <200312032117.QAA20238@gatekeeper.tmr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bill davidsen wrote:
> In article <20031203204518.GA11325@alpha.home.local> you write:
> | On Wed, Dec 03, 2003 at 07:01:39PM +0000, bill davidsen wrote:
> |  
> | > Yes, a development tree is much different than a stable tree, and even
> | > though the number has gone to 2.6, it's very much a development tree, in
> | > that it's still being used by the same people, and probably not getting
> | > a lot of new testing. Stability is unlikely to be production quality
> | > until fixes go in for problems in mass testing, which won't happen until
> | > it shows up in a vendor release, which won't happen until the vendors
> | > test and clean up what they find... In other words, I don't expect it to
> | > be "really stable" for six months at least, maybe a year.
> | 
> | There even are people using 2.2 on production and/or desktop computers. I
> | know some of them. Many people jumped from 2.2 to 2.4 because of USB, but
> | since it was backported into 2.2.18, many people prefered to stick to 2.2.
> 
> I still have a 2.0.30 machine, not network connected, does what I want.
> | 
> | > As for "much faster," let's say that I don't see that on any apples to
> | > apples benchmark. If you measure new threading against 2.4 threading
> | > there is a significant gain, but for anything else the gains just don't
> | > seem to warrant a "much" and there are some regressions shown in other
> | > people's data.
> | 
> | I second this. I've already tested several 2.5 and 2.6-test, and I'm
> | really deceived by the scheduler. It looks a lot more as a hack to
> | satisfy xmms users than something usable. I'm doing 'ls -ltr' all the
> | day in directories filled with 2000 files, and it takes ages to complete.
> | I'm even at the point to which I add a "|tail" to make things go faster.
> 
> Just tried that, test11 seems better behaved. I've been running Nick's
> patches, for general use they work better for me, I can stand a skip a
> few times a day.
> | 
> | For instance, time typically reports 0.03u, 0.03s, 2.8 real. It seems as
> | each line sent to xterm consumes one full clock tick doing nothing. I
> | never reported it yet because I don't have time to investigate, and it
> | seems more important that people don't hear skips in xmms while compiling
> | their kernel with "make -j 256" on a 16 MB machine. Second test : launch
> | 10 times : xterm -e "find /" & and look how some windows freeze for up
> | to 10 seconds... I don't think this is a problem right now. We've seen
> | lots of work in the scheduler area, many people proposing theirs, and
> | this will stabilize once 2.6 is out and people start to describe what
> | they really do with it and what they feel.

The windows can freeze for many reasons. You could be running X in a 
lower priority, painting X terms is heavy on X using that command and it 
can steal cpu from the terminal who's process is working in retrieving 
data from the fs. No dma on the hdds, Etc.  I ran this command using 
test11 with akpm's test10-mm1 patch applied and 10 were going just fine. 
  All going at the same time along with mplayer playing a divx movie. No 
skips in video or audio and all the terminals were updating as rapidly 
as they could with no pauses of noticable length.
The schedular is nothing short of incredibly better than 2.4.x and 
prior.  Despite the xmms croud's loud cries of trying to get the kernel 
to fix their player's performance which seems to always suffer more than 
any other player i've tried.


> | Don't take me wrong, I don't want to whine nor offend anyone here. I
> | think that Ingo and other people like Con have done a very great job
> | at optimizing this scheduler. I just wish we could choose one depending
> | on what we want to do with it.
> 
> It has been proposed, but people more influentional than I, that
> scheduling be a module with some base doorknob scheduler as default if
> not better scheduler is chosen.

having to manually adjust the schedular is seen by many as a fault in 
the design of the schedular.  The perfect schedular would be able to 
adjust itself automatically on it's own.  If that's perfect, then even 
if it's likely impossible to achieve it, it makes sense to strive to get 
as close to it as possible rather than create a set of separate 
schedulars which the root user (which really shouldn't be doing anything 
on the system all the time anyway) has to select whenever their workload 
changes from one goal to another.

