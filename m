Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271359AbTHRJdw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 05:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271362AbTHRJdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 05:33:52 -0400
Received: from natsmtp01.webmailer.de ([192.67.198.81]:32683 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S271359AbTHRJds
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 05:33:48 -0400
Message-ID: <3F409DC1.6070400@softhome.net>
Date: Mon, 18 Aug 2003 11:34:57 +0200
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Schwartz <davids@webmaster.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Dumb question: Why are exceptions such as SIGSEGV not logged
References: <lilr.p2.7@gated-at.bofh.it> <lOll.3Jp.19@gated-at.bofh.it>
In-Reply-To: <lOll.3Jp.19@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Schwartz wrote:
>>>
>>>	char *foo = 0;
>>>	sigset(SIGSEGV,SIG_IGNORE);
>>>	for(;;) { *foo = '\5'; }
>>>
>>>Your logfiles just got DoS'ed....
>>Why not then just log uncaught exceptions?
> 
> 	Because deliberately creating an uncaught exception is a perfectly sane,
> reasonable thing to do with well-defined semantics. Applications should feel
> free to do such reasonable things without getting complaints from the system
> administrator that their log is being flooded with garbage.
> 
> 	There is no mechanism that is guaranteed to terminate a process other than
> sending yourself an exception that is not caught. So in cases where you must
> guarantee that your process terminates, it is perfectly reasonable to send
> yourself a SIGILL.
> 

    You probably have missed some postings on this thread.
    This one:

----------------------------------------------
Jakob Oestergaard wrote:
> On Sat, Aug 16, 2003 at 06:06:34PM -0500, David D. Hagood wrote:
> 
>>Valdis.Kletnieks@vt.edu wrote:
>>
>>
>>>Consider this code:
>>>
>>>	char *foo = 0;
>>>	sigset(SIGSEGV,SIG_IGNORE);
>>>	for(;;) { *foo = '\5'; }
>>>
>>>Your logfiles just got DoS'ed....
> 
> ...
> 
> Consider this code:
>  for (;;) syslog(LOG_INFO, "root, hurt me please!");
> 
> My point being, that if a user wishes to spam the syslog he can.
> 
> Please read the syslogd man page - see under "SECURITY THREATS".
> Especially option 5 in that section:
> 
> ----------------
> 5.     Use step 4 and if the problem persists and is not secondary to a  rogue
>        program/daemon get a 3.5 ft (approx. 1 meter) length of sucker rod* and
>        have a chat with the user in question.
> 
>        Sucker rod def. -- 3/4, 7/8 or 1in. hardened steel rod, male  threaded
>        on  each  end.  Primary use in the oil industry in Western North Dakota
>        and other locations to pump 'suck' oil from oil wells.  Secondary  uses
>        are  for  the construction of cattle feed lots and for dealing with the
>        occasional recalcitrant or belligerent individual.
> ----------------
> 
----------------------------------------------

    So you can flood syslog in any way. and syslog(2) I beleive is much 
faster than SIGSEGV+kernel solution in this respect ;-)))

> 	FreeBSD logs any number of normal things that sane, reasonable processes do
> and it's very annoying. A very annoying example is FreeBSD's desire to log
> calls to 'wait' functions with 'SIGCHLD' ignored. How else can portable
> programs say, "I want you to automatically reap my zombies if you can, but
> otherwise, I'll reap them if needed by calling waitpid(WNOHANG) every once
> in a while".
> 

     If application cannot be responsible for its children - it is just 
bad programming practice. Fix applications.
     Reapping zombies 'just in case if any' sounds really bad.


