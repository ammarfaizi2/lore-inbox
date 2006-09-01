Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750734AbWIAS3n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbWIAS3n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 14:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbWIAS3n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 14:29:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:47525 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750734AbWIAS3m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 14:29:42 -0400
Date: Fri, 1 Sep 2006 11:23:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: Roland Dreier <rdreier@cisco.com>
Cc: Adrian Bunk <bunk@stusta.de>, Tom Tucker <tom@opengridcomputing.com>,
       Steve Wise <swise@opengridcomputing.com>,
       Roland Dreier <rolandd@cisco.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org, "David S. Miller" <davem@davemloft.net>
Subject: Re: 2.6.18-rc5-mm1: drivers/infiniband/hw/amso1100/c2.c compile
 error
Message-Id: <20060901112312.5ff0dd8d.akpm@osdl.org>
In-Reply-To: <adak64nij8f.fsf@cisco.com>
References: <20060901015818.42767813.akpm@osdl.org>
	<20060901160023.GB18276@stusta.de>
	<20060901101340.962150cb.akpm@osdl.org>
	<adak64nij8f.fsf@cisco.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Sep 2006 10:34:24 -0700
Roland Dreier <rdreier@cisco.com> wrote:

>     Andrew> What's __raw_writeq() supposed to do, anyway?  On alpha
>     Andrew> it's writeq() without an mb().  On parisc it's writeq()
>     Andrew> only the data is byte-reversed.  On sparc64() it's
>     Andrew> incomprehensible.  On everything else it's writeq().
> 
> My understanding is that __raw_writeq() is like writeq() except not
> strongly ordered and without the byte-swap on big-endian
> architectures.  The __raw_writeX() variants are convenient to avoid
> having to write inefficient code like writel(swab32(foo), ...) when
> talking to a PCI device that wants big-endian data.  Without the raw
> variant, you end up with a double swap on big-endian architectures.
> 
> sparc64 looks wrong, since __raw_writeq() seems identical to writeq(),
> which seems to imply it's going to swab what is stores.
> 

OK.  Can we please stop hacking around this in drivers and

a) work out what it's supposed to do

b) document that (Documentation/DocBook/deviceiobook.tmpl or code
   comment or whatever)

c) tell arch maintainers?
