Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265383AbUFTNiN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265383AbUFTNiN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 09:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265494AbUFTNiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 09:38:13 -0400
Received: from stat1.steeleye.com ([65.114.3.130]:39818 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S265383AbUFTNiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 09:38:10 -0400
Subject: Re: DMA API issues
From: James Bottomley <James.Bottomley@steeleye.com>
To: Ian Molton <spyro@f2s.com>
Cc: rmk+lkml@arm.linux.org.uk, david-b@pacbell.net,
       Linux Kernel <linux-kernel@vger.kernel.org>, greg@kroah.com,
       tony@atomide.com, jamey.hicks@hp.com, joshua@joshuawise.com
In-Reply-To: <20040619234933.214b810b.spyro@f2s.com>
References: <1087584769.2134.119.camel@mulgrave>
	<20040618195721.0cf43ec2.spyro@f2s.co <40D34078.5060909@pacbell.net>
	<20040618204438.35278560.spyro@f2s.com> <1087588627.2134.155.camel@mulgrave
	<40D359BB.3090106@pacbell.net> <1087593282.2135.176.camel@mulgrave>
	<40D36EDE.2080803@pacbell.net> <1087600052.2135.197.camel@mulgrave>
	<40D4849B.3070001@pacbell.net>
	<20040619214126.C8063@flint.arm.linux.org.uk>
	<1087681604.2121.96.camel@mulgrave>  <20040619234933.214b810b.spyro@f2s.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 20 Jun 2004 08:37:58 -0500
Message-Id: <1087738680.10858.5.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-06-19 at 17:49, Ian Molton wrote:
> James Bottomley <James.Bottomley@SteelEye.com> wrote:
> > But we still need some sort of fallback where the platform really
> > cannot do this.  And that fallback is going to be ioremap and all the
> > other paraphenalia.  So, the thing that bothers me is that if we have
> > to have the fallback which is identical to what every other driver
> > that uses on-chip memory does anyway, is there any point to placing
> > this in the DMA API?
> 
> Can you describe a system where its impossible to use the DMA API or one
> of the modifications proposed here? what sort of hardware does this and
> why?

There's no architecture currently that can't use the DMA API.

The modification you propose, to make on chip memory visible as normal
memory can't be done on the IBM iserie, AS/400 as I said in the the
email you quote:

On Sat, 2004-06-19 at 16:46, James Bottomley wrote:
> More or less, yes.  The basic problem is platforms that simply cannot
> make this type of bus remote memory visible in the CPU page tables at
> all (the IBM AS/400 apparently falls into that).  Then there are the
> ones that could be persuaded to do this with great difficulty and a lot
> of restrictions (sparc and parisc).

The iseries can't because the PCI bus sits behind the hypervisor and has
to use accessors to get at the on chip memory, it can't simply be mapped
into the address space like it can on ARM.

James


