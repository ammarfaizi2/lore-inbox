Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266622AbUG0UiH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266622AbUG0UiH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 16:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266625AbUG0UiA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 16:38:00 -0400
Received: from mail.tmr.com ([216.238.38.203]:4364 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S266622AbUG0Uha (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 16:37:30 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: Interesting race condition...
Date: Tue, 27 Jul 2004 16:40:22 -0400
Organization: TMR Associates, Inc
Message-ID: <ce6e3r$i4n$1@gatekeeper.tmr.com>
References: <Pine.HPX.4.58L.0407231058420.12978@punch.eng.cam.ac.uk><Pine.HPX.4.58L.0407231058420.12978@punch.eng.cam.ac.uk> <200407240317.57032.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1090960315 18583 192.168.12.100 (27 Jul 2004 20:31:55 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040608
X-Accept-Language: en-us, en
In-Reply-To: <200407240317.57032.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley wrote:
> On Friday 23 July 2004 05:01, P. Benie wrote:
> 
>>On Fri, 23 Jul 2004, Rob Landley wrote:
>>
>>>I just saw a funky thing.  Here's the cut and past from the xterm...
>>>
>>>[root@(none) root]# ps ax | grep hack
>>> 9964 pts/1    R      0:00 grep hack HOSTNAME= SHELL=/bin/bash TERM=xterm
>>>HISTSIZE=1000 USER=root
>>>LS_COLORS=no=00:fi=00:di=00;34:ln=00;36:pi=40;33:so=00;35:bd=40;33;01:cd=
>>>40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=00;32:*.cmd=00;32:*.exe=00;32:*.
>>>com=00;32:*.btm=00;32:*.bat=00;32:*.sh=00;32:*.csh=00;32:*.tar=00;31:*.tgz
>>>= [root@(none) root]# ps ax | grep hack
>>> 9966 pts/1    S      0:00 grep hack
>>>
>>>Seems like some kind of race condition, dunno if it's in Fedore Core 1's
>>>ps or the 2.6.7 kernel or what...
>>
>>The race is in the shell's pipeline - the processes don't start at exactly
>>the same time, and sometimes ps has completed before the shell has
>>started grep. This is the expected behaviour.
> 
> 
> It's expected behavior for PS to show a process's environment variables as 
> part of its command line?

When piped. For instance
   ps eaxf
does not, while
   ps eaxf | cat
does, at least on my systems. I tried on RHEL AS3.0 thru a four year old 
version of Slackware, all did the same thing.


-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
