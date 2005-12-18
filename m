Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964848AbVLRMJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964848AbVLRMJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 07:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932700AbVLRMJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 07:09:27 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:12944 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932697AbVLRMJ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 07:09:26 -0500
Subject: Re: [2.6 patch] i386: always use 4k/4k stacks
From: Arjan van de Ven <arjan@infradead.org>
To: Stefan Rompf <stefan@loplof.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200512181304.38054.stefan@loplof.de>
References: <200512181149.02009.stefan@loplof.de>
	 <1134904884.9626.7.camel@laptopd505.fenrus.org>
	 <200512181304.38054.stefan@loplof.de>
Content-Type: text/plain
Date: Sun, 18 Dec 2005 13:09:22 +0100
Message-Id: <1134907763.9626.11.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-12-18 at 13:04 +0100, Stefan Rompf wrote:
> Am Sonntag 18 Dezember 2005 12:21 schrieb Arjan van de Ven:
> 
> > the kernel has a stack overflow detector, which checks at irq entry time
> > if the stack is "rather high" (7kb into the stack on a 8kb stack, 3.5kb
> > on a 4k stack). When this warning hits there's still runway left (like
> > 12.5 percent), but lets say the end becomes in sight. If the stack usage
> > would be really tight, this "early warning" detector would be hitting a
> > lot of people, right?
> 
> Wrong. The probability that an interrupt happens just during the codepath with 
> highest stack usage is very small

so it samples over 1000 times per second, more when busy. Multiplied
over a very large number of users, and 2 years of time. "very small"...
I don't quite agree there.


> Anyway CONFIG_DEBUG_STACKOVERFLOW is not 
> enabled in 2.6.14.4 i386 defconfig. Don't know about vendor kernel kernels 
> though.

the RH/Fedora ones have this enabled

> > (and the "safety net" is a bit of misnomer, since it's not really safe,
> > just "statistically different" if the shit hits the fan)
> 
> If you can't even guarantee that 8k (or 6k) is enough, how can you vote for 4k 
> then ;-) 

it's not 4k it is 4k+4k btw. And my argument is that it's not less
safe.. nor unsafe


