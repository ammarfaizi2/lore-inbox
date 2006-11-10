Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946187AbWKJJaG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946187AbWKJJaG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 04:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946209AbWKJJaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 04:30:05 -0500
Received: from mx1.suse.de ([195.135.220.2]:7140 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1946187AbWKJJaD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 04:30:03 -0500
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 13/19] GTOD: Mark TSC unusable for highres timers
Date: Fri, 10 Nov 2006 10:29:59 +0100
User-Agent: KMail/1.9.5
Cc: Ingo Molnar <mingo@elte.hu>, tglx@linutronix.de,
       john stultz <johnstul@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
       Len Brown <lenb@kernel.org>, Arjan van de Ven <arjan@infradead.org>,
       Roman Zippel <zippel@linux-m68k.org>
References: <20061109233030.915859000@cruncher.tec.linutronix.de> <20061110085728.GA14620@elte.hu> <20061110011336.008840cf.akpm@osdl.org>
In-Reply-To: <20061110011336.008840cf.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611101029.59251.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> But that's different.
> 
> We're limping along in a semi-OK fashion with the TSC.  But now Thomas is
> proposing that we effectively kill it off for all x86 because of hrtimers.

I'm totally against that.
 
> And afaict the reason for that is that we're using jiffies to determine if
> the TSC has gone bad, and that test is getting false positives.


The i386 clocksource had always trouble with that. e.g.  I have a box
where the TSC works perfectly fine on a 64bit kernel, but since the new i386
clocksource code is in it always insists on disabling it shortly after boot.
My guess is that some of the checks in there are just broken and need
to be fixed.



> 
> > We should wait until CPU makers get their act together and implement a 
> > TSC variant that is /architecturally promised/ to have constant 
> > frequency (system bus frequency or whatever) and which never stops.
> > 
> 
> That'll hurt the big machines rather a lot, won't it?

It's unrealistic and short term it will cause extreme pain in many workloads
which are gettimeofday intensive (networking, databases etc.) 

-Andi
