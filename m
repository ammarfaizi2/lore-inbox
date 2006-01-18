Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030265AbWARHEa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030265AbWARHEa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 02:04:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030263AbWARHEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 02:04:30 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:58077 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030265AbWARHE3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 02:04:29 -0500
Date: Wed, 18 Jan 2006 08:04:36 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: michael@ellerman.id.au, serue@us.ibm.com, linuxppc64-dev@ozlabs.org,
       paulus@au1.ibm.com, anton@au1.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-mm4 failure on power5
Message-ID: <20060118070436.GA24378@elte.hu>
References: <20060116063530.GB23399@sergelap.austin.ibm.com> <200601180032.46867.michael@ellerman.id.au> <20060117140050.GA13188@elte.hu> <200601181119.39872.michael@ellerman.id.au> <20060118033239.GA621@cs.umn.edu> <20060118063732.GA21003@elte.hu> <20060117225304.4b6dd045.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060117225304.4b6dd045.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> > [ if this indeed is the case then i'll add irqs_off() checks to
> >   DEBUG_MUTEXES=y, to ensure that the mutex APIs are never called with 
> >   interrupts disabled. ]
> 
> Yes, I suppose so.  But we're already calling might_sleep(), and 
> might_sleep() checks for that.  Perhaps the might_sleep() check is 
> being defeated by the nasty system_running check.

ah ... indeed.

> There's a sad story behind that system_running check in might_sleep().  
> Because the kernel early boot is running in an in_atomic() state, a 
> great number of bogus might_sleep() warnings come out because of 
> various code doing potentially-sleepy things.  I ended up adding the 
> system_running test, with the changelog "OK, I give up.  Kill all the 
> might_sleep warnings from the early boot process." Undoing that and 
> fixing up the fallout would be a lot of nasty work.

OTOH, x86 was just fine last i checked, and it has alot more complex 
bootup code than any of the other architectures (due to the sheer number 
of x86 variants).

	Ingo
