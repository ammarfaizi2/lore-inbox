Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265626AbUATRuP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 12:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265630AbUATRuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 12:50:15 -0500
Received: from smtp2.Stanford.EDU ([171.67.16.116]:63420 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP id S265626AbUATRuH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 12:50:07 -0500
Message-ID: <400D6A33.6020108@myrealbox.com>
Date: Tue, 20 Jan 2004 09:49:39 -0800
From: Andy Lutomirski <luto@myrealbox.com>
User-Agent: Mozilla Thunderbird 0.5a (Windows/20040113)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tim Hockin <thockin@hockin.org>
CC: Nick Piggin <piggin@cyberone.com.au>, Rusty Russell <rusty@au1.ibm.com>,
       vatsa@in.ibm.com, lhcs-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: CPU Hotplug: Hotplug Script And SIGPWR
References: <fa.f37o48p.1io5q5@ifi.uio.no> <fa.frjqvfo.170g8hq@ifi.uio.no>
In-Reply-To: <fa.frjqvfo.170g8hq@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Hockin wrote:

> On Tue, Jan 20, 2004 at 05:43:59PM +1100, Nick Piggin wrote:
> 
>>>I think the sanest thing for a CPU removal is to migrate everything off the
>>>processor in question, move unrunnable tasks into TASK_UNRUNNABLE state,
>>>then notify /sbin/hotplug.  The hotplug script can then find and handle the
>>>unrunnable tasks.  No SIGPWR grossness needed.
>>>
>>
>>Seems less robust and more ad hoc than SIGPWR, however.
> 
> 
> Disagree.  SIGPWR will kill any process that doesn't catch it.  That's
> policy.  It seems more robust to let the hotplug script decide what to do.
> If it wants to kill each unrunnable task with SIGPWR, it can.  But if it
> wants to let them live, it can.

This seems like a problem that a lot of power-management issues have. 
(At some point, linux may want to suspend itself after inactivity.  Both 
RT tasks and some interactive tasks may want to supress that.)  Why not 
add a SIGPM signal, which is only sent if handles, and which indicates 
that PM event is happening.  Give usermode some method of responding to 
it (e.g. handler returns a value, or a new syscall), and let 
/sbin/hotplug handle events for tasks that either ignore the signal or 
responded that they were uninterested.  This seems be close to optimal 
for every case I can think of.

--Andy

