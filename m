Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266101AbUA1TTR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 14:19:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266106AbUA1TTR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 14:19:17 -0500
Received: from ns.suse.de ([195.135.220.2]:56276 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266101AbUA1TTI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 14:19:08 -0500
Date: Wed, 28 Jan 2004 20:17:01 +0100
From: Andi Kleen <ak@suse.de>
To: Grant Grundler <iod00d@hp.com>
Cc: ishii.hironobu@jp.fujitsu.com, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: [RFC/PATCH, 1/4] readX_check() performance evaluation
Message-Id: <20040128201701.045670db.ak@suse.de>
In-Reply-To: <20040128190923.GA6333@cup.hp.com>
References: <00a201c3e541$c0e7d680$2987110a@lsd.css.fujitsu.com>
	<20040128172004.GB5494@cup.hp.com>
	<20040128184137.616b6425.ak@suse.de>
	<20040128190923.GA6333@cup.hp.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jan 2004 11:09:23 -0800
Grant Grundler <iod00d@hp.com> wrote:


> ...
> > In short this stuff
> > probably only makes sense when you're a system vendor who sells
> > support contracts for whole systems including hardware support.
> > For the normal linux model where software is independent from hardware
> > (and hardware is usually crappy) it just doesn't work very well.
> 
> While ia64/parisc platforms have HW support for this,
> I totally agree it won't work well for most (x86) platforms.
> I'd like to reduce the burden on the driver writers for common
> drivers (eg MPT) used on "vanilla" x86.

It would probably a good idea to implement it for i386 on chipsets
that support it reliably and try to educate driver writers to 
enable it when they are testing drivers. This would likely 
improve the quality of linux drivers long term and make your
job as maintainer of an "anal IO error" platform easier.

Just it should not be enabled by default in production kernels.
And finding out where it works reliably will be some work.

> 
> And like I pointed out before, linux kernel needs to review panic()
> calls to see if some of them could easily be eliminated. The general
> robustness issues (eg pci_map_single() panics on failure) aren't
> prerequisites for IO error checking, but the latter seems less
> useful with out the former.

There is no reason pci_map_single() has to panic on overflow. On x86-64
it returns an unmapped address that is guaranteed to cause an bus abort
for 128KB. And you have an macro to test for it (pci_dma_error()). 
I believe ppc64 has adopted it too. Of course most drivers don't 
use it yet.

Still panic on overflow is useful for testing and it is kept as an
kernel command line option.

-Andi
