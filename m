Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261485AbTI3NoF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 09:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261489AbTI3NoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 09:44:05 -0400
Received: from sprocket.loran.com ([209.167.240.9]:20473 "EHLO
	willy.ottawa.loran.com") by vger.kernel.org with ESMTP
	id S261485AbTI3NoA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 09:44:00 -0400
Subject: Re: RFC: [2.6 patch] disallow modular IPv6
From: Dana Lacoste <dana.lacoste@peregrine.com>
To: "David S. Miller" <davem@redhat.com>
Cc: David Woodhouse <dwmw2@infradead.org>, netdev@oss.sgi.com,
       lksctp-developers@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20030930022410.08c5649c.davem@redhat.com>
References: <20030928225941.GW15338@fs.tum.de>
	 <20030928231842.GE1039@conectiva.com.br> <20030928232403.GX15338@fs.tum.de>
	 <20030929220916.19c9c90d.davem@redhat.com>
	 <1064903562.6154.160.camel@imladris.demon.co.uk>
	 <20030930000302.3e1bf8bb.davem@redhat.com>
	 <1064907572.21551.31.camel@hades.cambridge.redhat.com>
	 <20030930010855.095c2c35.davem@redhat.com>
	 <1064910398.21551.41.camel@hades.cambridge.redhat.com>
	 <20030930013025.697c786e.davem@redhat.com>
	 <1064911360.21551.49.camel@hades.cambridge.redhat.com>
	 <20030930015125.5de36d97.davem@redhat.com>
	 <1064913241.21551.69.camel@hades.cambridge.redhat.com>
	 <20030930022410.08c5649c.davem@redhat.com>
Content-Type: text/plain
Message-Id: <1064929494.98525.7.camel@dlacoste.ottawa.loran.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 30 Sep 2003 09:44:55 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-09-30 at 05:24, David S. Miller wrote:
> What this means is that it's required for the kernel image to be up to
> date before any modules can be built.  If we can check that in the
> build system for the sake of modversions (and if we're not doing that
> now it's a bug we should fix) we can do it equally for ipv6.

So this procedure is flawed then :

1. Compile kernel.  Set up everything that you need,
   IPV6 is set to 'n'
2. Install kernel and modules to your liking, reboot to take effect.

5 minutes later a user comes and complains that IPV6 isn't available
and he will want it later, so you decide to compile the module for
when he needs it and avoid another reboot :

3. Change config IPV6 to 'm'
4. run make modules && make modules_install

I think that arguing that the kernel image is out of date
is preposterous in this case.  It was built just before the
config was changed!

I'm not saying that changing the kernel is an invalid, I'm only
saying that documentation should be updated to mention explicitly :

If you are adding a kernel module to your config, you must also
recompile your kernel and use the new kernel before you use that
module.  Essentially, modules are useful only for hotplugging type
situations and not for ease of developer access to kernel drivers.

I agree with Mr. Woodhouse in that this is completely non-intuitive
and is absolutely not what most linux users think of as expected
behaviour, but I can understand how something like IPV6 changes too
many things to be reliably build as a module in this fashion.

SO

TO GET TO MY POINT :)

Why can't the subject line of this thread be implemented?  If IPV6
isn't modular, then WHY ALLOW IT AS A MODULE?

Dana Lacoste
Ottawa, Canada

