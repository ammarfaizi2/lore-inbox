Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264453AbTK0Il3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 03:41:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264455AbTK0Il3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 03:41:29 -0500
Received: from mail-05.iinet.net.au ([203.59.3.37]:439 "HELO mail.iinet.net.au")
	by vger.kernel.org with SMTP id S264453AbTK0Il1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 03:41:27 -0500
Message-ID: <3FC5B8B2.7000702@cyberone.com.au>
Date: Thu, 27 Nov 2003 19:41:22 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: William Lee Irwin III <wli@holomorphy.com>,
       Gene Heskett <gene.heskett@verizon.net>, linux-kernel@vger.kernel.org
Subject: Re: amanda vs 2.6
References: <200311261212.10166.gene.heskett@verizon.net> <200311261415.52304.gene.heskett@verizon.net> <20031126193059.GS8039@holomorphy.com> <200311261443.43695.gene.heskett@verizon.net> <20031126195049.GT8039@holomorphy.com> <Pine.LNX.4.58.0311261202050.1524@home.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0311261202050.1524@home.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Linus Torvalds wrote:

>
>On Wed, 26 Nov 2003, William Lee Irwin III wrote:
>
>
>>On Wed, Nov 26, 2003 at 02:43:43PM -0500, Gene Heskett wrote:
>>
>>>No, it just hangs forever on the su command, never coming back.
>>>everything else I tried, which wasn't much, seemed to keep on working
>>>as I sent that message with that hung su process in another shell on
>>>another window.  I'm an idiot, normally running as root...
>>>I've rebooted, not knowing if an echo 0 to that variable would fix it
>>>or not, I see after the reboot the default value is 0 now.
>>>
>>Okay, then we need to figure out what the hung process was doing.
>>Can you find its pid and check /proc/$PID/wchan?
>>
>
>I've seen this before, and I'll bet you 5c (yeah, I'm cheap) that it's
>trying to log to syslogd.
>
>And syslogd is stopped for some reason - either a bug, a mistaken SIGSTOP,
>or simply because the console has been stopped with a simple ^S.
>
>That won't stop "su" working immediately - programs can still log to
>syslogd until the logging socket buffer fills up. Which can be _damn_
>frsutrating to find (I haven't seen this behaviour lately, but I remember
>being perplexed like hell a long time ago).
>

Same problem here. Been seeing them now and again for quite a while
I have syslogd and klogd sleeping in do_syslog. cron and login are
sleeping in schedule_timeout. A sysrq+T gets things going again but
unfortunately the interesting state probably wasn't captured. I have
the /proc/*/wchan and sysrq+t trace if anyone is interested.

I'll try any suggestions of what I should look at when I hit it again.

Nick


