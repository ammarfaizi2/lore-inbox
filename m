Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750798AbVKHEQs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbVKHEQs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 23:16:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbVKHEQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 23:16:48 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:56282 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750798AbVKHEQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 23:16:48 -0500
Subject: Re: CLOCK_REALTIME_RES and nanosecond resolution
From: Steven Rostedt <rostedt@goodmis.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1131418511.4652.88.camel@gaston>
References: <1131418511.4652.88.camel@gaston>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Mon, 07 Nov 2005 23:16:42 -0500
Message-Id: <1131423402.14381.166.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-08 at 13:55 +1100, Benjamin Herrenschmidt wrote:
> Hi !
> 
> I noticed that we set
> 
> #define CLOCK_REALTIME_RES TICK_NSEC  /* In nano seconds. */
> 
> Unconditionally in kernel/posix-timer.c
> 
> Doesn't that mean that we'll advertise to userland (via clock_getres) a
> resolution that is basically HZ ? We do get at lenght to get more
> precise (up to ns) resolution in practice on many architectures but we
> don't expose that to userland at all. Is this normal ?

Yes.

Until ktimers/high-res or another variant gets incorporated into the
kernel, the only resolution you will get for user applications is HZ.
So even though we may have timers that are much faster than HZ (which
there are a lot of them), the kernel only will work with timers on a
jiffy basis.

On a 2.6.13  I get a response of 0.004000250 seconds from clock_getres
with a HZ of 250.

On 2.6.14-rc5-kthrt7 (Thomas Gleixner's ktimers+high-res) I get from
clock_getres: 0.000001000 seconds. And this seems to be accurate.

-- Steve


