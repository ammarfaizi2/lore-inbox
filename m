Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751296AbVLIJQI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbVLIJQI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 04:16:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbVLIJQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 04:16:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:62639 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751179AbVLIJQG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 04:16:06 -0500
Date: Fri, 9 Dec 2005 10:16:05 +0100
From: Andi Kleen <ak@suse.de>
To: Jan Beulich <JBeulich@novell.com>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Rafael Wysocki <rjw@sisk.pl>, linux-kernel@vger.kernel.org,
       Discuss x86-64 <discuss@x86-64.org>
Subject: Re: [discuss] Re: 2.6.15-rc5-mm1 (x86_64-hpet-overflow.patch breaks resume from disk)
Message-ID: <20051209091605.GE11190@wotan.suse.de>
References: <20051204232153.258cd554.akpm@osdl.org> <200512070146.50221.rjw@sisk.pl> <200512080015.01444.rjw@sisk.pl> <43980058.76F0.0078.0@novell.com> <20051208224735.GV11190@wotan.suse.de> <439957A7.76F0.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <439957A7.76F0.0078.0@novell.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >The HPET patch seems to be generally unhappy. With it applied
> >I get lots of obviously wrong softlockup warnings from the
> >softlockup watchdog thread on a dual NForce4 system. So something
> >goes wrong with the timing there. The strange thing 
> >is that the system doesn't even have a HPET table so HPET code
> shouldn't
> >be executed - but it goes away when I revert the patch. Very
> >mysterious.
> 
> It doesn't only change the HPET code, the TSC code was suffering from
> overflow problems, too, which the patch also tries to address. I can't,
> however, see where or how it would cause softlockup reports. Do the
> printed call stacks provide any useful information?

No they occur in random places - often even in idle.

> 
> >Also I think vgettimeofday doesn't handle 64bit HPET correctly
> >yet. Also why does it not use hpet_readq? 
> 
> For the simple reason that there is no way to know whether the entire
> interconnect from CPU to HPET is (at least) 64 bits wide. At least
> theoretically implementations are permitted to use 32-bit components;
> the HPET spec specifically warns about that.


Doesn't that refer to the CPUs ? 


> 
> >I suspect the 64bit HPET patch needs some more cooking. I think
> >I will drop it for now.
> >
> >I would suggest you submit the cleanups in there separately
> >(without changing semantics yet) 
> >then it will be easier to test in the future too.
> 
> What cleanups are you referring to here?

Like the removal of the HPET.*DANGEROUS hack and some others.

-Andi
