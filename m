Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261914AbVFQExN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbVFQExN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 00:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261913AbVFQExN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 00:53:13 -0400
Received: from vms048pub.verizon.net ([206.46.252.48]:29597 "EHLO
	vms048pub.verizon.net") by vger.kernel.org with ESMTP
	id S261914AbVFQExF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 00:53:05 -0400
Date: Fri, 17 Jun 2005 00:53:03 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
In-reply-to: <20050616204358.GA4656@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>, "K.R. Foley" <kr@cybsft.com>,
       "Eugeny S. Mints" <emints@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>
Message-id: <200506170053.03294.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <20050608112801.GA31084@elte.hu> <42B1BDF7.1000700@cybsft.com>
 <20050616204358.GA4656@elte.hu>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 16 June 2005 16:43, Ingo Molnar wrote:
>* K.R. Foley <kr@cybsft.com> wrote:
>> >>[...] That works to get the system booted. Although I am getting
>> >> many soft lockups now, minutes after the boot. Log attached.
>> >> [...]
>> >
>> >hm, do you get actual lockups, or only the messages about them?
>> > I.e. does the system work fine if you [the sounds of careful
>> > thinking to get the word right] disable
>> > CONFIG_DETECT_SOFTLOCKUP, or does it lock up silently?
>>
>> There doesn't seem to be any actual lockups, just messages. I will
>> try disabling the above when I get home this evening. Can't get to
>> the system right now.
>
>i tweaked the softlockup detector in the last patch a bit (to fix
> false positives under very high loads), might have broken it on
> SMP.
>
> Ingo

I'm not sure what it is I've got here.  I just tried to restart boinc, 
which hadn't run here in 10 days or so, cause its not housebroken yet 
IMO, and got this in the shell I started it from after a failed 
connection to berkeley attempt, followed by a repeat access:
2005-06-17 00:41:47 [Einstein@Home] Scheduler request to 
http://einstein.phys.uwm.edu/EinsteinAtHome_cgi/cgi succeeded
2005-06-17 00:41:47 [---] request_reschedule_cpus: files downloaded
2005-06-17 00:41:47 [---] schedule_cpus: must schedule
2005-06-17 00:41:47 [---] New work fetch policy: work fetch allowed.
2005-06-17 00:41:47 [---] New CPU scheduler policy: highest debt 
first.
SIGSEGV: segmentation violationStack trace (7 frames):
./boinc[0x807e54e]
[0xffffe420]
./boinc[0x80536e0]
./boinc[0x80725ab]
./boinc[0x80726a8]
/usr/lib/tls/i686/libc.so.6(__libc_start_main+0xe4)[0x4b8b6ad4]
./boinc[0x804ae91]

Exiting...
connect: Operation now in progress
init_poll: get_socket_error(): 111
init_poll: get_socket_error(): 111
already tried both ports, giving up
[1]+  Done                    ./run_client
[root@coyote BOINC]#

Can any sense be made from this?  This is 48-33 with the two items 
mentioned before in this thread disabled.                                                

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.35% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
