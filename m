Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262940AbVF3LLE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262940AbVF3LLE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 07:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262941AbVF3LLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 07:11:04 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:15550 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262940AbVF3LK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 07:10:58 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] deinline sleep/delay functions
Date: Thu, 30 Jun 2005 14:10:43 +0300
User-Agent: KMail/1.5.4
Cc: Andrew Morton <akpm@osdl.org>, Russell King <rmk+lkml@arm.linux.org.uk>,
       linux-kernel@vger.kernel.org
References: <200506300852.25943.vda@ilport.com.ua> <200506301321.20692.vda@ilport.com.ua> <1120128441.3181.37.camel@laptopd505.fenrus.org>
In-Reply-To: <1120128441.3181.37.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506301410.43524.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 30 June 2005 13:47, Arjan van de Ven wrote:
> On Thu, 2005-06-30 at 13:21 +0300, Denis Vlasenko wrote:
> > On Thursday 30 June 2005 12:19, Arjan van de Ven wrote:
> > > 
> > > > > There are a number of compile-time checks that your patch has removed
> > > > > which catch such things, and as such your patch is not acceptable.
> > > > > Some architectures have a lower threshold of acceptability for the
> > > > > maximum udelay value, so it's absolutely necessary to keep this.
> > > > 
> > > > It removes that check from x86 - other architectures retain it.
> > > > 
> > > > 
> > For users, _any_ value, however large, will work for
> > any delay function.
> 
> that's not desired though. Desired is to limit udelay() to say 2000 or
> so. And force anything above that to go via mdelay() (just to make it
> stand out as broken code ;)

An if(usec > 2000) { printk(..); dump_stack(); } will do.

But do you really want to do this? There might be legitimate reasons
to compute udelay's parameter with results which are sometimes large.

If you really want to, let's decide on this limit now,
before patch cooking. I err to conservative (large) limit
(mostly in order to catch math underflows) or no limit at all.
--
vda

