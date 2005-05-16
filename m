Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261831AbVEPTdX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261831AbVEPTdX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 15:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261826AbVEPTdX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 15:33:23 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:28570 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261832AbVEPTT7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 15:19:59 -0400
To: Andi Kleen <ak@muc.de>
Cc: Andy Isaacson <adi@hexapodia.org>, "Richard F. Rebel" <rrebel@whenu.com>,
       Gabor MICSKO <gmicsko@szintezis.hu>, linux-kernel@vger.kernel.org,
       mpm@selenic.com, tytso@mit.edu
Subject: Re: Hyper-Threading Vulnerability
References: <1115963481.1723.3.camel@alderaan.trey.hu> <m164xnatpt.fsf@muc.de>
	<1116009483.4689.803.camel@rebel.corp.whenu.com>
	<20050513190549.GB47131@muc.de> <20050513212620.GA12522@hexapodia.org>
	<20050515094352.GB68736@muc.de>
	<m1oebbwsrf.fsf@ebiederm.dsl.xmission.com>
	<20050516110359.GA70871@muc.de>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 16 May 2005 13:14:23 -0600
In-Reply-To: <20050516110359.GA70871@muc.de>
Message-ID: <m1ekc7vv8w.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@muc.de> writes:

> > The only solution I have seen proposed so far that seems to work
> > is to not schedule untrusted processes simultaneously with 
> > the security code.  With the current API that sounds like
> > a root process killing off, or at least stopping all non-root
> > processes until the critical process has finished.
> 
> With virtualization and a hypervisor freely scheduling it is quite 
> impossible to guarantee this. Of course as always the signal 
> is quite noisy so it is unclear if it is exploitable in practical 
> settings. On virtualized environments you cannot use ps to see
> if a crypto process is running. 

Interesting.  I think that is a problem for the hypervisor maintainer.
Although that is about enough to convince me to request a
OS flag that says "please give me privacy" and later that can be passed
down to the hypervisor.  My gut feel is running under a hypervisor
is when things will at their most vulnerable.

Where this is a threat is when there will be a lot of RSA
key transactions.  At which point it is likely that the attacker
can reproduce enough of the setup to figure out the fine details.

I think discovering a crypto process will simply be a matter
finding a https sever.  As for getting the timing how about
initiating a https connection?  Getting rid of the noise will certainly
be a challenge but you will have multiple attempts.

> > And those same processors will have the same problem if the share
> > significant cpu resources.  Ideally the entire problem set
> > would fit in the cache and the cpu designers would allow cache
> > blocks to be locked but that is not currently the case.  So a shared
> > L3 cache with dual core processors will have the same problem.
> 
> At some point the signal gets noisy enough and the assumptions
> an attacker has to make too great for it being an useful attack.
> For me it is not even clear it is a real attack on native Linux, at 
> least the setup in the paper looked highly artifical and quite impractical. 
> e.g. I suppose it would be quite difficult to really synchronize
> to the beginning and end of the RSA encryptions on a server that
> does other things too.

Possibly.  But then buffer overflow attacks when you don't know the exact
stack layout are similarly difficult and ways have been found.  And if
you have multiple chances things get easier.  And if you are aiming
at something easier then brute forcing a private key even the littlest
bit is a help.

When people mmap pages we zero them for the same reason so that
we don't have unintentional information leaks.

I agree that for now because little is known this is a highly specialized
attack.  However the trend is now towards increasingly big SMP's.
That increases the number of resources that can be shared so the
possibility of a problem increases.  At the rate Intel's cpus are
going we may see throttling of one cpu core when the other one
generates too much heat, because it is busy doing something else cpu
intensive.  And other optimizations lead to much easier to imagine
vulnerabilities.

As for noise with the area cpu designers are getting into things
are becoming increasingly fine grained so information is leaking
at an increasingly fine level.  As the L2 cache issue has shown
that information starts to leak below the level an application
designer has control of.  At which point things get very difficult
to manage.  

Information leaks are more difficult than simply gaining root on
the box where you can simply take the information you want.  But
that means that is exactly where a locked down well administered
box will be vulnerable if a way is not found to avoid the problem.
I don't know what the consequences of having your private key
discovered are, but I have never heard a case where identity theft
was something pleasant to fix.

Eric
