Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262026AbVATBrO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262026AbVATBrO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 20:47:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262024AbVATBrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 20:47:14 -0500
Received: from mail.mellanox.co.il ([194.90.237.34]:22614 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S262026AbVATBqX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 20:46:23 -0500
Date: Thu, 20 Jan 2005 03:42:56 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Chris Wright <chrisw@osdl.org>
Cc: Andi Kleen <ak@muc.de>, akpm@osdl.org, hch@infradead.org,
       linux-kernel@vger.kernel.org, davem@davemloft.net
Subject: Re: [PATCH 1/5] compat_ioctl call seems to miss a security hook
Message-ID: <20050120014256.GC32321@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20050118072133.GB76018@muc.de> <20050118103418.GA23099@mellanox.co.il> <20050118072133.GB76018@muc.de> <20050118104515.GA23127@mellanox.co.il> <20050118112220.X24171@build.pdx.osdl.net> <20050120002806.GA16674@mellanox.co.il> <20050119164353.W24171@build.pdx.osdl.net> <20050120010620.GB32105@mellanox.co.il> <20050119171655.C24171@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050119171655.C24171@build.pdx.osdl.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Chris Wright (chrisw@osdl.org)
> > > > I'm all for it, but the way the patch below works, we could end up
> > > > calling ->ioctl or ->unlocked_ioctl from the compat 
> > > > syscall, and we dont want that.
> > > 
> > > Hmm, I didn't actually change how those are called.  So if it's an issue,
> > > then I don't think this patch introduces it.
> > 
> > Sorry, you are right, we go to do_ioctl only if there are no
> > callbacks.
> 
> I suppose there is one case (not introduced by the patch).  Not sure if
> it's even a problem though:
> 
> t->cmd matches, yet NULL t->handler.  This will fall-thru to
> the do_ioctl: case.  I assume NULL handler is for case where no
> conversion is needed, so it's not a problem?  At least some callers of
> register_ioctl32_conversion() pass NULL handler.

Yes, this is an by design, you put in a NULL handler to say: I dont need
conversions, call my regular handlers. Some in-tree drivers do this.

MST
