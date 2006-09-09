Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932127AbWIIDyQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbWIIDyQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 23:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932129AbWIIDyQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 23:54:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:34486 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932127AbWIIDyP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 23:54:15 -0400
Date: Fri, 8 Sep 2006 20:54:08 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Paul Mackerras <paulus@samba.org>
cc: linux-kernel@vger.kernel.org, benh@kernel.crashing.org, akpm@osdl.org,
       segher@kernel.crashing.org, davem@davemloft.net
Subject: Re: Opinion on ordering of writel vs. stores to RAM
In-Reply-To: <17666.11971.416250.857749@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.64.0609082052550.27779@g5.osdl.org>
References: <17666.8433.533221.866510@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.64.0609081928570.27779@g5.osdl.org> <17666.11971.416250.857749@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 9 Sep 2006, Paul Mackerras wrote:
> > 
> > although it's quite possible that (a) never makes any sense at all.
> 
> Do you mean (b) never makes sense?

Yes.

> I suspect the best thing at this point is to move the sync in writeX()
> before the store, as you suggest, and add an "eieio" before the load
> in readX().  That does mean that we are then relying on driver writers
> putting in the mmiowb() between a writeX() and a spin_unlock, but at
> least that is documented.

Yeah, that sounds reasonable.

		Linus
