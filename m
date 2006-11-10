Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946123AbWKJJOl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946123AbWKJJOl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 04:14:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946124AbWKJJOl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 04:14:41 -0500
Received: from smtp.osdl.org ([65.172.181.4]:19170 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1946118AbWKJJOj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 04:14:39 -0500
Date: Fri, 10 Nov 2006 01:13:36 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: tglx@linutronix.de, Andi Kleen <ak@suse.de>,
       john stultz <johnstul@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
       Len Brown <lenb@kernel.org>, Arjan van de Ven <arjan@infradead.org>,
       Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [patch 13/19] GTOD: Mark TSC unusable for highres timers
Message-Id: <20061110011336.008840cf.akpm@osdl.org>
In-Reply-To: <20061110085728.GA14620@elte.hu>
References: <20061109233030.915859000@cruncher.tec.linutronix.de>
	<20061109233035.569684000@cruncher.tec.linutronix.de>
	<1163121045.836.69.camel@localhost>
	<200611100610.13957.ak@suse.de>
	<1163146206.8335.183.camel@localhost.localdomain>
	<20061110005020.4538e095.akpm@osdl.org>
	<20061110085728.GA14620@elte.hu>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Nov 2006 09:57:28 +0100
Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Andrew Morton <akpm@osdl.org> wrote:
> 
> > If so, could that function use the PIT/pmtimer/etc for working out if 
> > the TSC is bust, rather than directly using jiffies?
> 
> there's no realiable way to figure out the TSC is bust: some CPUs have a 
> slight 'skew' between cores for example. On some systems the TSC might 
> skew between sockets. A CPU might break its TSC only once some 
> powersaving mode has been activated - which might be long after bootup. 
> The whole TSC business is a nightmare and cannot be supported reliably. 
> AFAIK Windows doesnt use it, so it's a continuous minefield for new 
> hardware to break.

But that's different.

We're limping along in a semi-OK fashion with the TSC.  But now Thomas is
proposing that we effectively kill it off for all x86 because of hrtimers.

And afaict the reason for that is that we're using jiffies to determine if
the TSC has gone bad, and that test is getting false positives.

> We should wait until CPU makers get their act together and implement a 
> TSC variant that is /architecturally promised/ to have constant 
> frequency (system bus frequency or whatever) and which never stops.
> 

That'll hurt the big machines rather a lot, won't it?
