Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261662AbULFVfW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261662AbULFVfW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 16:35:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261663AbULFVfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 16:35:22 -0500
Received: from 209-128-68-125.bayarea.net ([209.128.68.125]:27796 "EHLO
	hera.kernel.org") by vger.kernel.org with ESMTP id S261662AbULFVfP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 16:35:15 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: [PATCH] aic7xxx large integer
Date: Mon, 6 Dec 2004 21:35:05 +0000 (UTC)
Organization: Mostly alphabetical, except Q, which We do not fancy
Message-ID: <cp2ja9$i88$1@terminus.zytor.com>
References: <41B222BE.9020205@sombragris.com> <41B24542.7010803@sombragris.com> <1102208526.6052.87.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1102368905 18697 127.0.0.1 (6 Dec 2004 21:35:05 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Mon, 6 Dec 2004 21:35:05 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <1102208526.6052.87.camel@localhost>
By author:    Robert Love <rml@novell.com>
In newsgroup: linux.dev.kernel
>
> On Sun, 2004-12-05 at 00:16 +0100, Miguel Angel Flores wrote:
> 
> > I post the patch very quickly :(. The original code finally seems OK. My 
> > controller is not working with 39 bit addressing, although I can't find 
> > why the compiler warns. Maybe the length of dma_addr_t type, in the 
> > 2.6.9 the type of the mask_39bit variable is bus_addr_t.
> 
> The compiler warns because you are putting a 64-bit value (an unsigned
> long long) in a 32-bit value (a u32).
> 
> There is definitely a problem on non-highmem compiled kernels, there is
> no doubt of that.  The concern was that your suggested fix is not right.
> 
> Assuming that a 39-bit value is really wanted, the type either needs to
> be changed to a dma64_addr_t or the value needs to change at
> compile-time to a suitable 32-bit variant when !CONFIG_HIGHMEM64G.
> 
> Without knowing what the driver is doing, I have no idea.
> 

I suspect that what the driver wants is a mask that is a valid DMA
address no wider than 39 bits (because that's all the hardware can
do.)

If so, I would assume (dma_addr_t)0x7FFFFFFFFFULL is probably the
right thing; it will be truncated to a 32-bit mask if only 32-bit
addressing is available.

	-hpa
