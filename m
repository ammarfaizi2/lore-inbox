Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932337AbWJXDJ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbWJXDJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 23:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932331AbWJXDJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 23:09:57 -0400
Received: from xenotime.net ([66.160.160.81]:21724 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932321AbWJXDJ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 23:09:56 -0400
Date: Mon, 23 Oct 2006 20:11:35 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: Giridhar Pemmasani <pgiri@yahoo.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: incorrect taint of ndiswrapper
Message-Id: <20061023201135.0d8766c9.rdunlap@xenotime.net>
In-Reply-To: <20061024024347.57840.qmail@web32414.mail.mud.yahoo.com>
References: <1161608452.19388.31.camel@localhost.localdomain>
	<20061024024347.57840.qmail@web32414.mail.mud.yahoo.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Oct 2006 19:43:47 -0700 (PDT) Giridhar Pemmasani wrote:

> --- Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> 
> > Taint is used to identify situations where debug data may not be good,
> > that may be proprietary or other dubiously legal code, it may be forcing
> > SMP active on non SMP suitable systems, it may be overriding certain
> > options in a potentially hazardous fashion. Taint exists primarily to
> > help debugging data analysis.
> 
> I have read the history of the patch that marked ndiswrapper as "proprietary
> module", which is not correct (and that was the point of my original post).
> All the posts realted to this referred to issues with loading binary code
> into kernel (and since ndiswrapper does taint the kernel when a driver is
> loaded, this again is misplaced).

The kernel should not depend on a not-in-tree kernel module to
taint the kernel.  The kernel can and should do that itself.

(big) If ndiswrapper were ever added to the kernel tree, then that would
be a reasonable place to do/add the tainting.

> > EXPORT_SYMBOL_GPL() is used to assert that the symbol is absolutely
> > definitely not a public symbol. EXPORT_SYMBOL exports symbols which
> > might be but even then the GPL derivative work rules apply. When you
> > mark a driver GPL it is permitted to use _GPL symbols, but if it does so
> > it cannot then go and load other non GPL symbols and expect people not
> > to question its validity.
> 
> I was not fully aware of this issue until now (I have read posts related to
> this issue now). Does this mean that any module that loads binary code can't
> be GPL, even those that load firmware files? How is
> non-GPL-due-to-transitivity going to be checked? Why does module loader mark
> only couple of modules as non-GPL, when there are other drivers that load
> some sort of binary code? It is understandable to mark a module as non-GPL if
> it is lying about its license, but as far as that is concerned, ndiswrapper
> (alone) is GPL.

---
~Randy
