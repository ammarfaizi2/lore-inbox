Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263262AbTJUTXd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 15:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263273AbTJUTXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 15:23:33 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:31471 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S263262AbTJUTXb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 15:23:31 -0400
Message-ID: <1066764198.5424d9a4ec004@carlthompson.net>
X-Priority: 3 (Normal)
Date: Tue, 21 Oct 2003 12:23:18 -0700
From: Carl Thompson <cet@carlthompson.net>
To: dongili@supereva.it
Cc: linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk
Subject: Re: [PATCH] 3/3 Dynamic cpufreq governor and updates to ACPI
	P-state driver
References: <88056F38E9E48644A0F562A38C64FB60077914@scsmsx403.sc.intel.com>
	<1066725533.5237.3.camel@laptop.fenrus.com>
	<20031021095925.GB893@inferi.kami.home> <20031021101737.GA31352@wiggy.net>
	<20031021105234.GF893@inferi.kami.home>
In-Reply-To: <20031021105234.GF893@inferi.kami.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) 4.0-cvs
X-Originating-IP: 192.168.0.174
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I know Linus wrote this but...

> ...

> A quote from Peter Anvin:
>
>   "What is worse is that the interface is, in my opinion, fundamentally
>    broken for *ALL* CPUs.  It doesn't present a policy interface to the
>    kernel, instead it presents a frequency-setting interface and expect
>    the policy to be done in userspace.  The kernel is the only part of
> the
>    system which has sufficient information (idle times of all CPUs, for
>    example) to do a decent job managing the CPU frequency efficiently.
>    On Transmeta CPUs this policy should simply be passed down to CMS, of
>    course; on other CPUs the kernel needs to manage it."
>
> In other words: there is no valid way that a _user_ can set the policy
> right now: the user can set the frequency, but since any sane policy
> depends on how busy the CPU is, the user isn't even, the right person to
> _do_ that, since the user doesn't _know_.

But userspace _can_ know the idle statistics for each CPU.  It's easily read
from /proc/stat.

> Also note that policy is not just about how busy the CPU is, but also
> about how _hot_ the CPU is. Again, a user-mode application (that maybe
> polls the situation every minute or so), simply _cannot_ handle this
> situation. You need to have the ability to poll the CPU tens of times a
> second to react to heat events, and clearly user mode cannot do that
> without impacting performance in a big way.

Well, my "cpuspeed" daemon has been doing exactly this without problems for
the better part of a year on many laptops tested by me and others.  Polling
the CPU temperature every second or two seems quite sufficient to head off
any heat related problems (including on problematic systems like the Sony
Vaio FXA series).  It doesn't appear to necessary to poll faster on current
hardware even with severe load spikes.  (Obviously, hardware failures in
the cooling system are another matter but the CPUs internal protection
should handle that.)

My cpuspeed daemon uses a negligable amount of CPU so it doesn't seem like a
terrible solution...

(As mentioned previously, CPUs that change their own speed are a separate
issue.)

Carl Thompson

> ...


