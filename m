Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262437AbVAJUHB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262437AbVAJUHB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 15:07:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262490AbVAJTrd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 14:47:33 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:7885 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262437AbVAJTct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 14:32:49 -0500
Subject: Re: [PATCH] 2.6.9 Use skb_padto() in drivers/net/8390.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Paul Gortmaker <penguin@muskoka.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <41E1EB68.5000709@muskoka.com>
References: <41DED9FA.7080106@pobox.com>  <41DF9AC1.2010609@muskoka.com>
	 <1105197689.10505.22.camel@localhost.localdomain>
	 <41E1EB68.5000709@muskoka.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105381093.12028.81.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 10 Jan 2005 18:28:27 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-01-10 at 02:41, Paul Gortmaker wrote:
> Using rdtscl over the  area affected by the patch on the two variants for a
> sample  of 234 small packets, I see an average of 4141 for using the
> existing stack scratch area, and 4162 for using skb_padto.   That is a
> difference of about 0.5%, which is significantly less than the typical
> spread in the samples themselves.  To help give a relevant scale,  feeding
> it a larger 1400 byte packet comes in at around 60,000 cycles on this
> particular box.   Am I being optimistic to see this as good news -- meaning
> that there is no longer a need for driver specific padto implementations,
> whereas it looks like there was back when you did your tests? 

It means that padto has improved a lot (or the underlying allocators).
It also still means the patch makes the code slower and introduces
changes that have no benefit into the kernel, so while its good to see
its not relevant its still a pointless change.

