Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964978AbWFSX3m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964978AbWFSX3m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 19:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964981AbWFSX3m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 19:29:42 -0400
Received: from alt.aurema.com ([203.217.18.57]:22303 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id S964978AbWFSX3l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 19:29:41 -0400
Message-ID: <44973337.2060604@aurema.com>
Date: Tue, 20 Jun 2006 09:28:55 +1000
From: Peter Williams <peterw@aurema.com>
Organization: Aurema Pty Ltd
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Chris Friesen <cfriesen@nortel.com>
CC: Peter Williams <pwil3058@bigpond.net.au>, Andrew Morton <akpm@osdl.org>,
       Kirill Korotaev <dev@openvz.org>, Srivatsa <vatsa@in.ibm.com>,
       CKRM <ckrm-tech@lists.sourceforge.net>,
       Balbir Singh <bsingharora@gmail.com>, Mike Galbraith <efault@gmx.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Con Kolivas <kernel@kolivas.org>, Sam Vilain <sam@vilain.net>,
       Kingsley Cheung <kingsley@aurema.com>, Ingo Molnar <mingo@elte.hu>,
       Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [ckrm-tech] [PATCH 0/4] sched: Add CPU rate caps
References: <20060618082638.6061.20172.sendpatchset@heathwren.pw.nest> <4496F310.9010807@nortel.com>
In-Reply-To: <4496F310.9010807@nortel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen wrote:
> Peter Williams wrote:
>> These patches implement CPU usage rate limits for tasks.
> 
> Personally, I'm more comfortable with guarantees rather than limits.

It's not an "either or" situation.  You can have both.

As I said recently in other mail on this topic, the only thing that 
needs to be resolved when you have both caps and guarantees is which one 
has precedence if they conflict.  Of course, one solution to this is to 
disallow conflicting caps and guarantees but that is really just the 
same as saying whichever was set first has precedence.

> 
> Specifying a limit doesn't do anything to ensure that a task (or group 
> of tasks) gets enough cpu time to actually accomplish anything unless 
> you specify limits on every task in the system.

No, but it can be used to make sure certain tasks don't hog the CPU and 
prevent other tasks from getting their job done.

> 
> Suppose you have a server app that needs at least 50% of the cpu.  With 
> a guarantee, you can say "this guy needs 50%, and I don't care about 
> anything else".  With limits you have to flip it around--"all these guys 
> together are limited to 50%, and that guy isn't limited".  Seems 
> counterintuitive.

Yes, guarantees would be better for that problem but this doesn't mean 
that caps are useless.  Also an equivalent situation where caps are a 
better solution to guarantees would be easy to generate.  Ergo both 
mechanisms are useful.

For the ordinary user, I think that the most useful feature of this 
patch is the ability to impose a soft cap of zero on a task and for that 
cap to be inherited by its children (which it is).  This is a very 
useful for running a job (such as a kernel build) in the background.  If 
you look at the kernbench numbers that I enclosed you will note that, in 
the absence of other load on the computer, the increase in the build 
time using this feature is very small.  The advantages of having the 
build run in the background are improved responsiveness for those 
interactive tasks we're using (e.g. editing files, reading/writing mail 
etc.) while the build is in progress.

Peter
-- 
Dr Peter Williams, Chief Scientist         <peterw@aurema.com>
Aurema Pty Limited
Level 2, 130 Elizabeth St, Sydney, NSW 2000, Australia
Tel:+61 2 9698 2322  Fax:+61 2 9699 9174 http://www.aurema.com
