Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262907AbVF3JMD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262907AbVF3JMD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 05:12:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262908AbVF3JMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 05:12:03 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1255 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262907AbVF3JL4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 05:11:56 -0400
Date: Thu, 30 Jun 2005 02:11:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: vda@ilport.com.ua, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] deinline sleep/delay functions
Message-Id: <20050630021111.35aaf45f.akpm@osdl.org>
In-Reply-To: <20050630095246.A13407@flint.arm.linux.org.uk>
References: <200506300852.25943.vda@ilport.com.ua>
	<20050630095246.A13407@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> wrote:
>
> On Thu, Jun 30, 2005 at 08:52:25AM +0300, Denis Vlasenko wrote:
> > Hi Andrew,
> > 
> > Optimizing delay functions for speed is utterly pointless.
> > 
> > This patch turns ssleep(n), mdelay(n), udelay(n) and ndelay(n)
> > into functions, thus they generate the smallest possible code
> > at the callsite. Previously they were more or less inlined.
> > 
> > Run tested. Saved a few kb off vmlinux.
> > 
> > Signed-off-by: Denis Vlasenko <vda@ilport.com.ua>
> 
> Rejected-by: Russell King 8)
> 
> The reason is that now we're unable to find out if anyone's doing
> udelay(100000000000000000) which breaks on most architectures.
> 
> There are a number of compile-time checks that your patch has removed
> which catch such things, and as such your patch is not acceptable.
> Some architectures have a lower threshold of acceptability for the
> maximum udelay value, so it's absolutely necessary to keep this.

It removes that check from x86 - other architectures retain it.

I don't recall seeing anyone trigger the check, and it hardly seems worth
adding a "few kb" to vmlinux for it?
