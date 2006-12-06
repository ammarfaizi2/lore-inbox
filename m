Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936940AbWLFRoX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936940AbWLFRoX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 12:44:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936943AbWLFRoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 12:44:23 -0500
Received: from mail.suse.de ([195.135.220.2]:36858 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936940AbWLFRoW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 12:44:22 -0500
From: Andi Kleen <ak@suse.de>
To: john stultz <johnstul@us.ibm.com>
Subject: Re: PMTMR running too fast
Date: Wed, 6 Dec 2006 17:44:47 +0100
User-Agent: KMail/1.9.5
Cc: Ian Campbell <ijc@hellion.org.uk>, linux-kernel@vger.kernel.org
References: <1165153834.5499.40.camel@localhost.localdomain> <1165259962.6152.5.camel@localhost.localdomain>
In-Reply-To: <1165259962.6152.5.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200612061744.47249.ak@suse.de>
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> > Is there a specific reason the check was removed (I couldn't see on in
> > the archives) or was it simply overlooked? Without it I need to pass
> > clocksource=tsc to have 2.6.18 work correctly on an older K6 system with
> > an Aladdin chipset (will dig out the precise details if required). Would
> > a patch to reintroduce the check be acceptable or would some sort of
> > blacklist based solution be more acceptable?
> 
> If I recall correctly, it was pulled because there was some question as
> to if it was actually needed (x86_64 didn't need it) and it slows down
> the boot time (although not by much). 
> 
> I'm fine just re-adding it. Although if the number of affected systems
> are small we could just blacklist it (Ian, mind sending dmidecode
> output?).
> 
> Andi, your thoughts?

Doing a check at boot time is fine for me. Just I don't want the
"read pmtmr three times at runtime" code anywhere near x86-64

I don't think the boot time check needs DMI guarding

But BTW the check is not necessarily enough -- there is at least one
NF3 machine around where the PIT timer ticks at a wrong frequency.
Safer would be probably to calibrate against RTC which is afaik used
by Windows too (so it's likely to be ok) 

-Andi
