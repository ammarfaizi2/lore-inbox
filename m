Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266196AbUGOCUP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266196AbUGOCUP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 22:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266170AbUGOCUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 22:20:15 -0400
Received: from smtp104.mail.sc5.yahoo.com ([66.163.169.223]:24453 "HELO
	smtp104.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266196AbUGOCTX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 22:19:23 -0400
Message-ID: <40F5E9A0.3050402@yahoo.com.au>
Date: Thu, 15 Jul 2004 12:19:12 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040707 Debian/1.7-5
X-Accept-Language: en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Andrew Morton <akpm@osdl.org>, lmb@suse.de, arjanv@redhat.com,
       phillips@istop.com, sdake@mvista.com, teigland@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Minneapolis Cluster Summit, July 29-30
References: <1089615523.2806.5.camel@laptop.fenrus.com> <20040712100547.GF3933@marowsky-bree.de> <20040712101107.GA31013@devserv.devel.redhat.com> <20040712102124.GH3933@marowsky-bree.de> <20040712102818.GB31013@devserv.devel.redhat.com> <20040712115003.GV3933@marowsky-bree.de> <20040712120127.GB16604@devserv.devel.redhat.com> <20040712131312.GY3933@marowsky-bree.de> <40F294D2.3010203@yahoo.com.au> <20040712135432.57d0133c.akpm@osdl.org> <20040714121920.GA2350@elf.ucw.cz>
In-Reply-To: <20040714121920.GA2350@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
> 
>>>I don't see why it would be a problem to implement a "this task
>>>facilitates page reclaim" flag for userspace tasks that would take
>>>care of this as well as the kernel does.
>>
>>Yes, that has been done before, and it works - userspace "block drivers"
>>which permanently mark themselves as PF_MEMALLOC to avoid the obvious
>>deadlocks.
> 
> 
>>Note that you can achieve a similar thing in current 2.6 by acquiring
>>realtime scheduling policy, but that's an artifact of some brainwave which
>>a VM hacker happened to have and isn't a thing which should be relied upon.
>>
>>A privileged syscall which allows a task to mark itself as one which
>>cleans memory would make sense.
> 
> 
> Does it work?
> 
> I mean, in kernel, we have some memory cleaners (say 5), and they
> need, say, 1MB total reserved memory.
> 
> Now, if you add another task with PF_MEMALLOC. But now you'd need
> 1.2MB reserved memory, and you only have 1MB. Things are obviously
> going to break at some point.
> 								Pavel

Well you'd have to be more careful than that. In particular
you wouldn't just be starting these things up, let alone
have them allocate 1MB in to free some memory.

This situation would still blow up whether you did it in
kernel or not.
