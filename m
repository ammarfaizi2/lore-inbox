Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932384AbVL0X0c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384AbVL0X0c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 18:26:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932386AbVL0X0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 18:26:32 -0500
Received: from gate.crashing.org ([63.228.1.57]:40668 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932384AbVL0X0c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 18:26:32 -0500
Subject: Re: Suspend to {mem,disk} broken in 2.6.15-rc6/rc7 on my T42
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jules Villard <jvillard@ens-lyon.fr>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Dave Airlie <airlied@linux.ie>
In-Reply-To: <20051227125504.GA11838@blatterie>
References: <20051226194527.GA3036@blatterie>
	 <Pine.LNX.4.64.0512261545460.14098@g5.osdl.org>
	 <1135641618.4780.3.camel@localhost.localdomain>
	 <20051227012053.GB9771@blatterie>
	 <1135646828.4780.10.camel@localhost.localdomain>
	 <20051227125504.GA11838@blatterie>
Content-Type: text/plain
Date: Wed, 28 Dec 2005 10:26:08 +1100
Message-Id: <1135725968.4780.60.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-12-27 at 13:55 +0100, Jules Villard wrote:

> The sad thing is that it looks like the crash occurs *before* entering
> the radeon_do_init_cp function, assuming it should enter it again when
> I switch back from a tty to X (I've put some printk's at the
> beginning of the function but didn't see them in dmesg although other
> things showed up), so I don't know where to put the printk's in order
> to get other figures...

I think the problem is actually a bug in the X server that we are
triggering indirectly. It's very difficult to fix things properly
because of various bugs that depends on each other side effects in X and
the DRM. I may have to back it all off for now and add some version test
to both DRM and X so that they only try to "do the right thing" once
they detect that the other hand has been fixed too... 

Let's see if the latest patch I posted that fixes things for you also
helps others though.

Ben.


