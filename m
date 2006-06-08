Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964793AbWFHIFL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964793AbWFHIFL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 04:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751291AbWFHIFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 04:05:10 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:46757 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751228AbWFHIFI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 04:05:08 -0400
Subject: Re: clocksource
From: john stultz <johnstul@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0606070005550.32445@scrub.home>
References: <20060604135011.decdc7c9.akpm@osdl.org>
	 <Pine.LNX.4.64.0606050141120.17704@scrub.home>
	 <1149538810.9226.29.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0606052226150.32445@scrub.home>
	 <1149622955.4266.84.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.64.0606070005550.32445@scrub.home>
Content-Type: text/plain
Date: Thu, 08 Jun 2006 01:05:03 -0700
Message-Id: <1149753904.2764.24.camel@leatherman>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-06-07 at 02:41 +0200, Roman Zippel wrote:
> On Tue, 6 Jun 2006, john stultz wrote:
> > > With large clock offsets the lookahead doesn't work correctly, basically 
> > > because it's already to late and it can cause overadjustment. Because of 
> > > this I do an extra lookahead in clocksource_bigadjust().
> > 
> > Do you have a hard example for this with numbers? I don't mean to be a
> > pain, but I don't see this right off.
> > 
> > With the current code in -mm I can run a test app that disables
> > interrupts for 2 seconds at a time over and over and I'm still keeping
> > synched w/ an NTP server within 30 microseconds.
> 
> You need a clock source which doesn't generate it's own interrupts, so 
> interrupts and clock updates can run asynchron. The key part above is 
> "large clock offsets". In my test program disable the extra lookahead and 
> run it with large offsets.

I'm not sure I'm following you here. Almost all clocksources on i386
(specifically, in the case above, I was using the apci_pm) don't
generate interrupts and run asynchronous from the timer interrupt
source. 

I did re-review your documentation, and while it does go over the mult
adjustment code in nice understandable terms, the "why" of this
additional look-ahead isn't quite obvious.

> This code gets only limited testing in -mm, it needs to run for weeks 
> or months, which I don't expect from the average -mm kernel. This makes 
> userspace simulations so damn important and if you don't do this, you're 
> playing a very risky game with a kernel which is supposed to be stable.

Agreed, simulation is nice. Thus, I've revived the old simulator which
builds using the existing code in -mm. Its a bit fast/dirty and isn't
exactly like your sim, but maybe you can take a look at it and send
patches to improve it?

You can find it at:
http://sr71.net/~jstultz/tod/simulator_C2.tar.bz2


I'm currently using it in testing my attempts to get your bigadjust code
working, so hopefully it will help there.

> > > For this I also I posted a userspace test program, so that I know how it 
> > > behaves, do you have something similiar for yours?
> > 
> > At your prodding awhile back I wrote a userspace simulator, but you
> > never commented on it.
> 
> It was very hard to get running at all and in the meantime you had updated 
> patches and the whole thing didn't work anymore. Sorry, that I didn't 
> comment on it more. 

Please let me know if you still have difficulty getting this new one
running.

thanks
-john

