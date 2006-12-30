Return-Path: <linux-kernel-owner+w=401wt.eu-S1030364AbWL3XJO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030364AbWL3XJO (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 18:09:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030368AbWL3XJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 18:09:14 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:45600 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030364AbWL3XJN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 18:09:13 -0500
X-Originating-Ip: 74.109.98.100
Date: Sat, 30 Dec 2006 18:04:14 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Arjan van de Ven <arjan@infradead.org>
cc: Denis Vlasenko <vda.linux@googlemail.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: replace "memset(...,0,PAGE_SIZE)" calls with "clear_page()"?
In-Reply-To: <1167518748.20929.578.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.64.0612301750550.16519@localhost.localdomain>
References: <Pine.LNX.4.64.0612290106550.4023@localhost.localdomain> 
 <200612302149.35752.vda.linux@googlemail.com> 
 <Pine.LNX.4.64.0612301705250.16056@localhost.localdomain>
 <1167518748.20929.578.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Dec 2006, Arjan van de Ven wrote:

> rday wrote:

> > ... most of the definitions of the clear_page() macro are simply
> > invocations of memset().  see for yourself:

> *MOST*. Not all.

i did notice that.  while the majority of the architectures simply
define clear_page() as a macro calling memset(ptr, 0, PAGE_SIZE), the
rest will implement it in assembler code for whatever reason.  (i'm
assuming that *every* architecture *must* define clear_page() one way
or the other, is that correct?  that would seem fairly obvious, but
i just want to make sure i'm not missing anything obvious.)

> clear_page() is supposed to be for full real pages only... for
> example it allows the architecture to optimize for alignment, cache
> aliasing etc etc.

fair enough.  *technically*, not every call of the form
"memset(ptr,0,PAGE_SIZE)" necessarily represents an address that's on
a page boundary.  but, *realistically*, i'm guessing most of them do.
just grabbing a random example from some grep output:

arch/sh/mm/init.c:
  ...
  /* clear the zero-page */
  memset(empty_zero_page, 0, PAGE_SIZE);
  ...

my only point here is that, given that every architecture needs to
supply some kind of definition of a "clear_page()" routine, one would
think that *lots* of those memset() calls could reasonably be
rewritten as a clear_page() call for improved readibility, no?

and there are a *lot* of memset() calls like that.

rday
