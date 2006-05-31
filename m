Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964774AbWEaGKH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964774AbWEaGKH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 02:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964780AbWEaGKG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 02:10:06 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:42768 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S964774AbWEaGKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 02:10:05 -0400
Date: Wed, 31 May 2006 07:54:38 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: marcelo@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Ayaz Abdulla <aabdulla@nvidia.com>
Subject: Re: [PATCH-2.4] forcedeth update to 0.50
Message-ID: <20060531055438.GA9142@w.ods.org>
References: <20060530220319.GA6945@w.ods.org> <447D2EA8.8020001@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <447D2EA8.8020001@colorfullife.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2006 at 07:50:32AM +0200, Manfred Spraul wrote:
> Hi Willy,
> 
> Willy Tarreau wrote:
> 
> >I started from the latest backport you sent in september (0.42) and
> >incrementally applied 2.6 updates. I stopped at 0.50 which provides
> >VLAN support, because after this one, there are some 2.4-incompatible
> >changes (64bit consistent memory allocation for rings, and MSI/MSIX
> >support).
> >
> > 
> >
> I agree, 2.4 needs a backport. Either a full backport as you did, or a 
> minimal one-liner fix.
> Right now, the driver is not usable due to an incorrect initialization.
> Or to be more accurate:
>    # modprobe
>    # ifup
> works.
> But
>    # modprobe
>    # ifup
>    # ifdown
>    # ifup
> causes a misconfiguration, and the nic hangs hard after a few MB. And 
> recent distros do the equivalent of ifup/ifdown/ifup somewhere in the 
> initialization.

That's what I read in one of the changelogs, but I'm not sure at all that
it's what happened, because I had the problem after an ifup only. What I
was doing with this box was pure performance tests which drew me to compare
the broadcom and nforce performance. My tests measured 3 creteria :

  - number of HTTP/1.0 hits/s
  - maximum data rate
  - maximum packets/s

on tg3, I got around 45 khits/s, 949 Mbps (TCP, =1.0 Gbps on wire) and
1.05 Mpps receive (I want to build a high speed load-balancer and a sniffer).
This was stable.

On the nforce, I tried with the hits/s first because it's a good indication
of hardware-based and driver-based optimizations. It reached 18 khits/s with
a lot of difficulty and the machine was stuck at 100% of one CPU. But it ran
for a few minutes like this. Then I tried data rate (which is the same test
with 1MB objects), and it failed after about 2 seconds and few megabytes (or
hundreds of megabytes) transferred.

I had to reboot to get it to work again. And I'm fairly sure that I did not
do down/up this time as well, but the test came to the same end.

That's why I'm not sure at all that the one-liner will be enough.

Moreover, after the update, I reached the same performance as with the
broadcom, with a slight improvement on packet reception (1.09 Mpps), and
low CPU usage (15%). So basically, the upgrade rendered the driver from
barely usable for SSH to very performant.

> Marcelo: Do you need a one-liner, or could you apply a large backport 
> patch?

I would really vote for the full backport, and I can break it into pieces
if needed (I have them at hand, just have to re-inject the changelogs).
However, I have separate changes from 0.42 to 0.50, because I started
with your 0.30-0.42 backport patch.

I have this machine till the end of the week, so I can perform other tests
if you're interested in trying specific things.

> --
>    Manfred

Cheers,
Willy

