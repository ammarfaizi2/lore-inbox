Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267783AbUGaIlp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267783AbUGaIlp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 04:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267876AbUGaIlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 04:41:45 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:42503 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S267783AbUGaIkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 04:40:52 -0400
Date: Sat, 31 Jul 2004 10:33:08 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: greearb@candelatech.com, akpm@osdl.org, alan@redhat.com,
       jgarzik@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: PATCH: VLAN support for 3c59x/3c90x
Message-ID: <20040731083308.GA24496@alpha.home.local>
References: <20040730121004.GA21305@alpha.home.local> <E1BqkzY-0003mK-00@gondolin.me.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1BqkzY-0003mK-00@gondolin.me.apana.org.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Herbert,

On Sat, Jul 31, 2004 at 01:57:04PM +1000, Herbert Xu wrote:
> Willy Tarreau <willy@w.ods.org> wrote:
> > no, because the driver has no change_mtu() function, so it uses the generic
> > one, eth_change_mtu(), which is bound to 1500.
> 
> What is preventing you from implementing a change_mtu() function?

well, now I see where you want to bring me :-)

So several reasons :
  - the change_mtu() function might be called at any time after driver
    initialization. I don't know at all if there are things to do to
    "lock" the hardware during such changes, as well as I don't know
    what parts of the code I will need to extract to change the hard
    MTU. The initial MTU is really different since it's used to
    initialize hardware registers. The generic change_mtu() function
    only plays with dev->mtu and not hardware since it never goes
    above standard size. I could try, but if it works I would offer
    no warranties for other hardware.

  - I really, really, really... lack time. I would do this during
    my few hours nighty sleep and I wouldn't want to use the resulting
    code :-)

  - many (all ?) other drivers already have an MTU parameter, and many
    of them don't have a problem with using generic change_mtu(). So why
    would this one in particular need such a change ? (and please don't
    tell me that *I* will have to do this for all others :-))

As previously said, I can take a few minutes to add the 'MODULE_PARM'
line, it's not much more than replying to this mail. At least it will
be a good start.

Cheers,
Willy

