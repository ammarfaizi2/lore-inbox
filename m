Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262891AbVF3Iwy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262891AbVF3Iwy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 04:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262892AbVF3Iwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 04:52:54 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:65295 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262891AbVF3Iww (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 04:52:52 -0400
Date: Thu, 30 Jun 2005 09:52:46 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] deinline sleep/delay functions
Message-ID: <20050630095246.A13407@flint.arm.linux.org.uk>
Mail-Followup-To: Denis Vlasenko <vda@ilport.com.ua>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200506300852.25943.vda@ilport.com.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200506300852.25943.vda@ilport.com.ua>; from vda@ilport.com.ua on Thu, Jun 30, 2005 at 08:52:25AM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2005 at 08:52:25AM +0300, Denis Vlasenko wrote:
> Hi Andrew,
> 
> Optimizing delay functions for speed is utterly pointless.
> 
> This patch turns ssleep(n), mdelay(n), udelay(n) and ndelay(n)
> into functions, thus they generate the smallest possible code
> at the callsite. Previously they were more or less inlined.
> 
> Run tested. Saved a few kb off vmlinux.
> 
> Signed-off-by: Denis Vlasenko <vda@ilport.com.ua>

Rejected-by: Russell King 8)

The reason is that now we're unable to find out if anyone's doing
udelay(100000000000000000) which breaks on most architectures.

There are a number of compile-time checks that your patch has removed
which catch such things, and as such your patch is not acceptable.
Some architectures have a lower threshold of acceptability for the
maximum udelay value, so it's absolutely necessary to keep this.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
