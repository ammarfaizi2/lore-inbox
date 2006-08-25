Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751290AbWHYPTP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbWHYPTP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 11:19:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbWHYPTP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 11:19:15 -0400
Received: from ns1.suse.de ([195.135.220.2]:23480 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751290AbWHYPTO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 11:19:14 -0400
From: Andi Kleen <ak@suse.de>
To: eranian@hpl.hp.com
Subject: Re: [PATCH 14/18] 2.6.17.9 perfmon2 patch for review: new i386 files
Date: Fri, 25 Aug 2006 17:18:47 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <200608230806.k7N8654c000504@frankl.hpl.hp.com> <200608251653.52898.ak@suse.de> <20060825150029.GJ5330@frankl.hpl.hp.com>
In-Reply-To: <20060825150029.GJ5330@frankl.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608251718.47698.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 25 August 2006 17:00, Stephane Eranian wrote:

> > > > BTW you might be able to simplify some of your code by exploiting
> > > > those. i386 currently doesn't have them, but i wouldn't see a problem
> > > > with adding them there too.
> > > >  
> > > I think I will drop the EXCL_IDLE feature given that most PMU stop
> > > counting when you go low-power. The feature does not quite do what
> > > we want because it totally exclude the idle from monitoring, yet
> > > the idle may be doing useful kernel work, such as fielding interrupts.
> > 
> > Ok fine. Anything that makes the code less complex is good.
> > Currently it is very big and hard to understand.
> > 
> > (actually at least one newer Intel system I saw seemed to continue counting
> > in idle, but that might have been a specific quirk)
> > 
> 
> Yes, that's my fear, we may get inconsistent behaviors across architectures.

It's already the case with idle=poll vs not.

> I think the only way to ensure some consistency would be to use the
> enter/exit_idle callbacks you mentioned assuming those would be available for
> all architectures.  With this, we could guarantee that we are not monitoring
> usless execution (including low-power mode) simply because we would explicitely
> stop monitoring on enter_idle() and restart monitoring on exit_idle().

Or better account for it using RDTSC because often people want their numbers to add up to 100%
when doing global accounting.  For other events than cycles=time it is not needed
because they don't happen by definition in idle.

This was one reason I added the hooks because it was a FAQ on oprofile

If you want them for i386 just send a patch to port them.
 
-andi
