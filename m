Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310585AbSCGXUb>; Thu, 7 Mar 2002 18:20:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310587AbSCGXUW>; Thu, 7 Mar 2002 18:20:22 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:62960
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S310585AbSCGXUM>; Thu, 7 Mar 2002 18:20:12 -0500
Date: Thu, 7 Mar 2002 15:21:05 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Robert Love <rml@tech9.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] preempt-kernel on 2.4.19-pre2-ac2 bugfix
Message-ID: <20020307232105.GD28141@matchmail.com>
Mail-Followup-To: Robert Love <rml@tech9.net>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <1015287791.882.25.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1015287791.882.25.camel@phantasy>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2002 at 07:23:10PM -0500, Robert Love wrote:
> The same schedule_tail bug affecting 2.5 affects 2.4 with O(1).  I.e.,
> 2.4.19-pre2-ac2.
> 
> In recent O(1) scheduler releases, an optimization was made that removed
> schedule_tail from UP kernels.  This causes the initial preempt_count of
> a new task, which starts at 1, to never decrement to zero and thus never
> become preemptible.  CONFIG_PREEMPT requires schedule_tail, too.
> 
> Users of 2.4+O(1)+preempt (i.e. -ac) should use this patch:
> 
> 	http://www.kernel.org/pub/linux/kernel/people/rml/preempt-kernel/v2.4/preempt-kernel-rml-2.4.19-pre2-ac2-2.patch
> 

I'm using 2.4.19-pre2-ac2-prmpt which is only patched with:
preempt-kernel-rml-2.4.19-pre2-ac2-3

And it looks like the VM accounting has been messed up.

        total:    used:    free:  shared: buffers:  cached:
Mem:  129662976 99065856 30597120        0  5013504 69664768
Swap: 500056064 97660928 402395136
MemTotal:       126624 kB
MemFree:         29880 kB
MemShared:           0 kB
Buffers:          4896 kB
Cached:          33188 kB
SwapCached:      34844 kB
Active:          62536 kB
Inact_dirty:     20328 kB
Inact_clean:       876 kB
Inact_target:    16748 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       126624 kB
LowFree:         29880 kB
SwapTotal:      488336 kB
SwapFree:       392964 kB
Committed AS:   366712 kB

As you can see, it says I'm using 366MB (roughly) of ram, but I'm only about
95mb into swap with 128mb of ram.

Alan, do you want me to try without preempt, or do you already have any
other reports like this?

The kernel is compiled smp, but this machine is UP.  I can post .config and
other info if needed just ask.

Mike
