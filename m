Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266473AbUJFCiJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266473AbUJFCiJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 22:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266366AbUJFCiI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 22:38:08 -0400
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:10936 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266748AbUJFCaw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 22:30:52 -0400
Message-ID: <416358D7.6080609@yahoo.com.au>
Date: Wed, 06 Oct 2004 12:30:47 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@novell.com>
CC: Jeff Garzik <jgarzik@pobox.com>, Roland Dreier <roland@topspin.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Preempt? (was Re: Cannot enable DMA on SATA drive	(SCSI-libsata,
 VIA SATA))
References: <4136E4660006E2F7@mail-7.tiscali.it>	 <41634236.1020602@pobox.com> <52is9or78f.fsf_-_@topspin.com>	 <4163465F.6070309@pobox.com> <41634A34.20500@yahoo.com.au>	 <41634CF3.5040807@pobox.com> <1097027575.5062.100.camel@localhost>	 <20041006015515.GA28536@havoc.gtf.org> <1097028459.5062.104.camel@localhost>
In-Reply-To: <1097028459.5062.104.camel@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> On Tue, 2004-10-05 at 21:55 -0400, Jeff Garzik wrote:
> 
> 
>>As opposed to fixing drivers???  Please fix the drivers and code first.
> 
> 
> No, definitely not, dude.  Fixes for anything--drivers include--is never
> superseded by anything else, even the eternal quest for "low latency." 
> 
> 
>>>sprinkling cond_resched() hacks all over the kernel.
>>
>>cond_resched() is not the only solution.
> 
> 
> Indeed.  Most other solutions (fixing algorithms, lowering lock hold
> time) have "automatic" benefits with kernel preemption, though, and that
> has been what I have always advocated.
> 

Well, but then without preempt, you *still* need to put cond_rescheds
in non-critical-section code. So cond_resched really does seem to be
the only solution (other than preempt).

I think this is why Ingo found he needed a check in might_sleep to get
really good latency (again, I could be wrong here as I haven't been
really following the progress of that work). But imagine when you
unwind *that* hack into the callers. Yuck.
