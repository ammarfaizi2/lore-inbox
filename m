Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261431AbVAXDgC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261431AbVAXDgC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 22:36:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261432AbVAXDgC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 22:36:02 -0500
Received: from fire.osdl.org ([65.172.181.4]:54481 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S261431AbVAXDfv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 22:35:51 -0500
Message-ID: <41F46B32.9070904@osdl.org>
Date: Sun, 23 Jan 2005 19:27:46 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bryce Harrington <bryce@osdl.org>
CC: Chris Wright <chrisw@osdl.org>, dev@osdl.org, linux-kernel@vger.kernel.org,
       stp-devel@lists.sourceforge.net
Subject: Re: Kernel 2.6.11-rc1/2 goes Postal on LTP
References: <Pine.LNX.4.33.0501221125140.30167-100000@osdlab.pdx.osdl.net>
In-Reply-To: <Pine.LNX.4.33.0501221125140.30167-100000@osdlab.pdx.osdl.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bryce Harrington wrote:
> On Fri, 21 Jan 2005, Chris Wright wrote:
> 
>>* Bryce Harrington (bryce@osdl.org) wrote:
>>
>>>Well, I'm not having much luck.  strace isn't installed on the system
>>>(and is giving errors when trying to compile it).  Also, the ssh session
>>>(and sshd) quits whenever I try running the following growfiles command
>>>manually, so I'm having trouble replicating the kernel panic manually.
>>
>>Sounds very much like oom killer gone nuts.
>>
>>
>>># growfiles -W gf14 -b -e 1 -u -i 0 -L 20 -w -l -C 1 -T 10 glseek19 glseek19.2
>>>
>>>Anyway, if anyone wants to investigate this further, I can provide
>>>access to the machine (email me).  Otherwise, I'm probably just going to
>>>wait for -rc2 and see if the problem's still there.
>>
>>Wait no longer, it's here ;-)
> 
> 
> Hmm, still the kernel is going nutso.  LTP and everything else on the
> system is getting killed, including the test manager process.
> 
> Below's a bit more info scraped from the console.  This is from a run on
> RH 9.0.  It looks like LTP got through 722 of its 2270 tests before the
> kernel goes postal on it.  This time it got through all the growfile
> commands before it died (see bottom of this post), however it looks like
> the same growfile cmd I reported earlier is the one causing the problem.
> 
> When I run:
> 
> mkfifo gffifo18;
> strace growfiles -b -W gf13 -e 1 -u -i 0 -L 30 -I r -r 1-4096 gffifo18 &> /tmp/growfiles_strace_log.txt
> 
> The following happens:
> 
> * I get this strace log:  http://developer.osdl.org/bryce/growfiles_strace_log.txt
> * The ssh session dies and returns to login prompt
> * A bunch of stuff similar to below is spewed to console

Similar for me, easy to reproduce (3 times today).
Here's a kernel messages log, with 32 processes killed,
mostly hotplug, but also bash (2x), runltp, & some daemons.

I could not login and do anything else, but I could/did
SysRq-T, P, M, S, U, B to reboot.  These are also in the log.

log:
http://developer.osdl.org/rddunlap/oom/oom_kill.txt

config:
http://developer.osdl.org/rddunlap/oom/config-2611rc2

on P4-UP, 1 GB RAM.

-- 
~Randy
