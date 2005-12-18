Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932566AbVLRMDy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932566AbVLRMDy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 07:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932694AbVLRMDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 07:03:54 -0500
Received: from natsmtp00.rzone.de ([81.169.145.165]:23548 "EHLO
	natsmtp00.rzone.de") by vger.kernel.org with ESMTP id S932566AbVLRMDx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 07:03:53 -0500
From: Stefan Rompf <stefan@loplof.de>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [2.6 patch] i386: always use 4k/4k stacks
Date: Sun, 18 Dec 2005 13:04:37 +0100
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <200512181149.02009.stefan@loplof.de> <1134904884.9626.7.camel@laptopd505.fenrus.org>
In-Reply-To: <1134904884.9626.7.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512181304.38054.stefan@loplof.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag 18 Dezember 2005 12:21 schrieb Arjan van de Ven:

> the kernel has a stack overflow detector, which checks at irq entry time
> if the stack is "rather high" (7kb into the stack on a 8kb stack, 3.5kb
> on a 4k stack). When this warning hits there's still runway left (like
> 12.5 percent), but lets say the end becomes in sight. If the stack usage
> would be really tight, this "early warning" detector would be hitting a
> lot of people, right?

Wrong. The probability that an interrupt happens just during the codepath with 
highest stack usage is very small. Anyway CONFIG_DEBUG_STACKOVERFLOW is not 
enabled in 2.6.14.4 i386 defconfig. Don't know about vendor kernel kernels 
though.

I thought more about filling the stack with some arbitrary value on thread 
startup and checking how much has been overwritten on a regular basis. Part 
of it is alreay there, hidden unter CONFIG_DEBUG_STACK_USAGE. The 
verification should just happen timer-controlled, not only on sysrq-whatever.

> (and the "safety net" is a bit of misnomer, since it's not really safe,
> just "statistically different" if the shit hits the fan)

If you can't even guarantee that 8k (or 6k) is enough, how can you vote for 4k 
then ;-) Just a little provocation, I don't plan getting too involved into 
this dicussion, hell, this is just about a ridiculously small amount of self 
contained #ifdef'd code ;-)

Stefan
