Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751818AbWIGSlu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751818AbWIGSlu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 14:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751833AbWIGSlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 14:41:50 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:52355 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751818AbWIGSlt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 14:41:49 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Jean Delvare <jdelvare@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Oleg Nesterov <oleg@tv-sign.ru>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [PATCH] proc: readdir race fix (take 3)
References: <20060825182943.697d9d81.kamezawa.hiroyu@jp.fujitsu.com>
	<200609071031.33855.jdelvare@suse.de>
	<m1wt8frd7j.fsf@ebiederm.dsl.xmission.com>
	<200609072007.25239.jdelvare@suse.de>
Date: Thu, 07 Sep 2006 12:40:46 -0600
In-Reply-To: <200609072007.25239.jdelvare@suse.de> (Jean Delvare's message of
	"Thu, 7 Sep 2006 20:07:24 +0200")
Message-ID: <m1r6ynpljl.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Delvare <jdelvare@suse.de> writes:

> On Thursday 7 September 2006 15:57, Eric W. Biederman wrote:
>> Jean Delvare <jdelvare@suse.de> writes:
>> > I'll now apply Oleg's fix and see if things get better.
>
> After 8 hours of stress testing on two machines, no crash and no freeze. 
> So Oleg's fix seems to do the trick. Thanks Oleg :)
>
> I'll keep the patches applied on both machines, even without stress tests 
> it is still better to make sure nothing bad happens in the long run.
>
>> > "My" test program forks 1000 children who sleep for 1 second then
>> > look for themselves in /proc, warn if they can't find themselves, and
>> > exit. So basically the idea is that the process list will shrink very
>> > rapidly at the same moment every child does readdir(/proc).
>> >
>> > I attached the test program, I take no credit (nor shame) for it, it
>> > was provided to me by IBM (possibly on behalf of one of their own
>> > customers) as a way to demonstrate and reproduce the original
>> > readdir(/proc) race bug.
>>
>> Ok.  So whatever is creating lots of child threads that tripped you
>> up is probably peculiar to the environment on your laptop.
>
> There's nothing really special running on this laptop. Slackware 10.2 with 
> xterm, firefox, sylpheed, xchat, and that's about it. At least one of the 
> crashes I had yesterday happened when I was actively using firefox, I 
> can't tell for the other one.

Well firefox is threaded so that may be enough.  It takes a threaded
program to be able to trigger it.

> The difference with the system where no problem was observed may be that 
> the laptop has a preemptive kernel, and the desktop hasn't.

I suspect that just has the potential to make the window bigger.

Eric

