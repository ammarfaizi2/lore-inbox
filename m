Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262625AbVG2PYD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262625AbVG2PYD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 11:24:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262619AbVG2PVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 11:21:55 -0400
Received: from dvhart.com ([64.146.134.43]:20666 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S262616AbVG2PVt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 11:21:49 -0400
Date: Fri, 29 Jul 2005 08:21:48 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, ebiederm@xmission.com
Subject: Re: 2.6.13-rc3-mm3
Message-ID: <197380000.1122650508@[10.10.2.4]>
In-Reply-To: <20050728230820.236cba84.akpm@osdl.org>
References: <20050728025840.0596b9cb.akpm@osdl.org><159600000.1122616708@[10.10.2.4]> <20050728230820.236cba84.akpm@osdl.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > - There's a pretty large x86_64 update here which naughty maintainer wants
>> >   in 2.6.13.  Extra testing, please.
>> 
>> Is still regressed as of 2.6.12 for me, at least. Crashes in TSC sync.
>> Talked to Andi about it at OLS, but then drank too much to remember the
>> conclusion ... however, it's still broken ;-)
>> 
>> Matrix is here (see left hand column).
>> 
>> http://test.kernel.org/
>> 
>> Example boot log is here:
>> 
>> http://test.kernel.org/9447/debug/console.log
> 
> Does Eric's recent fix fix it?
> 
> 
> From: Eric W. Biederman <ebiederm@xmission.com>
> 
> sync_tsc was using smp_call_function to ask the boot processor to report
> it's tsc value.  smp_call_function performs an IPI_send_allbutself which is
> a broadcast ipi.  There is a window during processor startup during which
> the target cpu has started and before it has initialized it's interrupt
> vectors so it can properly process an interrupt.  Receveing an interrupt
> during that window will triple fault the cpu and do other nasty things.

Wheeeeeeee! that does indeed seem to work. Nice job. 

> I believe this patch suffers from apicid versus logical cpu number
> confusion.  I copied the basic logic from smp_send_reschedule and I can't
> find where that translates from the logical cpuid to apicid.  So it isn't
> quite correct yet.  It should be close enough that it shouldn't be too hard
> to finish it up.
> 
> More bug fixes after I have slept but I figured I needed to get this
> one out for review.

Eric, when you have a final version, throw it over to me, and I'll give
that one a spin-test too ...

Thanks!

M.
