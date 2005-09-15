Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965153AbVIOGug@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965153AbVIOGug (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 02:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932586AbVIOGuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 02:50:35 -0400
Received: from rrzmta2.rz.uni-regensburg.de ([132.199.1.17]:3564 "EHLO
	rrzmta2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id S932527AbVIOGue (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 02:50:34 -0400
From: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: john stultz <johnstul@us.ibm.com>
Date: Thu, 15 Sep 2005 08:49:21 +0200
MIME-Version: 1.0
Subject: Re: NTP leap second question
Cc: lkml <linux-kernel@vger.kernel.org>, yoshfuji@linux-ipv6.org,
       Roman Zippel <zippel@linux-m68k.org>, joe-lkml@rameria.de
Message-ID: <43293591.19922.2890E4@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
In-reply-to: <1126724052.3455.80.camel@cog.beaverton.ibm.com>
References: <43286E4B.1070809@mvista.com>
X-mailer: Pegasus Mail for Windows (4.30 public beta 1)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.26/Sophos-P=3.95.0+V=3.95+U=2.07.102+R=04 July 2005+T=108170@20050915.063549Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 Sep 2005 at 11:54, john stultz wrote:

> On Wed, 2005-09-14 at 11:39 -0700, George Anzinger wrote:
> > It appears that a leap second is scheduled.  One of our customers is 
> > concerened about his application around this.  Could one of you NTP 
> > wizards help me to understand NTP a bit better.
> 
> First: I'm not an NTP wizard by any means, but I'll see if I can't help.
> 
> > First, I wonder if we suppressed the leap second insert and time then 
> > became out of sync by a second, would NTP "creap" the time back in sync 
> > or would the one second out of sync cause it to quit?
> 
> The ntpd's slew-bound is .125s I believe, so a second offset would cause
> ntpd to adjust the time using stime()/settimeofday(). You could run ntpd
> with the -x option which forces it to always slew the clock. This
> however could cause the initial sync to take quite some time.
> 
> 
> > Assuming NTP would do the "creap" thing, is there a way to tell NTP not 
> > to insert the leap second?
> 
> If I recall, leapsecond implementations are a pretty contentious issue.
> Some folks have suggested having the kernels note the leapsecond and
> slew the clock internally. This sounds nicer then just adding or

No! Never slew a leap second: It will take too long! It's all over after one 
second. If you slew, you time will be incorrect for an extended time.

Ulrich


> removing a second, but I do not know how that would affect synchronizing
> between a number of systems. So I'll defer the larger discussion to the
> real NTP wizards.
> 


