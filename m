Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030272AbWHQUxw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030272AbWHQUxw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 16:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932265AbWHQUxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 16:53:52 -0400
Received: from 1wt.eu ([62.212.114.60]:20240 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S932216AbWHQUxv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 16:53:51 -0400
Date: Thu, 17 Aug 2006 22:43:07 +0200
From: Willy Tarreau <w@1wt.eu>
To: Adrian Bunk <bunk@stusta.de>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, Andreas Steinmetz <ast@domdv.de>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       mtosatti@redhat.com
Subject: Re: Linux 2.4.34-pre1
Message-ID: <20060817204307.GA17391@1wt.eu>
References: <20060816223633.GA3421@hera.kernel.org> <20060816235459.GM7813@stusta.de> <20060817051616.GB13878@1wt.eu> <1155797331.4494.17.camel@laptopd505.fenrus.org> <44E42A4C.4040100@domdv.de> <17636.11747.89849.992490@alkaid.it.uu.se> <20060817124839.GR7813@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060817124839.GR7813@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Thu, Aug 17, 2006 at 02:48:39PM +0200, Adrian Bunk wrote:
> On Thu, Aug 17, 2006 at 10:50:43AM +0200, Mikael Pettersson wrote:
> > Andreas Steinmetz writes:
> >  > Arjan van de Ven wrote:
> >  > > But maybe it's worth doing a user survey to find out what the users of
> >  > > 2.4 want... (and with that I mean users of the kernel.org 2.4 kernels,
> >  > > people who use enterprise distro kernels don't count for this since
> >  > > they'll not go to a newer released 2.4 anyway)
> >  > 
> >  > Currently I'm working with ARM based embedded systems. I prefer 2.4
> >  > kernels to 2.6 as they are smaller thus leaving more flash for jffs2.
> >  > Not speaking of the kernel a gcc 4.1.1 compile of code for a LPC2103
> >  > resulted in a clearly smaller binary as the same compile with gcc 3.4.
> >  > Thus I really would like to be able to use gcc 4.x with 2.4 kernels.
> >  > There are even kernel miscompiles with gcc 3.4 that might be fixed with
> >  > gcc 4 (one has to try).
> > 
> > I've done a fair amount of ARM user-space hacking recently, and the
> > number of bug fixes one has to apply to gcc-3.3 or gcc-3.4 to make it
> > even semi-correct on ARM is scary. Since these versions aren't supported
> > any more, being able to use newer, hopefully less buggy, and _supported_
> > gcc versions is clearly beneficial.
> > 
> > Of course, this is not an issue for x86 users.
> 
> The only valid point I see for still using kernel 2.4 is
> "never touch a running system".
> 
> But your ARM work seems to be new development.
> 
> If there are any problems preventing people from switching to kernel 2.6 
> when deploying new systems (e.g. increased kernel size), we should get 
> these problems reported and fixed in kernel 2.6.

No, you don't get it, we're not talking about the same people.
Please let me explain a little bit, I hope it will not be too boring.

There are people out there who design systems that must comply
with very high levels of availability. Currently, it's fairly
easy to achieve 99.999% with "outdated" versions. This is 5mn16s
total downtime per year. While you will occasionnaly find people
running DNS servers on 2.0, most people who need very high
availability run either 2.2 or 2.4. Why ?

Simply because we already know from collective experience that
these versions can achieve very long uptimes (while we don't know
this yet for a fresh new version which got 5700 patches in the
last 3 months), and because with the addition of very few patches,
you can make a bet on security : as long as newly discovered
vulnerabilities don't affect you or are covered by your additionnal
patches, you win. If you need to update and induce excessive
downtime, you lose and pay penalties.

In order to reduce the risk of downtime because of a newly discovered
vulnerability, those people will deploy the very latest fixes hoping
to push forward the next time they'll have to reboot. Generally, the
goal is not to touch those systems for 3-5 years. And it can
generally be achieved. I personnaly got half a dozen of systems to
exceed 1000 days of uptime under sustained moderate load using 2.4.18
based kernels. You see ? you rack the machine today and do not have
to come back to see it again for the next 3 years ! It might sound
stupid to some people, but there are places where one single person
remotely manages 100-300 different systems for various customers.
Simply do the math.

By this time, those people obviously know that they will have more
and more problems getting 2.4 to run reliably on fresh new hardware.

So while their hardware is running fine on remote sites, they have
time to chase bugs on 2.6 and try to validate a completely new
distro. But it takes time to restart from scratch with every new 2.6
release. And I think that your work on 2.6.16 is the best gift anyone
could send them.

I personally have high expectations and hope on what you're doing,
because as most of those people, I'm fairly depending on 2.4 now, and
I hope that 3 years from now, I will be deploying extremely reliable
2.6-based systems.

But before enough positive feedback gets collected, those people still
need to run 2.4 and even deploy fresh new systems on 2.4 right now.

Basically, my goal is to keep all those users trusting Linux (other
systems such as OpenBSD are very present in this area too). And your
goal is to progressively attract them towards 2.6 with strong arguments
in favor of 2.6 (and not against 2.4) that only them will judge relevant
based on their usage. And I can tell you that 2.4 being harder to build
than 2.6 is obviously not a relevant argument in favor of 2.6 for people
who apply more than 100 patches to their kernels.

> cu
> Adrian

Best regards,
Willy

