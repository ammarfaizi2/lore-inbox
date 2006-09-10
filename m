Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932187AbWIJWVf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbWIJWVf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 18:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932200AbWIJWVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 18:21:35 -0400
Received: from gate.crashing.org ([63.228.1.57]:37280 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932187AbWIJWVe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 18:21:34 -0400
Subject: Re: Opinion on ordering of writel vs. stores to RAM
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>,
       David Miller <davem@davemloft.net>, jeff@garzik.org, paulus@samba.org,
       torvalds@osdl.org, linux-kernel@vger.kernel.org, akpm@osdl.org,
       segher@kernel.crashing.org
In-Reply-To: <1157926993.23085.29.camel@localhost.localdomain>
References: <17666.11971.416250.857749@cargo.ozlabs.ibm.com>
	 <45028F87.7040603@garzik.org>
	 <20060909.030854.78720744.davem@davemloft.net>
	 <200609101018.06930.jbarnes@virtuousgeek.org>
	 <1157916919.23085.24.camel@localhost.localdomain>
	 <1157923513.31071.256.camel@localhost.localdomain>
	 <1157926993.23085.29.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 11 Sep 2006 08:18:28 +1000
Message-Id: <1157926708.31071.259.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-09-10 at 23:23 +0100, Alan Cox wrote:
> Ar Llu, 2006-09-11 am 07:25 +1000, ysgrifennodd Benjamin Herrenschmidt:
> > I'm copying that from a private discussion I had. Please let me know if
> > you have comments. This proposal includes some questions too so please
> > answer :)
> 
> Looks sane and Linus seems to like mmiowb. Only other question: what are
> the guarantees of memcpy_to/fromio. Does it access the memory in ordered
> fashion or not, does it guarantee only ordering at the end of the copy
> or during it ?

Well, Linus is also ok with writel not ordering memory an IO accesses :)
Though he also mentioned that if we go that route (which is what we have
now in fact), we take the burden of having to test  and fix drivers who
don't get it...

That's why I think a compromise is in order, thus my proposal :)

Ben.

