Return-Path: <linux-kernel-owner+w=401wt.eu-S1763069AbWLKULv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763069AbWLKULv (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 15:11:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763070AbWLKULv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 15:11:51 -0500
Received: from smtp.osdl.org ([65.172.181.25]:60319 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763068AbWLKULu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 15:11:50 -0500
Date: Mon, 11 Dec 2006 12:09:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: David Miller <davem@davemloft.net>, mingo@elte.hu,
       alan@lxorguk.ukuu.org.uk, lenb@kernel.org, linux-kernel@vger.kernel.org,
       ak@suse.de, torvalds@osdl.org
Subject: Re: [patch] net: dev_watchdog() locking fix
Message-Id: <20061211120945.d75db2b4.akpm@osdl.org>
In-Reply-To: <20061211075111.GA24994@gondor.apana.org.au>
References: <20061207210657.GA23229@gondor.apana.org.au>
	<20061208151902.4c8bb012.akpm@osdl.org>
	<20061208235952.GA4693@gondor.apana.org.au>
	<20061209.140205.126778911.davem@davemloft.net>
	<20061210234508.cd83a784.akpm@osdl.org>
	<20061211075111.GA24994@gondor.apana.org.au>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2006 18:51:11 +1100
Herbert Xu <herbert@gondor.apana.org.au> wrote:

> On Sun, Dec 10, 2006 at 11:45:08PM -0800, Andrew Morton wrote:
> > 
> > It spits a nasty during bringup
> > 
> > e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
> > forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.59.
> > netconsole: device eth0 not up yet, forcing it
> > e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex
> > WARNING (!__warned) at kernel/softirq.c:137 local_bh_enable()
> 
> Normally networking isn't invoked with interrupts turned off, but
> I suppose we don't have a choice here.  This is unique being a
> place where you can get called with BH on, off, or IRQs off.
> 
> Given that this is only used for printk, the easiest solution is
> probably just to disable local IRQs instead of BH.
> 

I'll try that.  I wonder what will explode now..
