Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161197AbWAHUw6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161197AbWAHUw6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 15:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932773AbWAHUw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 15:52:58 -0500
Received: from zproxy.gmail.com ([64.233.162.202]:43000 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932772AbWAHUw5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 15:52:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=UUCUlnh+CIwM2GGYEIk96jsLuLAUY6j1mQ6y49+hMQGOJt2v6XeziMZ8l31F/nd8umDHKEcL7Dz5ONAffVD3V3J3jSkWdJ13MwRSxBm6WuKsOrs0+44uK5m72WcyRwsjNB8jIeNnsh2Bt78cRGFIckVADTax2FWFyXre3fmqnfc=
Message-ID: <5bdc1c8b0601081252x59190f1ajcb5514364d78a4e@mail.gmail.com>
Date: Sun, 8 Jan 2006 12:52:56 -0800
From: Mark Knecht <markknecht@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>
Subject: 2.6.15-rt2 - repeatable xrun - no good data in trace
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
   I did run across a way that I can create a repeatable xrun on my
AMD64 machine by burning a CD in k3b while Jack is running.
Unfortunately I do not see any good trace data in dmesg when I do it.
Here's what I see in Jack. I burning the same iso file 3 times to make
sure it was repeatable:

09:35:33.113 Server configuration saved to "/home/mark/.jackdrc".
09:35:33.113 Statistics reset.
09:35:33.557 Client activated.
09:35:33.559 Audio connection change.
09:35:33.563 Audio connection graph change.
09:35:33.762 Audio connection change.
09:35:33.762 Audio connection graph change.
09:35:33.964 Audio connection change.
09:35:36.037 Audio connection graph change.
11:50:22.792 XRUN callback (1).
delay of 14728.000 usecs exceeds estimated spare time of 1360.000; restart ...
delay of 3184.000 usecs exceeds estimated spare time of 1360.000; restart ...
11:50:22.983 XRUN callback (2).
**** alsa_pcm: xrun of at least 0.039 msecs
delay of 2908.000 usecs exceeds estimated spare time of 1360.000; restart ...
11:50:23.407 XRUN callback (2 skipped).
11:51:13.405 XRUN callback (5).
**** alsa_pcm: xrun of at least 0.027 msecs
12:28:58.864 XRUN callback (6).
delay of 2893.000 usecs exceeds estimated spare time of 1363.000; restart ...
**** alsa_pcm: xrun of at least 0.044 msecs
delay of 9293.000 usecs exceeds estimated spare time of 1363.000; restart ...
12:28:59.265 XRUN callback (2 skipped).
12:39:26.418 XRUN callback (9).
delay of 11516.000 usecs exceeds estimated spare time of 1388.000; restart ...
delay of 8877.000 usecs exceeds estimated spare time of 1388.000; restart ...
12:39:28.373 XRUN callback (1 skipped).
12:40:18.427 XRUN callback (11).
**** alsa_pcm: xrun of at least 0.023 msecs


In dmesg I'm getting only this:

(      dcopserver-8733 |#0): new 10 us maximum-latency critical section.
 => started at timestamp 12171220117: <preempt_schedule+0x53/0xb0>
 =>   ended at timestamp 12171220128: <schedule_tail+0xaa/0x110>

Call Trace:<ffffffff8014d79f>{check_critical_timing+479}
<ffffffff8014db78>{sub_ preempt_count_ti+88}
       <ffffffff8012c3a3>{schedule_tail+67}
<ffffffff8012c40a>{schedule_tail+170 }
       <ffffffff8010db79>{ret_from_fork+5}
 =>   dump-end timestamp 12171220195

(               X-7777 |#0): new 13 us maximum-latency critical section.
 => started at timestamp 12183810145: <__schedule+0xb8/0x596>
 =>   ended at timestamp 12183810158: <thread_return+0xb5/0x11a>

Call Trace:<ffffffff8014d79f>{check_critical_timing+479}
<ffffffff803c79e0>{unix _poll+0}
       <ffffffff8014db78>{sub_preempt_count_ti+88}
<ffffffff80403c0c>{thread_ret urn+70}
       <ffffffff80403c7b>{thread_return+181} <ffffffff80403de5>{schedule+261}
       <ffffffff804048ed>{schedule_timeout+141}
<ffffffff8013b2e0>{process_timeo ut+0}
       <ffffffff8018d237>{do_select+967} <ffffffff8018cd80>{__pollwait+0}
       <ffffffff8018d57d>{sys_select+749} <ffffffff8010dc86>{system_call+126}

 =>   dump-end timestamp 12183810266

Jack is 100.7 from portage. k3b is 0.12.10 from portage. The DVD/CDRW
drive is EIDE based.

Ideas?

- Mark
