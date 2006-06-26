Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030590AbWF0Bew@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030590AbWF0Bew (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 21:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030595AbWF0Bev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 21:34:51 -0400
Received: from adsl-216-102-214-42.dsl.snfc21.pacbell.net ([216.102.214.42]:51852
	"EHLO cynthia.pants.nu") by vger.kernel.org with ESMTP
	id S1030591AbWF0Beu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 21:34:50 -0400
Date: Mon, 26 Jun 2006 10:43:19 -0700
From: Brad Boyer <flar@allandria.com>
To: Finn Thain <fthain@telegraphics.com.au>
Cc: Roman Zippel <zippel@linux-m68k.org>, Al Viro <viro@ftp.linux.org.uk>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linux/m68k <linux-m68k@vger.kernel.org>
Subject: Re: [PATCH 08/21] gcc 4 fix
Message-ID: <20060626174319.GA20753@cynthia.pants.nu>
References: <20060623183056.479024000@linux-m68k.org> <20060623183911.847605000@linux-m68k.org> <20060623193524.GA27946@ftp.linux.org.uk> <Pine.LNX.4.64.0606232158400.17704@scrub.home> <Pine.LNX.4.64.0606241420330.1073@loopy.telegraphics.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606241420330.1073@loopy.telegraphics.com.au>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 24, 2006 at 02:45:06PM +1000, Finn Thain wrote:
> On Fri, 23 Jun 2006, Roman Zippel wrote:
> > On Fri, 23 Jun 2006, Al Viro wrote:
> > > Broken.  Proper fix is to rename the function so that it wouldn't 
> > > clash.
> > 
> > Well, I wouldn't call it broken, as both versions can never be compiled 
> > into the same kernel, but I don't care much how it's fixed.
> > 
> > Does anyone know the relationship between via-pmu.c and via-pmu68k.c? If 
> > it's intended to keep the differences small, a rename would be the wrong 
> > fix.
> 
> The relationship is (and was) just that they share the pmu.h header file 
> declarations. In the patch in question I used the powerpc definition as 
> well.

I believe that pmu68k started out as a copy of pmu. The versions of PMU
on the 68k PowerBooks are just older than the ones on ppc. They are
fundamentally the same, it's just that the ppc systems have various fixes
and new features. Ideally the files would be merged back together and
split in a more logical fashion to share the code that is the same. Each
one already supports multiple versions of the chip.

> The powerpc version exports pmu_queue_request (apparently for the use of 
> low_i2c.c). The m68k version doesn't, but if it needed to export it, I 
> don't see why it shouldn't implement the same "API"?

Several other parts of the kernel submit pmu requests, but most of them
use pmu_request(). It's probably better to unify this API set. The cuda
and IIsi drivers have equivalent calls, for that matter. I wanted to
make a generic call that would switch to the active one of those, but
the idea didn't go over too well. It was probably due to the bad taste
everyone had from when adb_request() was used for that purpose.

	Brad Boyer
	flar@allandria.com

