Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932147AbWBFPD6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbWBFPD6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 10:03:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932146AbWBFPD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 10:03:58 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:11404 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S932132AbWBFPD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 10:03:57 -0500
Subject: Re: [PATCH] ipr: don't doublefree pages from scatterlist
From: James Bottomley <James.Bottomley@SteelEye.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: hugh@veritas.com, brking@us.ibm.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <20060206.014608.22328385.davem@davemloft.net>
References: <Pine.LNX.4.61.0602040004020.5406@goblin.wat.veritas.com>
	 <43E66FB6.6070303@us.ibm.com>
	 <Pine.LNX.4.61.0602060909180.6827@goblin.wat.veritas.com>
	 <20060206.014608.22328385.davem@davemloft.net>
Content-Type: text/plain
Date: Mon, 06 Feb 2006 09:02:59 -0600
Message-Id: <1139238179.3022.2.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-06 at 01:46 -0800, David S. Miller wrote:
> That's a bug, frankly.  Sparc64 doesn't need to do anything like
> that.  Spamming the page pointers is really really bogus and I'm
> surprised this doesn't make more stuff explode.
> 
> It was never the intention to allow the DMA mapping support code
> to modify the page, offset, and length members of the scatterlist.
> Only the DMA components.
> 
> I'd really prefer that those assignments get fixed and an explicit
> note added to Documentation/DMA-mapping.txt about this.
> 
> It's rediculious that these generic subsystem drivers need to
> know about this. :)

I complained about this x86_64 behaviour ages ago.  Andi claimed it was
the only way they could get there merging algorithm to work.  It
actually triggered a bug in SCSI because in-flight I/O that was rejected
gets unmapped and then remapped (which was, originally, not working).
They finally fixed it by making the unmap put back the original
scatterlist.  Perhaps this should go to linux-arch just in case anyone
else copied x86_64?

James


