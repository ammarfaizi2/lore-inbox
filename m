Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269019AbUI2Uo7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269019AbUI2Uo7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 16:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268999AbUI2Uo7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 16:44:59 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:47262 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S269019AbUI2UoQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 16:44:16 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] I/O space write barrier
Date: Wed, 29 Sep 2004 13:43:55 -0700
User-Agent: KMail/1.7
Cc: Greg Banks <gnb@sgi.com>, akpm@osdl.org, linux-kernel@vger.kernel.org,
       jeremy@sgi.com, johnip@sgi.com, netdev@oss.sgi.com
References: <200409271103.39913.jbarnes@engr.sgi.com> <20040929103646.GA4682@sgi.com> <20040929133500.59d78765.davem@davemloft.net>
In-Reply-To: <20040929133500.59d78765.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409291343.55863.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, September 29, 2004 1:35 pm, David S. Miller wrote:
> On Wed, 29 Sep 2004 20:36:46 +1000
>
> Greg Banks <gnb@sgi.com> wrote:
> > Ok, here's a patch for the tg3 network driver to use mmiowb().  Tests
> > over the last couple of days has shown that it solves the oopses in
> > tg3_tx() that I reported and attempted to patch some time ago:
> >
> > http://marc.theaimsgroup.com/?l=linux-netdev&m=108538612421774&w=2
> >
> > The CPU usage of the mmiowb() approach is also significantly better
> > than doing PCI reads to flush the writes (by setting the existing
> > TG3_FLAG_MBOX_WRITE_REORDER flag).  In an artificial CPU-constrained
> > test on a ProPack kernel, the same amount of CPU work for the REORDER
> > solution pushes 85.1 MB/s over 2 NICs compared to 146.5 MB/s for the
> > mmiowb() solution.
>
> Please put this macro in asm/io.h or similar and make sure
> every platform has it implemented or provides a NOP version.

The patch that actually implements mmiowb() already does this, I think Greg 
just used his patch for testing.  The proper way to do it of course is to 
just use mmiowb() where needed in tg3 after the write barrier patch gets in.

> A lot of people are going to get this wrong btw.  The only
> way it's really going to be cured across the board is if someone
> like yourself who understands this audits all of the drivers.

Yep, just like PCI posting (though many people seem to have a grasp on that 
now).

Thanks,
Jesse
