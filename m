Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265199AbUF1UtR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265199AbUF1UtR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 16:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265205AbUF1UtR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 16:49:17 -0400
Received: from host-65-117-135-105.timesys.com ([65.117.135.105]:33999 "EHLO
	yoda.timesys") by vger.kernel.org with ESMTP id S265199AbUF1UtP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 16:49:15 -0400
Date: Mon, 28 Jun 2004 16:48:57 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: Scott Wood <scott@timesys.com>, oliver@neukum.org, zaitcev@redhat.com,
       greg@kroah.com, arjanv@redhat.com, jgarzik@redhat.com,
       tburke@redhat.com, linux-kernel@vger.kernel.org,
       stern@rowland.harvard.edu, mdharm-usb@one-eyed-alien.net,
       david-b@pacbell.net
Subject: Re: drivers/block/ub.c
Message-ID: <20040628204857.GA5321@yoda.timesys>
References: <20040626130645.55be13ce@lembas.zaitcev.lan> <200406270631.41102.oliver@neukum.org> <20040626233423.7d4c1189.davem@redhat.com> <200406271242.22490.oliver@neukum.org> <20040627142628.34b60c82.davem@redhat.com> <20040628141517.GA4311@yoda.timesys> <20040628132531.036281b0.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040628132531.036281b0.davem@redhat.com>
User-Agent: Mutt/1.5.4i
From: Scott Wood <scott@timesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2004 at 01:25:31PM -0700, David S. Miller wrote:
> That's true.  But if one were to propose such a feature to the gcc
> guys, I know the first question they would ask.  "If no padding of
> the structure is needed, why are you specifying this new
> __nopadding__ attribute?"

It would benefit other structures that *do* need it, but only for a
few fields.

> I think it's bad to just "smack this attribute onto any structure that
> _MIGHT_ need it on some platform"  I never do that in my drivers,
> and they work on all platforms.  For example, if you have a simple
> DMA descriptor structure such as:
> 
> 	struct txd {
> 		u32 dma_addr;
> 		u32 length;
> 	};
> 
> It is just total and utter madness to put a packed or the proposed
> __nopadding__ attribute on that structure.  Yet this seems to be
> what was suggested now and at the beginning of this thread.

As long as GCC generates code as it does, sure, it's madness.

However, what if it were to be run on a machine that can't address
smaller quantities than 64-bit?  Such a machine sounds silly, but it
could happen (just as early Alphas couldn't directly load or store
smaller than 32-bit quantities), and thus the compiler might want to
pad them so that they don't share a word.  If a way exists to express
to the compiler that the format of the struct is intended to be
exactly as specified, without causing any detrimental effect, why not
make use of it?

As an aside, what would *really* be nice is if GCC had an attribute
that lets one specify the endianness of the field, so that one
doesn't have to mess around with conversion functions/macros
uglifying the code.  It'd probably be faster, too, as the optimizer
could deal with the loads and stores like any other.

-Scott
