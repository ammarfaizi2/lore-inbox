Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262962AbVF3MFD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262962AbVF3MFD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 08:05:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262960AbVF3MFD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 08:05:03 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:17164 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263130AbVF3ME6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 08:04:58 -0400
Date: Thu, 30 Jun 2005 13:04:54 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] deinline sleep/delay functions
Message-ID: <20050630130454.C16103@flint.arm.linux.org.uk>
Mail-Followup-To: Denis Vlasenko <vda@ilport.com.ua>,
	Arjan van de Ven <arjan@infradead.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200506300852.25943.vda@ilport.com.ua> <200506301410.43524.vda@ilport.com.ua> <1120130573.3181.42.camel@laptopd505.fenrus.org> <200506301444.51463.vda@ilport.com.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200506301444.51463.vda@ilport.com.ua>; from vda@ilport.com.ua on Thu, Jun 30, 2005 at 02:44:51PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2005 at 02:44:51PM +0300, Denis Vlasenko wrote:
> On Thursday 30 June 2005 14:21, Russell King wrote:
> > The maximum delay is dependent on the architecture implementation,
> > and it depends on bogomips.  There is no one single value for it.
> > Architectures have to decide this from the way that they do the
> > math and the expected range of bogomips.
> 
> In example I posted these limitations are lifted. Granted these
> limitations were not critical, but removing them can't do harm,
> I guess?

They're lifted poorly.  You include a mandatory division in the path.
On systems where division has to be done in code, this is not acceptable,
especially when we're trying to get short delays on embedded CPUs
running below 100MHz.  The time it takes to do the division could
swamp the required delay value.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
