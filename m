Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267397AbUHDUEZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267397AbUHDUEZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 16:04:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267403AbUHDUEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 16:04:24 -0400
Received: from mail.inter-page.com ([12.5.23.93]:43282 "EHLO
	mail.inter-page.com") by vger.kernel.org with ESMTP id S267397AbUHDUEO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 16:04:14 -0400
From: "Robert White" <rwhite@casabyte.com>
To: "'Bill Davidsen'" <davidsen@tmr.com>, <linux-kernel@vger.kernel.org>
Subject: RE: Interesting race condition...
Date: Wed, 4 Aug 2004 13:03:50 -0700
Organization: Casabyte, Inc.
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAtvmiCqH5I06YSBiFSV8ZAgEAAAAA@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <ce6e3r$i4n$1@gatekeeper.tmr.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using procps version 2.0.7 the inclusion of "e" in the arguments is documented to
return environment of the process.

So the below issues with "ps eaxf" are only surprising in that you claim the pipe is
necessary to see the environment.  Ps has "always" done slightly different things
when used at the head of a pipe.  In particular it will trim it's right side when not
in a pipe to keep the display readable, while in a pipe the lines will be "as long as
necessary."

The question of why the original poster was getting the environment when only using
"ps ax" is interesting.  I'd look for PS_PERSONALITY (etc) in the ps-executing
environment.  [consult your manual.]

And so on...

Rob.

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-owner@vger.kernel.org]
On Behalf Of Bill Davidsen
Sent: Tuesday, July 27, 2004 1:40 PM
To: linux-kernel@vger.kernel.org
Subject: Re: Interesting race condition...

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
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


