Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750717AbVH3FQx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbVH3FQx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 01:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbVH3FQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 01:16:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61619 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750717AbVH3FQw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 01:16:52 -0400
Date: Mon, 29 Aug 2005 22:15:07 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jon Smirl <jonsmirl@gmail.com>
cc: "David S. Miller" <davem@davemloft.net>, benh@kernel.crashing.org,
       linux-kernel@vger.kernel.org, greg@kroah.com, helgehaf@aitel.hist.no
Subject: Re: Ignore disabled ROM resources at setup
In-Reply-To: <9e473391050829215148807c49@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0508292207330.3243@g5.osdl.org>
References: <1125371996.11963.37.camel@gaston>  <Pine.LNX.4.58.0508292045590.3243@g5.osdl.org>
  <Pine.LNX.4.58.0508292056530.3243@g5.osdl.org>  <20050829.212021.43291105.davem@davemloft.net>
  <Pine.LNX.4.58.0508292125571.3243@g5.osdl.org> <9e473391050829215148807c49@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 30 Aug 2005, Jon Smirl wrote:
> 
> I was reading the status out of the PCI config space to account for
> our friend X which enables ROMs without informing the OS. With X
> around PCI config space can get out of sync with the kernel
> structures.

Well, yes, except that we use the in-kernel resource address for the
actual ioremap() _anyway_ in the routine that calls this, so if X has
remapped the ROM somewhere else, that wouldn't work in the first place.

I'm sure X plays games with this register (I suspect that's why the Matrox 
thing broke in the first place), but I don't think it should do so while 
the kernel uses it. 

I don't think we have much choice anyway. See above.

		Linus
