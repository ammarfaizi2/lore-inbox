Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751233AbWILFsd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbWILFsd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 01:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbWILFsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 01:48:33 -0400
Received: from gate.crashing.org ([63.228.1.57]:4025 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751233AbWILFsd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 01:48:33 -0400
Subject: Re: [RFC] MMIO accessors & barriers documentation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Albert Cahalan <acahalan@gmail.com>
Cc: linux-kernel@vger.kernel.org, jbarnes@virtuousgeek.org,
       alan@lxorguk.ukuu.org.uk, davem@davemloft.net, jgarzik@pobox.com,
       paulus@samba.org, torvalds@osdl.org, akpm@osdl.org,
       segher@kernel.crashing.org
In-Reply-To: <787b0d920609112233u16a1cbcv2bf4ffa6b378dcd7@mail.gmail.com>
References: <787b0d920609112233u16a1cbcv2bf4ffa6b378dcd7@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 12 Sep 2006 15:48:02 +1000
Message-Id: <1158040082.15465.66.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >  4- io_to_lock_wb() : This barrier provides ordering requirement #4
> > between an MMIO store and a subsequent spin_unlock(). It can be used in
> > conjunction with write accessors of Class 2 and 3.
> 
> These can really multiply: read or write, RAM and various types
> of IO space, etc.

No they can't. They are not dependent on the bus type but on the
processor memory model. Only 4 might have some more annoying
dependencies but in practice, it's still manageable. I think I've
defined the 4 base rules that are useful for drivers and the barriers
that provide them. Unless you can show me an example where something
else is needed.

> Let's have a generic arch-provided macro and let gcc do some work
> for us.
> 
> Example usage:
> fence(FENCE_READ_RAM|FENCE_READ_PCI_IO, FENCE_WRITE_PCI_MMIO);

  <snip>

That's terribly ugly imho.

Ben.


