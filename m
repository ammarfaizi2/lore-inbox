Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262418AbUEKInd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262418AbUEKInd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 04:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbUEKInd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 04:43:33 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:16644 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S262418AbUEKIn3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 04:43:29 -0400
Message-ID: <40A0929A.7040609@aitel.hist.no>
Date: Tue, 11 May 2004 10:45:14 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040509)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc3-mm2 (4KSTACK)
References: <200405061518.i46FIAY2016476@turing-police.cc.vt.edu> <1083858033.3844.6.camel@laptop.fenrus.com> <c7om3o$akd$1@gatekeeper.tmr.com>
In-Reply-To: <c7om3o$akd$1@gatekeeper.tmr.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:

> Arjan van de Ven wrote:
>
>>> It's probably a Bad Idea to push this to Linus before the vendors 
>>> that have
>>> significant market-impact issues (again - anybody other than NVidia 
>>> here?)
>>> have gotten their stuff cleaned up...
>>
>>
>>
>> Ok I don't want to start a flamewar but... Do we want to hold linux back
>> until all binary only module vendors have caught up ??
>
>
> My questions is, hold it back from what? Having the 4k option is fine, 
> it's just eliminating the current default which I think is 
> undesirable. I tried 4k stack, I couldn't measure any improvement in 
> anything (as in no visible speedup or saving in memory). 

The memory saving is usually modest: 4k per thread. It might make a 
difference for
those with many thousands of threads.   I believe this is unswappable 
memory,
which is much more valuable than ordinary process memory.

More interesting is that it removes one way for fork() to fail. With 8k 
stacks,
the new process needs to allocate two consecutive pages for those 8k.  That
might be impossible due to fragmentation, even if there are megabytes of 
free
memory. Such a problem usually only shows up after a long time.  Now we 
only need to
allocate a single page, which always works as long as there is any free 
memory at all.

> For an embedded system, where space is tight and the code paths well 
> known, sure, but I haven't been able to find or generate any objective 
> improvement, other than some posts saying smaller is always better. 
> Nothing slows a system down like a crash, even if it isn't followed by 
> a restore from backup.

Consider the case when your server (web/mail/other) fails to fork, and then
you can't login because that requires fork() too.  4k stacks remove this 
scenario,
and is a stability improvement.

Helge Hafting
