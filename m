Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264222AbTEOT5J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 15:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264227AbTEOT5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 15:57:09 -0400
Received: from pengo.systems.pipex.net ([62.241.160.193]:34996 "HELO
	pengo.systems.pipex.net") by vger.kernel.org with SMTP
	id S264222AbTEOT5G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 15:57:06 -0400
From: shaheed <srhaque@iee.org>
To: Robert Love <rml@tech9.net>
Subject: Re: 2.6 must-fix list, v2
Date: Thu, 15 May 2003 21:07:17 +0100
User-Agent: KMail/1.5
Cc: Felipe Alfaro Solana <yo@felipe-alfaro.com>,
       Andrew Morton <akpm@digeo.com>, LKML <linux-kernel@vger.kernel.org>
References: <1050146434.3e97f68300fff@netmail.pipex.net> <1052990397.3ec35bbd5e008@netmail.pipex.net> <1053012743.899.5.camel@icbm>
In-Reply-To: <1053012743.899.5.camel@icbm>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305152107.17419.srhaque@iee.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 15 May 2003 4:32 pm, Robert Love wrote:

> It is racey to do this, so its something that should remain a hack and
> not part of taskset, I think.

Hmm. I guess you are thinking of daemons?

> If you do it in rc.d, you don't need to set all the parents. rc.d is the
> first thing run, so if you do it at the top of the script, nothing else
> is running. Just put:
>
> 	taskset <mask> 1
> 	taskset <mask> $$
>
> at the top of rc.d.

Perhaps we are talking at cross purposes. As I understand it the calling chain 
is:

1. kernel bootstrap
2. /sbin/init
3. bash to run /etc/rc.sysinit
4. bash to run individual /etc/rcN.d/whatever

I feel wary of doing it in 3 as you seem to suggest because I am pretty sure 
this will intimidate my customers. I am happy to do it in 4 - I can avoid the 
races by only doing it for the distros I care about.

That leaves options 1 and 2 for a community-wide solution. I guess I haven't 
quite understood the reluctance to do it in 1 given that:

- we know who owns 1 (!!)

- AFAICS, it isn't conceptual bloat because the utility of the implementation 
of sys_setaffinity() in 1 is greatly limited by not including this feature.

- its hardly physical bloat because the number of bytes required to implement 
this is absolutely in the noise, and virtually all __init()ed away.

> Another consideration is modifying init (and hopefully having said
> changes merged back). Init could call sched_setaffinity() when it is
> first created, based on a setting in /etc/inittab or a command line
> parameter passed during boot.

I have no idea with whom to persue this path, and as I say, I feel that 
solving this once for each distro is crazy IMHO.

> My reservation is against doing it in the kernel. I do not particularly
> care _how_ its done in user-space.

I'm sorry to appear foolish, but as explained above, I genuinely don't 
understand why this does not belong in the kernel. I would be grateful for 
elaboration. If I really am being thick, then just ignore me and I'll just 
solve this for myself using route 4.

In any case, thanks for all the patience and kind suggestions so far - it is 
appreciated.

Regards, Shaheed
