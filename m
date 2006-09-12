Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030282AbWILQrz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030282AbWILQrz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 12:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030284AbWILQrz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 12:47:55 -0400
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:63427 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S1030282AbWILQry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 12:47:54 -0400
In-Reply-To: <1158022147.15465.29.camel@localhost.localdomain>
References: <D680AFCF-11EC-48AD-BBC2-B92521DF442A@kernel.crashing.org> <20060911.062144.74719116.davem@davemloft.net> <8DA3BCBF-0F19-4CF0-B22E-91E57E7CB033@kernel.crashing.org> <20060911.173208.74750403.davem@davemloft.net> <1158022147.15465.29.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <5488ABE0-92BB-4DCA-9D31-1928B8432D68@kernel.crashing.org>
Cc: David Miller <davem@davemloft.net>, jbarnes@virtuousgeek.org,
       jeff@garzik.org, paulus@samba.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Content-Transfer-Encoding: 7bit
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Opinion on ordering of writel vs. stores to RAM
Date: Tue, 12 Sep 2006 18:47:29 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
X-Mailer: Apple Mail (2.750)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> As Paulus also pointed out, having writel() behave differently  
> based on
> some magic done earlier at map time makes it harder to understand what
> happens when reading the code, and thus harder to audit drivers for
> missing barriers etc... since it's not obvious at first sight wether a
> driver is using ordered or relaxed semantics.

I do not buy this argument because I do not believe you
can "audit" a driver at "first sight".  You'll have to
look at the mapping call anyway, something might be wrong
there (playing evil __ioremap() tricks, mapping the wrong
size, whatever).

I do see your point, I don't believe the ramifications are
as severe as you make them to be though, esp. when compared
to all the (readability, auditing!) problems that having
more different interfaces for basically the same thing will
bring us.


Segher

