Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315406AbSHRQyh>; Sun, 18 Aug 2002 12:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315413AbSHRQyg>; Sun, 18 Aug 2002 12:54:36 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:34317
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S315406AbSHRQyg>; Sun, 18 Aug 2002 12:54:36 -0400
Subject: Re: [PATCH] (0/4) Entropy accounting fixes
From: Robert Love <rml@tech9.net>
To: Bernd Eckenfels <ecki-news2002-08@lina.inka.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E17gKXF-0008Ax-00@sites.inka.de>
References: <E17gKXF-0008Ax-00@sites.inka.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 18 Aug 2002 12:58:39 -0400
Message-Id: <1029689919.903.24.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-08-18 at 03:31, Bernd Eckenfels wrote:

> A question: what is the denger of the network entropy? is it, that one is a
> fraid that snooping could gather knowledge about random source, or is it
> more along the line that one fears that specially deviced packages can feed
> manufactured, and therefore not randmom bits?

The later.  Some believe someone on your local network, who understands
the timing of the physical layers and devices, can influence the entropy
pool.  Further, then, we assume SHA is cracked.  Then they know enough
state and can presumably determine the output of [u]random.

Of course, this is all theoretical but I would not gamble in certain
situations either.  In some, like my workstation on my network, I feel
safe and enjoy having sshd not block waiting for entropy.  So I wrote
the netdev-random stuff...

Note the patches work in the converse manner, too: _today_ there are
network drivers that contribute entropy.  With netdev-random you can
stop that if you wish.

> In the first case, how big would be the hardware proccessing variance for an
> interrupt be? Is it realy predictable from sniffing the network how that
> will result in interrupts?

Possibly.

> How can softinterrupts help here?

Under load the execution of softinterrupts is virtually
non-deterministic, so they do help but we do the timing off the
interrupt handler itself.

	Robert Love

