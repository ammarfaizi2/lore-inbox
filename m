Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275278AbTHGO3I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 10:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275352AbTHGO3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 10:29:08 -0400
Received: from WWW.CS.ubishops.ca ([206.167.194.132]:28809 "EHLO
	cs.ubishops.ca") by vger.kernel.org with ESMTP id S275278AbTHGO2Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 10:28:25 -0400
Message-ID: <3F3261A2.9000405@cs.ubishops.ca>
Date: Thu, 07 Aug 2003 10:26:42 -0400
From: Patrick McLean <pmclean@cs.ubishops.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030731
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Interactivity improvements
X-Enigmail-Version: 0.76.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a few ideas about the interactivity problem that I thought i 
would share.

First, the whole problem with interactive tasks turning into CPU hogs, 
and vice-versa. The current implementation is fairly good at estimating 
the interactivity of a new process isn't it? I assume it keeps some sort 
of statitistice on what a process has been doing in the past, so if a 
process starts to deviate from it's previous behavior quite a bit (say 
an interactive task starts finishing time slices, or a CPU hog starts 
sleeping a lot) couldn't we reset the priority, etc and let the 
interactivity estimator re-estimate the interactivity as if it was a new 
task. That way no task would get a real chance to starve others, while 
keeping interactive tasks interactive (interactive tasks that become CPU 
hogs for short peroids of time would have a pretty good chance to 
smarten up before they really get penalized).

Another point is compilers, they tend to do a lot of disk I/O then 
become major CPU hogs, could we have some sort or heuristic that reduces 
the bonuses for sleeping on block I/O rather than other kinds of I/O 
(say pipes and network I/O in the case of X). This would prevent tasks 
like compilers from getting real bonuses for reading alot of files at 
startup.

Finally, the interactivity estimator seems to be quite a bit of code, 
which certain people have no real useful (in servers for example) and I 
would imagine that it does reduce throughput, which is not a big deal in 
desktops, but in a server environment it's not good, so maybe a 
CONFIG_INTERACTIVE_ESTIMATOR or something similar would be an idea to 
keep the server people happy, just have an option to completely get rid 
of the extra overhead of having a really nice interactivity estimator. I 
could be an idiot though, and I imagine that I will be needing some 
asbestos for saying this, but I thought I would voice my opinion.

