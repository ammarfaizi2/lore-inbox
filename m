Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263739AbTIHWfM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 18:35:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263737AbTIHWfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 18:35:11 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:57616 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S263730AbTIHWe5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 18:34:57 -0400
Message-ID: <3F5D091A.6070707@techsource.com>
Date: Mon, 08 Sep 2003 18:56:26 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Sipek <jeffpc@optonline.net>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Use of AI for process scheduling
References: <3F5CD863.4020605@techsource.com> <200309081755.19777.jeffpc@optonline.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Jeff Sipek wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> I think that this makes sense. It would definitely help with designing the 
> perfect scheduler. One thing tho, I wouldn't use kgdb or any other debugger, 
> instead I would say that /proc or /sys interface would make more sense. 
> Simply copy the weights somewhere else, dissect them, and then act 
> accordingly.
> 
> Jeff.


Well, we have this to deal with:  Someone is exercising the scheduler 
and notices some kind of misscheduling which causes the system to crawl.

How are they going to get to the /proc and /sys directories to do much 
of anything?  The system is completely unresponsive.  Furthermore, even 
if the system IS responsive, we need some way to for the user to hit a 
key and freeze the current state for examination.  Some slow-downs last 
only seconds, but we need to be able to catch them.


You talk about weights.  Would the linux community be willing to put a 
neural net into the kernel?  I'm sure we could optimize it to not take a 
lot of processing overhead, but it's an "unknown".  It would be scary to 
some people to be unable to disect the actual workings of it and have no 
way of determining corner-case behavior from examining code.  But if we 
have, say, only a 2-layer neural net, we might still be able to 
reverse-engineer it.


One thing I was thinking of is that if there is some information about a 
process which is inconvenient to get normally but could be accessed by a 
kernel or user-space thread, then this process could feed back info to 
the scheduler AI for it to do automatic tuning.  Some information that 
the scheduler doesn't have direct (or efficient) access to could be 
inferred from information it DOES have access to, and that would be 
learned through adjustment of weights via backpropogation.

