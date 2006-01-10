Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750778AbWAJGkR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbWAJGkR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 01:40:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbWAJGkR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 01:40:17 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:43478 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S1750778AbWAJGkQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 01:40:16 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: State of the Union: Wireless
Date: Tue, 10 Jan 2006 08:39:25 +0200
User-Agent: KMail/1.8.2
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       acx100-devel@lists.sourceforge.net
References: <20060106042218.GA18974@havoc.gtf.org>
In-Reply-To: <20060106042218.GA18974@havoc.gtf.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601100839.26052.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 06 January 2006 06:22, Jeff Garzik wrote:
> 
> 		State of the Union - Wireless
> 		      January 5, 2006

[ snip ]

> * Wireless drivers and the wireless stack need to be maintained IN-TREE
>   as a COLLECTIVE ENTITY, not piecemeal maintenance as its done now.
> 
> The whole point of working in-tree, the whole point of this open source
> thing is that everybody works on the same code, and the entire Internet
> is your test bed.  Quality improves the more people work together.
> The entire Linux kernel engineering process is focused on getting core
> kernel code out to distributions (then to end users) and power users.
> Out-of-tree code breaks that model, breaking the It Just Works(tm)
> theme applicable to other Linux-supported hardware.

Cool, so may I please know why acx driver is not included in the mainline?
In case it needs more work, well, (a) at least tell us what exactly
you want improved, and (b) why do you think that in-tree acx would not
be improved? It will get more visibility, maybe some people will
get interested and will send a patch or two to us...
 
> * Release early, release often.  Pushing from an external repository to
>   the official kernel tree every few months creates more problems
>   than it solves.  Out-of-tree drivers fail to take advantage of
>   recent kernel changes and coding practices, which leads to bugs and
>   incompatibilities.  Slow pushing leads to huge periodic updates,
>   which are awful for debugging, testing, and general use.

I want to avoid exactly this, and therefore want acx in mainline.

> * ALL wireless stacks need work.  It is currently fashionable to laud
>   DeviceScape and trash in-kernel ieee80211, but outside of the
>   cheerleading, BOTH have real technical issues that need addressing.
>   IOW, no matter what code is chosen, _somebody_ is on the hook for
>   a fair amount of work.  A switch is not without its costs.
> 
> * I would prefer that people patch the in-tree ieee80211 code,
>   probably in the direction of Jiri Benc's proposed ieee80211_device
>   direction.  I take patches from all parties, not just Intel.
> 
> * However, if the engineering reasons for switching to DeviceScape
>   or another wireless stack are powerful enough to overcome Linux's
>   "no big patches, evolve it" maxim, great!  But make sure to work
>   on converting drivers to this new stack.  The wireless drivers and
>   wireless stack should evolve in tandem.  Otherwise, drivers get
>   left behind, grow moldy, and Linux users suffer.

How are we going to find out which stack is best and which stack
we should concentrate our efforts on? In an absense of wifi maintainer,
maybe we should throw _all stacks_ (currently two) into the mainline,
and evolution will find the best one. Yes, it would be a bit ugly
at first, but I hope it will speed up evolution a lot.

Let current stack sit in include/net/ieee80211*.h and net/ieee80211/*,
add dcape one into include/net/wlan*.h and net/wlan/*
(s/wlan/dscape/ or whatever)

We can even give Devicescape folks blanket permissions to
maintain their stack in include/net/wlan*.h and net/wlan/*.
Maybe they can act as a wifi maintainer long term.

Existing drivers won't need to closely track every change
in dscape stack. If dscape will survive, old drivers can be
converted to it gradually. If not, just dike it out.

> * Feel free to submit radical changes -- wireless is yet young --
>   just make sure all drivers keep working from release to release.
> 
> * Long term, wireless should go from being a library of common code to a
>   "real" wireless stack, as shown in the template developed by David Miller:
>   http://kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.6/davem-p80211.tar.bz2
>   Zhu Yi @ Intel and Vladmir @ somewhere both independently did some
>   work in this area.
> 
> * Please CC wireless stack/driver discussions to netdev@vger.kernel.org
>   mailing list, rather than everybody hiding in their own little
>   corner.

[snip]

> So... there it is.  We suck.  There's hope.  No Luke Skywalker in sight.
> I hope we can avoid being slaves to fashion, by merging a rewrite, but
> that way be the way to go.
--
vda
