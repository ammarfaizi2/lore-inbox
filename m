Return-Path: <linux-kernel-owner+w=401wt.eu-S1751238AbWLOHPn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbWLOHPn (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 02:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751219AbWLOHPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 02:15:43 -0500
Received: from web59204.mail.re1.yahoo.com ([66.196.101.30]:48083 "HELO
	web59204.mail.re1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751238AbWLOHPm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 02:15:42 -0500
Message-ID: <20061215071541.35583.qmail@web59204.mail.re1.yahoo.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=Ug2p4CxhKMz475cqVK63U5IDZICY+fLqTCghWHxpDZPTDHVWIM17ZH6OI+zpT5AudgDJCfQEUsvqFxrmzLKHEvmeDu1amwBsHcEqPnWS1i9ksGB/0h/rIVKBcf6/EzdBC02oAE+5zP7NZq0m0Cj/fG5kdoLm8jVEMeqLn96gmAQ=;
X-YMail-OSG: gjsfStAVM1nn6gRxWfoYMJxfVXDASWh5B1Zo6yAD
Date: Thu, 14 Dec 2006 23:15:41 -0800 (PST)
From: tike64 <tike64@yahoo.com>
Subject: Re: realtime-preempt and arm
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <Pine.LNX.4.58.0612140928020.19074@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> wrote:
> So you got a big jitter using nanosleep???  If that's the case, could
> you post the times you got. I'll also boot a kernel with the latest
> -rt patch, without highres compiled, and see if I can reproduce the
> same on x86.

You're very kind! Here you go:

This is from "Linux uclibc 2.6.14.2 #12 PREEMPT" without -rt:

100 revs; min: 19888 max: 20386 avg: 20013
100 revs; min: 19724 max: 20296 avg: 20013
100 revs; min: 19920 max: 20322 avg: 20013
100 revs; min: 19840 max: 20323 avg: 20016
100 revs; min: 10276 max: 42789 avg: 21294
100 revs; min: 10466 max: 34080 avg: 21687
100 revs; min: 10249 max: 30594 avg: 21161
100 revs; min: 10962 max: 34421 avg: 21415
100 revs; min: 10437 max: 31338 avg: 20562
100 revs; min: 11660 max: 29751 avg: 21066
100 revs; min: 10457 max: 30612 avg: 21417
100 revs; min: 10270 max: 37828 avg: 21513

First four lines are with the system otherwise idle. Then I fired 'ls
-Rl /mnt/some/nfs/share' on a framebuffer console.

And the same on a "Linux uclibc 2.6.18-rt6 #19 PREEMPT":

100 revs; min: 19847 max: 20242 avg: 20014
100 revs; min: 19685 max: 20332 avg: 20014
100 revs; min: 19652 max: 20374 avg: 20014
100 revs; min: 19622 max: 20399 avg: 20012
100 revs; min: 19736 max: 26612 avg: 20074
100 revs; min: 19478 max: 21199 avg: 20021
100 revs; min: 19569 max: 21093 avg: 20022
100 revs; min: 19582 max: 20460 avg: 20017
100 revs; min: 19723 max: 20410 avg: 20016
100 revs; min: 19459 max: 24565 avg: 20056
100 revs; min: 19610 max: 24257 avg: 20053
100 revs; min: 19376 max: 26848 avg: 20079
100 revs; min: 19445 max: 26522 avg: 20077
100 revs; min: 19510 max: 22349 avg: 20034
100 revs; min: 19562 max: 20334 avg: 20017

The one to be blamed the most seems to be FB. 'ls ... > /dev/null'
leads to less than 2ms slips.

I'm supposed to make a 10ms control loop, so I could live with a couple
of ms jitter. 7ms is rather high and I think it tells about some
problem which makes one wonder if even higher occasional slips are
possible.

I made my test code visible if you want to take a look: www dot
riihineva dot no-ip dot org uphill public uphill test-rt.c

--

tike



 
____________________________________________________________________________________
Do you Yahoo!?
Everyone is raving about the all-new Yahoo! Mail beta.
http://new.mail.yahoo.com
