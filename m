Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750942AbWGBWFN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750942AbWGBWFN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 18:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750987AbWGBWFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 18:05:13 -0400
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:37339 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S1750942AbWGBWFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 18:05:11 -0400
Date: Mon, 3 Jul 2006 00:04:49 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: 7eggert@gmx.de, Arjan van de Ven <arjan@infradead.org>,
       Ulrich Drepper <drepper@gmail.com>, Pavel Machek <pavel@ucw.cz>,
       Jason Baron <jbaron@redhat.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: make PROT_WRITE imply PROT_READ
In-Reply-To: <1151834171.14346.2.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0607022355570.5477@be1.lrz>
References: <6qIEW-1Tx-23@gated-at.bofh.it> <6qIEW-1Tx-21@gated-at.bofh.it>
  <6qUwd-2Aq-9@gated-at.bofh.it> <6qUwd-2Aq-7@gated-at.bofh.it> 
 <6qUFV-2N8-13@gated-at.bofh.it> <6qUFY-2N8-33@gated-at.bofh.it> 
 <6rlmT-8op-37@gated-at.bofh.it> <6siwJ-3dC-5@gated-at.bofh.it> 
 <6sLoY-4GV-31@gated-at.bofh.it> <6sZUS-V5-19@gated-at.bofh.it> 
 <6tib4-2wA-3@gated-at.bofh.it> <6tmHL-Oq-5@gated-at.bofh.it> 
 <6tpZ7-5Tj-13@gated-at.bofh.it>  <E1FwfNo-00012H-Gz@be1.lrz>
 <1151834171.14346.2.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@web.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Jul 2006, Alan Cox wrote:
> Ar Sad, 2006-07-01 am 15:19 +0200, ysgrifennodd Bodo Eggert:

> > > unpredictably depending on the precise ordering of events on a clean
> > > page.
> > 
> > You asked for a fault, and as long as the hardware supports it, you'll
> > get one (and you're supposed to). If the hardware doesn't support read
> > faults on mapped pages, you may not get all the read faults you want. The
> > proposed patch makes the situation worse by disabeling the _requested_
> > failures even in situations where it can be done.
> 
> The later patch as posted has no effect on such platforms

I'm talking about the affected platforms.

> because it
> does not touch anything but the architecture code. Without that its
> random what happens because the CPU cannot enforce write only but the
> fault handler tries to. That means if you fault reading because the page
> is not present you may get a fault while if you access a page which is
> present you won't get a fault.

IMO it's the best we can get, even if the results are ...

> That gets quite random and has bizarre effects.

OTOH, there is not much difference between randomly wrong and consistently 
wrong, so I shall be happy either way (as if it would even matter).
-- 
'Calm down -- it's only ones and zeros.' 
