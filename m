Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268804AbTGJCCj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 22:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268828AbTGJCCj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 22:02:39 -0400
Received: from mithril.c-zone.net ([63.172.74.235]:54800 "EHLO mail.c-zone.net")
	by vger.kernel.org with ESMTP id S268804AbTGJCCG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 22:02:06 -0400
Message-ID: <3F0CCCAC.8020405@c-zone.net>
Date: Wed, 09 Jul 2003 19:17:16 -0700
From: jiho@c-zone.net
Organization: Kidding of Course
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011126 Netscape6/6.2.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: Zygo Blaxell <zblaxell@umail.hungrycats.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.21 IDE and IEEE1394+SBP2 regressions, orinoco_pci progress
References: <pan.2003.07.08.22.25.12.249185.15455@umail.hungrycats.org> <3F0B8844.9070108@c-zone.net> <E19aFLE-0003NF-00@satsuki.furryterror.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the explanation.  I thought maybe it had something to do with 
some other IDE issues that can result in lost interrupts.

Then again, who knows, maybe it does.... ;)

Zygo Blaxell wrote:

> [This is an email copy of a Usenet post to "vger.linux.kernel"]
> 
> On Tue, 08 Jul 2003 23:13:08 -0400, jiho wrote:
> 
>>Zygo Blaxell wrote:
>>Excuse my ignorance -- I suppose I'm blundering around here with a
>>number of IDE issues -- but what do you mean by, "at suspend time"?
>>
> 
> At the time I either hit the appropriate key sequence on the laptop, or
> run the 'apm -s' command, or when battery power drops below an arbitrary
> threshold, which causes the laptop to go into a low power mode (memory is
> powered, but CPU is stopped and all non-memory-related hardware is turned
> off).
> 
> 
>>How can there be a "suspend time" while a disk I/O request is "in
>>progress"?
>>
> 
> For this to happen there has to be a process or processes doing a lot of
> disk I/O at the moment that the suspend event occurs (which is typical if
> e.g. compiling a kernel while on battery power, and the battery power runs
> out half way through).
> 
> I'm guessing here, but I suspect that at least one IDE request has been
> sent to the drive, but a reply has not been received yet, when the APM
> BIOS stops executing Linux and cuts power to the drive.  When the laptop
> resumes some time later, the APM BIOS turns the drive back on and resumes
> executing Linux.  AFAICT APM expects the OS to take care of re-issuing the
> last command to the IDE disk, or expects the OS to avoid issuing a command
> just before the OS tells APM that it's ready to suspend.  Either approach
> would work.
> 
> Linux is still waiting for this command to complete after it resumes, but
> of course the drive and controller hardware don't remember what the
> command was as they've been turned off in the meantime.
> 
> In 2.4.20 and earlier, the kernel would wait a few seconds, then reset the
> IDE hardware and try the command again.  In 2.4.21, the kernel locks up
> hard.  Judging from my boolean CPU meter (aka the laptop fan, which
> activates during periods of high CPU activity), the CPU isn't very busy
> when it is locked up like this.
> 
> 


