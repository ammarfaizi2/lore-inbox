Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264699AbTAJPDs>; Fri, 10 Jan 2003 10:03:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264975AbTAJPDs>; Fri, 10 Jan 2003 10:03:48 -0500
Received: from holomorphy.com ([66.224.33.161]:51865 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S264699AbTAJPDr>;
	Fri, 10 Jan 2003 10:03:47 -0500
Date: Fri, 10 Jan 2003 07:12:23 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Erich Focht <efocht@ess.nec.de>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Robert Love <rml@tech9.net>
Subject: Re: small migration thread fix
Message-ID: <20030110151223.GT23814@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Erich Focht <efocht@ess.nec.de>, Ingo Molnar <mingo@elte.hu>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Robert Love <rml@tech9.net>
References: <200301101346.03653.efocht@ess.nec.de> <20030110131100.GS23814@holomorphy.com> <200301101529.33302.efocht@ess.nec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301101529.33302.efocht@ess.nec.de>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 January 2003 14:11, William Lee Irwin III wrote:
>> I'm not mingo, but I can say this looks sane. My only question is
>> whether there are more codepaths that need this kind of check, for
>> instance, what happens if someone does set_cpus_allowed() to a cpumask
>> with !(task->cpumask & cpu_online_map) ?

On Fri, Jan 10, 2003 at 03:29:33PM +0100, Erich Focht wrote:
> The piece of code below was intended for that. I agree with Rusty's
> comment, BUG() is too strong for that case. 
> #if 0 /* FIXME: Grab cpu_lock, return error on this case. --RR */
> 	new_mask &= cpu_online_map;
> 	if (!new_mask)
> 		BUG();
> #endif
> Anyhow, changing the new_mask in this way is BAD, because the masks
> are inherited. So when more CPUs come online, they remain excluded
> from the mask of the process and it's children.
> The fix suggested in the comments still has to be done...

I don't have much to add but another ack and a "hmm, maybe something
could be done". My prior comments stand. I'd be very much obliged if
you provide a fix for the set_cpus_allowed() issue. I very much rely
upon you now to provide scheduler fixes and optimizations for large
scale and/or NUMA machines these days.


Thanks,
Bill
