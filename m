Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266224AbSKONIT>; Fri, 15 Nov 2002 08:08:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266236AbSKONIT>; Fri, 15 Nov 2002 08:08:19 -0500
Received: from [217.167.51.129] ([217.167.51.129]:61173 "EHLO zion.wanadoo.fr")
	by vger.kernel.org with ESMTP id <S266224AbSKONIS>;
	Fri, 15 Nov 2002 08:08:18 -0500
Subject: Re: [PATCH] swsuspend and CONFIG_DISCONTIGMEM=y
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pavel Machek <pavel@suse.cz>
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20021115120233.GC25902@atrey.karlin.mff.cuni.cz>
References: <20021115081044.GI18180@conectiva.com.br>
	<20021115084915.GS23425@holomorphy.com>
	<20021115094827.GT23425@holomorphy.com> 
	<20021115120233.GC25902@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 15 Nov 2002 14:16:12 +0100
Message-Id: <1037366172.877.30.camel@zion>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-11-15 at 13:02, Pavel Machek wrote:
> Hi!
> 
> > > The following dropped hunk from Pavel should repair it:
> > 
> > [cc: list trimmed to spare the uninterested]
> > 
> > Hmm, there are some oddities here in count_and_copy_data_pages(). It
> > looks like the CONFIG_HIGHMEM panic() is there because copy_page() is
> > done without kmapping, and the CONFIG_DISCONTIGMEM panic() is there
> > because the pgdat list etc. are not walked according to VM
> > conventions.
> 
> How much memory is needed for HIGHMEM to be neccessary? Is it 1GB? If
> so, I can well imagine 1GB laptop....

Depends on the arch & other matters. 768Mb on PPC at least, and
it starting to be common within laptops as well.

> This certainly does not work. We'd need to do some deep magic in
> suspend_asm.S to copy pages back. [Well, deep magic... Same
> kmap_atomic.] But suspend_asm.S has to guarantee not touching any
> memory so the change is not quite trivial.

At worst, that could be an arch provided routine. On most PPC32's
I can then just disable data translation on the MMU and access
all pages without kmap'ing them. But that's not terribly portable
and each arch would need different kind of hacking.

Ben.

