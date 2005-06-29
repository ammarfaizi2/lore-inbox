Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261164AbVF2CtK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261164AbVF2CtK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 22:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261178AbVF2CtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 22:49:10 -0400
Received: from cantor2.suse.de ([195.135.220.15]:44455 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261164AbVF2CtF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 22:49:05 -0400
Date: Wed, 29 Jun 2005 04:49:03 +0200
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <christoph@lameter.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Read only syscall tables for x86_64 and i386
Message-ID: <20050629024903.GA21575@bragg.suse.de>
References: <Pine.LNX.4.62.0506281141050.959@graphe.net.suse.lists.linux.kernel> <p73r7emuvi1.fsf@verdi.suse.de> <Pine.LNX.4.62.0506281238320.1734@graphe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0506281238320.1734@graphe.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2005 at 12:41:59PM -0700, Christoph Lameter wrote:
> On Tue, 28 Jun 2005, Andi Kleen wrote:
> 
> > It's unfortunately useless because all the kernel is mapped in the
> > same 2 or 4MB page has to be writable because it overlaps with real
> > direct mapped memory.
> 
> The question is: Are syscall tables are supposed to be 
> writable? If no then this patch should go in. If yes then forget about it.

I think it would make sense in theory to write protect them
together with the kernel code and the modules
(just to make root kit writing slightly harder)

It is just that it is not practical on i386/x86-64 right now
without undue performance impact for the main kernel. TLB pressure is 
unfortunately quite performance critical and we cannot goof off on this.

Write protecting the modules would be possible right now because 
they're vmalloced, but might be a problem later if we move them to the 
direct mapping again (that was a beneficial 2.4 optimization), so I am not sure
it would be a good idea.

BTW the kernel actually needs to write to code once
to apply alternative(), but it would't be a problem to use
a temporary mapping for this.

> On IA64 they are readonly and so I thought they should also be readonly
> on i386 and x86_64.
> 
> The ability to protect a readonly section may be another issue.

Well, it's the overriding issue here. Just pretending it's readonly
when it isn't doesn't seem useful.

-Andi

