Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265163AbUATHXW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 02:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265168AbUATHXW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 02:23:22 -0500
Received: from mail-10.iinet.net.au ([203.59.3.42]:7112 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S265163AbUATHXU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 02:23:20 -0500
Message-ID: <400CD4B5.6020507@cyberone.com.au>
Date: Tue, 20 Jan 2004 18:11:49 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Tim Hockin <thockin@hockin.org>
CC: Rusty Russell <rusty@au1.ibm.com>, vatsa@in.ibm.com,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       rml@tech9.net
Subject: Re: CPU Hotplug: Hotplug Script And SIGPWR
References: <20040116174446.A2820@in.ibm.com> <20040120060027.91CC717DE5@ozlabs.au.ibm.com> <20040120063316.GA9736@hockin.org> <400CCE2F.2060502@cyberone.com.au> <20040120065207.GA10993@hockin.org>
In-Reply-To: <20040120065207.GA10993@hockin.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Tim Hockin wrote:

>On Tue, Jan 20, 2004 at 05:43:59PM +1100, Nick Piggin wrote:
>
>>>I think the sanest thing for a CPU removal is to migrate everything off the
>>>processor in question, move unrunnable tasks into TASK_UNRUNNABLE state,
>>>then notify /sbin/hotplug.  The hotplug script can then find and handle the
>>>unrunnable tasks.  No SIGPWR grossness needed.
>>>
>>>Code against 2.4 at http://www.hockin.org/~thockin/procstate - it was
>>>heavily tested and I *think* it is all correct (for that kernel snapshot).
>>>
>>Seems less robust and more ad hoc than SIGPWR, however.
>>
>
>Disagree.  SIGPWR will kill any process that doesn't catch it.  That's
>policy.  It seems more robust to let the hotplug script decide what to do.
>If it wants to kill each unrunnable task with SIGPWR, it can.  But if it
>wants to let them live, it can.
>

I thought hotplug is allowed to fail? Thus you can have a hung system.
Or what if the hotplug script itself becomes TASK_UNRUNNABLE? What if the
process needs a guaranteed scheduling latency?

(I dropped lhcs-devel@lists.sourceforge.net because its moderated)


