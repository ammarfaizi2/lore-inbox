Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261888AbVANXZZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261888AbVANXZZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 18:25:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261990AbVANXZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 18:25:24 -0500
Received: from mail8.fw-bc.sony.com ([160.33.98.75]:42391 "EHLO
	mail8.fw-bc.sony.com") by vger.kernel.org with ESMTP
	id S261888AbVANXWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 18:22:41 -0500
Message-ID: <41E8543A.8050304@am.sony.com>
Date: Fri, 14 Jan 2005 15:22:34 -0800
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: tglx@linutronix.de
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.11-rc1-mm1
References: <20050114002352.5a038710.akpm@osdl.org> <1105742791.13265.3.camel@tglx.tec.linutronix.de>
In-Reply-To: <1105742791.13265.3.camel@tglx.tec.linutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner wrote:
> On Fri, 2005-01-14 at 00:23 -0800, Andrew Morton wrote:
> 
>>- Added the Linux Trace Toolkit (and hence relayfs).  Mainly because I
>>  haven't yet taken as close a look at LTT as I should have.  Probably neither
>>  have you.
> 
> I have. Maybe you should have. I really don't see a good argument to
> include this code. 

[ Lots of excellent criticisms omitted.]

I don't want to be argumentative, but possibly (to answer your last
question first), there are twofold reasons to put this in -mm:
 - there's no tracing infrastructure in the kernel now (except for
 kprobes - which provides hooks for creating tracepoints dynamically,
 but not 1) supporting infrastructure for timestamping, managing event
 data, etc., and 2) a static list of generally useful tracepoints.
 - to generate this discussion.

> 
> I did a short test on a 300MHz PIII box and the maximum time spent in
> the log path (interrupts disabled during measurement) is about 30us.
> Extrapolated to a 74MHz ARM SoC it will sum up to ~ 90-120us, what makes
> it purely useless. 

I've used it for various tasks, and I know others who have.  I wouldn't
recommend it in its present form for deep scheduling tweaks or debugging
kernel race conditions (which it is more likely to mask than
it is to find), but inapplicability there hardly makes it worthless for
other things.

> 
> Summary:
> 
> 1. The code is not doing what it claims to do.
I'm guessing the sense of this is in the micro-claims which are implied
(e.g. runs lockless and therefore avoids cache thrashing), rather than
the high-level claim of providing useful information in some situations.
It clearly does the latter.  At least is has for me.

> 2. The code adds unnecessary overhead
I agree it could be improved.  The threshold for "unnecessary" varies
by task.

> 3. It's not useful for low speed systems.
I've used it on low speed systems.

> Question:
> Why is the code included ?	
See above.

By the way, don't think that your comments are not appreciated.
I'm not particularly glued to any specific part of the implementation.
I'm excited to see tracing discussed here, if only to avoid
duplicate efforts and point out danger areas, for multiple tracing
projects that I am aware of.

=============================
Tim Bird
Architecture Group Chair, CE Linux Forum
Senior Staff Engineer, Sony Electronics
=============================
