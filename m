Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264704AbUGZAnN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264704AbUGZAnN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 20:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264723AbUGZAnN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 20:43:13 -0400
Received: from mail017.syd.optusnet.com.au ([211.29.132.168]:32927 "EHLO
	mail017.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S264704AbUGZAnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 20:43:11 -0400
References: <cone.1090801520.852584.20693.502@pc.kolivas.org> <20040725173652.274dcac6.akpm@osdl.org>
Message-ID: <cone.1090802581.972906.20693.502@pc.kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Autotune swappiness01
Date: Mon, 26 Jul 2004 10:43:01 +1000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:

> Con Kolivas <kernel@kolivas.org> wrote:
>>
>> Attached is a patch designed to improve the behaviour of the swappiness knob 
>> in 2.6.8-rc1-mm1. 
>> 
>> The current mechanism decides to reclaim mapped pages based on the 
>> combination of mapped_ratio/2 and the manual setting of swappiness currently 
>> tuned to 60. Biasing this mechanism to be proportional to the square root of 
>> mapped_ratio gives good overall performance improvement for desktop 
>> workloads without any noticable detriment to other loads.
> 
> OK...
> 
>> It has the effect 
>> of being fairly aggressive at avoiding loss of applications to swap under 
>> conditions of heavy or sustained file stress while allowing applications to 
>> swap out under what would be considered "application" memory stresses on a 
>> desktop.
> 
> But decreasing /proc/sys/vm/swappiness does that too?

Low memory boxes and ones that are heavily laden with applications find that 
ends up making things slow down trying to keep all applications in physical 
ram.

> 
>> It has no measurable effect on any known benchmarks.
> 
> So how are we to evaluate the desirability of the patch???

Get desktop users to report back their experiences which is what I have 
currently. Sorry we're in the realm of subjectivity again.

> Shouldn't mapped_bias be local to refill_inactive_zone()?

That is so a followup patch can use it elsewhere...

> Why is `swappiness' getting squared?  AFAICT this will simply make the
> swappiness control behave nonlinearly, which seems undesirable?

To parallel the nonlinear nature of the mapped bias effect. 

Con
