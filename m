Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932211AbWAUOwY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211AbWAUOwY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 09:52:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbWAUOwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 09:52:24 -0500
Received: from smtp.bulldogdsl.com ([212.158.248.7]:52492 "EHLO
	mcr-smtp-001.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S1750808AbWAUOwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 09:52:23 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: Development tree, PLEASE?
Date: Sat, 21 Jan 2006 14:52:21 +0000
User-Agent: KMail/1.9
Cc: Michael Loftis <mloftis@wgops.com>, Jesper Juhl <jesper.juhl@gmail.com>,
       dtor_core@ameritech.net, James Courtier-Dutton <James@superbug.co.uk>,
       linux-kernel@vger.kernel.org
References: <D1A7010C56BB90C4FA73E6DD@dhcp-2-206.wgops.com> <0FA349BF620394796EB40A3A@d216-220-25-20.dynip.modwest.com> <Pine.LNX.4.61.0601211017400.21704@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0601211017400.21704@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601211452.22017.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 21 January 2006 09:22, Jan Engelhardt wrote:
> >> I'd say the kernel tries damn hard at maintaining backwards
> >> compatibility for userspace.
> >> It tries less hard, but still makes a pretty good effort, for internal
> >> APIs, but the real solution to the internal API churn is to get your
> >> code merged as it'll then get updated automagically whenever something
> >> changes - people who remove or change internals try very hard to also
> >> update all (in-tree) users of the old stuff - take a look at when I
> >> removed a small thing like verify_area() if you want an example.
> >
> > The only argument I have is one that won't fly at all here on LKML and
> > that's about all the corporate sponsors the LK has that are also doing
> > custom closed source modules that are only useful for their particular
> > hardware.
>
> It really does not fly. I run a "damn old" nvidia driver (1.0-4496)
> with a little portforward work on a 2.6.15. It is slowly ceasing to
> be perfect, but given that 4496 was originally only for 2.4, I'd say
> that's good news. (It was first portforwarded by sh.nu to 2.6.4 or so,
> until nvidia.com came up with 2.6 support on their own. I then took
> the sh.nu port and pf'ed it on my own, and until now, the only things
> that make slight gcc warnings are CONFIG_PM_LEGACY and the
> 4-level-pagetable stuff. I'd say the API is stable long enough!)

Myself and Christian Zander were the original authors of the port to 2.6, well 
before 2.6.0 was released. I think it's wrong to claim that the API changes 
between 2.4 and 2.6 were trivial or limited, we made a significant number of 
changes to the driver in almost every subsystem -- memory management, AGP 
handling, devfs support, module support, bh versus tasklets, etc..

Also if you look even today at Makefile.kbuild, there's quite a significant 
amount of work required to get it work with both 2.4 and 2.6 (the 2.6 code is 
obviously simpler). To top it off, supporting these "vendor kernels" 
mentioned in this thread also requires many pre-compilation checks.

I'm of the opinion that the kernel API should not be stable, but let's please 
not pretend that it is. That simply is not the case. For vendors, maintaining 
support for literally years of kernels is a challenge.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
