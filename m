Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262344AbVBXNY3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262344AbVBXNY3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 08:24:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262346AbVBXNY3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 08:24:29 -0500
Received: from hermine.aitel.hist.no ([158.38.50.15]:782 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S262342AbVBXNWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 08:22:54 -0500
Message-ID: <421DD5CC.5060106@aitel.hist.no>
Date: Thu, 24 Feb 2005 14:25:32 +0100
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Chad N. Tindel" <chad@tindel.net>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Xterm Hangs - Possible scheduler defect?
References: <20050223230639.GA33795@calma.pair.com> <20050223183634.31869fa6.akpm@osdl.org> <20050224052630.GA99960@calma.pair.com>
In-Reply-To: <20050224052630.GA99960@calma.pair.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chad N. Tindel wrote:

>>But the other side of the coin is that a SCHED_FIFO userspace task
>>presumably has extreme latency requirements, so it doesn't *want* to be
>>preempted by some routine kernel operation.  People would get irritated if
>>we were to do that.
>>    
>>
>
>Just to follow up a bit.  People writing apps that run at SCHED_FIFO know
>that they aren't getting hard real-time, and they are OK with that.  If they
>wanted something more they'd run on RTLinux.  Why would it be wrong to preempt
>the SCHED_FIFO process in the case, assuming that it is too hard to fix a broken
>design that doesn't allow the necessary kernel threads to run on any CPU?
>  
>
Why would anyone write a thread than uses exactly 100% of one cpu?
It seems wrong to me.  It is unsafe if they really need that much
processing power, what if an interrupt happens? Then they get slightly less.
 If they got a 10% faster cpu, would this thread suddenly drop to 90%
usage (and no problems with kernel threads)? 
If it stays at 100% then that suggests they are using some
sort of busy waiting which is bad programming.  Get a better hw
device that will provide an interrupt at the right time, and write a 
driver for
that.  Or find some spot in the code where a small delay in acceptable,
and set a short timer and sleep on it. It doesn't take much to get this
kernel thread going.

Helge Hafting
