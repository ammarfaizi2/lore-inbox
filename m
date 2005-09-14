Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932311AbVINSyp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbVINSyp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 14:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932495AbVINSyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 14:54:45 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:22736 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932311AbVINSyo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 14:54:44 -0400
Subject: Re: NTP leap second question
From: john stultz <johnstul@us.ibm.com>
To: george@mvista.com
Cc: lkml <linux-kernel@vger.kernel.org>, yoshfuji@linux-ipv6.org,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>, joe-lkml@rameria.de
In-Reply-To: <43286E4B.1070809@mvista.com>
References: <1126720091.3455.56.camel@cog.beaverton.ibm.com>
	 <1126720398.3455.58.camel@cog.beaverton.ibm.com>
	 <43286E4B.1070809@mvista.com>
Content-Type: text/plain
Date: Wed, 14 Sep 2005 11:54:12 -0700
Message-Id: <1126724052.3455.80.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-09-14 at 11:39 -0700, George Anzinger wrote:
> It appears that a leap second is scheduled.  One of our customers is 
> concerened about his application around this.  Could one of you NTP 
> wizards help me to understand NTP a bit better.

First: I'm not an NTP wizard by any means, but I'll see if I can't help.

> First, I wonder if we suppressed the leap second insert and time then 
> became out of sync by a second, would NTP "creap" the time back in sync 
> or would the one second out of sync cause it to quit?

The ntpd's slew-bound is .125s I believe, so a second offset would cause
ntpd to adjust the time using stime()/settimeofday(). You could run ntpd
with the -x option which forces it to always slew the clock. This
however could cause the initial sync to take quite some time.


> Assuming NTP would do the "creap" thing, is there a way to tell NTP not 
> to insert the leap second?

If I recall, leapsecond implementations are a pretty contentious issue.
Some folks have suggested having the kernels note the leapsecond and
slew the clock internally. This sounds nicer then just adding or
removing a second, but I do not know how that would affect synchronizing
between a number of systems. So I'll defer the larger discussion to the
real NTP wizards.

