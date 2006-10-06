Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932363AbWJFO2J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932363AbWJFO2J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 10:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932364AbWJFO2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 10:28:09 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:2996 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932363AbWJFO2G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 10:28:06 -0400
From: Darren Hart <dvhltc@us.ibm.com>
To: Tommaso Cucinotta <cucinotta@sssup.it>,
       "lkml, " <linux-kernel@vger.kernel.org>
Subject: Re: In-kernel precise timing.
Date: Fri, 6 Oct 2006 07:27:58 -0700
User-Agent: KMail/1.9.1
References: <45259F9F.1050203@sssup.it>
In-Reply-To: <45259F9F.1050203@sssup.it>
Organization: IBM Linux Technology Center
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610060727.58376.dvhltc@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 October 2006 17:13, you wrote:
> Hi,
>
> I'd like to know what is the preferrable way,
> in a Linux kernel module, to get a notification
> at a time in the future so to avoid as much as
> possible unpredictable delays due to possible
> device driver interferences. Basically, I would
> like to use such a mechanism to preempt (also)
> real-time tasks for the purpose of temporally
> isolating them from among each other.
>
> Is there any prioritary mechanism for specifying
> kind of higher priority timers, to be served as
> soon as possible, vs. lower priority ones, that
> could be e.g. delayed to ksoftirqd and similar ?
> (referring to 2.6.17/18, currently using add_timer(),
> del_timer(), but AFAICS these primitives are more
> appropriate for "timeout" behaviours, rather than
> "precise timing" ones).

There is no notion of priority in the current timer system, although that idea 
has been tossed around a bit.  As far as an appropriate timer for events, as 
opposed to timeouts, consider using ktimers + hrtimers (both of which are 
included in the -rt patchset).  The are optimized for times that you expect 
to expire (as opposed to timeouts which usually don't) and can provide 
accuracy to the 10s of microseconds.

http://tglx.de/ktimers.html
http://tglx.de/hrtimers.html
http://people.redhat.com/mingo/realtime-preempt/

Regards,

-- 
Darren Hart
IBM Linux Technology Center
Realtime Linux Team
