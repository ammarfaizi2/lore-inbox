Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbTI3INE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 04:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261196AbTI3INE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 04:13:04 -0400
Received: from pizda.ninka.net ([216.101.162.242]:59397 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261214AbTI3INA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 04:13:00 -0400
Date: Tue, 30 Sep 2003 01:08:55 -0700
From: "David S. Miller" <davem@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: bunk@fs.tum.de, acme@conectiva.com.br, netdev@oss.sgi.com,
       pekkas@netcore.fi, lksctp-developers@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: RFC: [2.6 patch] disallow modular IPv6
Message-Id: <20030930010855.095c2c35.davem@redhat.com>
In-Reply-To: <1064907572.21551.31.camel@hades.cambridge.redhat.com>
References: <20030928225941.GW15338@fs.tum.de>
	<20030928231842.GE1039@conectiva.com.br>
	<20030928232403.GX15338@fs.tum.de>
	<20030929220916.19c9c90d.davem@redhat.com>
	<1064903562.6154.160.camel@imladris.demon.co.uk>
	<20030930000302.3e1bf8bb.davem@redhat.com>
	<1064907572.21551.31.camel@hades.cambridge.redhat.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Sep 2003 08:39:33 +0100
David Woodhouse <dwmw2@infradead.org> wrote:

> And you don't see why it's confusing that turning something on as a
> _module_ changes the contents of the kernel image?

For something in the kernel tree, no I don't.

> 99% or more of tristate options can be enabled without affecting the
> kernel, and it is expected that such options can be set to 'm' later,
> while the kernel in question is actually running, then built and loaded
> without a reboot.

Expected by whom?  Not by me.

> We should strive to keep this true.

For things _OUTSIDE_ the kernel, surely.  But inside the kernel
tree I don't see any value in this new restriction.

> 	Allow this kernel to ever support IPv6? Y/N
> 	Build IPv6 support? Y/M/N

And I still think this is a complete joke.

If the user sets CONFIG_IPV6 to 'm' from 'n', and make then creates a
new kernel image for him (which it will if dependencies are working
correctly), if he can't figure out that he's gotta install that thing
maybe he should enable module symbol versions to protect him from
insmod'ing that ipv6 module by mistake.

Actually, he won't be able to anyways since only the new kernel exports
a bunch of ipv4 symbols which ipv6 needs.

We could even somehow 'tag' the ipv4 core such that the ipv6 module
can check whether it knows that ipv6 was built as a module or not.

The suggestions I see do nothing to enhance the kernel tree as it currently
stands.  If you wish to prevent the kernel image from changing due to
out-of-tree modules being built, fine, but don't impose this restriction
upon in-kernel modules.
