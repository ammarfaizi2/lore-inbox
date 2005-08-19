Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751011AbVHSDKb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751011AbVHSDKb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 23:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751012AbVHSDKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 23:10:31 -0400
Received: from adsl-110-19.38-151.net24.it ([151.38.19.110]:17389 "HELO
	develer.com") by vger.kernel.org with SMTP id S1750999AbVHSDKa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 23:10:30 -0400
Message-ID: <43054D9A.7090509@develer.com>
Date: Fri, 19 Aug 2005 05:10:18 +0200
From: Bernardo Innocenti <bernie@develer.com>
User-Agent: Mozilla Thunderbird 1.0.6-4 (X11/20050815)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Joseph Fannin <jfannin@gmail.com>, lkml <linux-kernel@vger.kernel.org>,
       OpenLDAP-devel@OpenLDAP.org, Giovanni Bajo <rasky@develer.com>,
       Simone Zinanni <simone@develer.com>
Subject: Re: sched_yield() makes OpenLDAP slow
References: <4303DB48.8010902@develer.com> <20050818010703.GA13127@nineveh.rivenstone.net> <4303F967.6000404@yahoo.com.au>
In-Reply-To: <4303F967.6000404@yahoo.com.au>
X-Enigmail-Version: 0.91.0.0
OpenPGP: id=FC6A66CA;
	url=https://www.develer.com/~bernie/gpgkey.txt
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

> We class the SCHED_OTHER policy as having a single priority, which
> I believe is allowed (and even makes good sense, because dynamic
> and even nice priorities aren't really well defined).
> 
> That also makes our sched_yield() behaviour correct.
> 
> AFAIKS, sched_yield should only really be used by realtime
> applications that know exactly what they're doing.

I'm pretty sure this has already been discussed in the
past, but I fail to see why this new behavior of
sched_yield() would be more correct.

In the OpenLDAP bug discussion, one of the developers
considers this a Linux quirk needing a workaround, not
a real bug in OpenLDAP.

As I understand it, the old behavior was to push the
yielding process to the end of the queue for processes
with the same niceness.  This is somewhat closer to
the (vague) definition in the POSIX man pages:

 The sched_yield() function shall force the running
 thread to relinquish the processor until it again
 becomes the head of its thread list. It takes no arguments.

Pushing the process far behind in the queue, even after
niced CPU crunchers, appears a bit extreme.  It seems
most programs expect sched_yield() to only reschedule
the calling thread wrt its sibling threads, to be used
to implement do-it-yourself spinlocks and the like.

-- 
  // Bernardo Innocenti - Develer S.r.l., R&D dept.
\X/  http://www.develer.com/

