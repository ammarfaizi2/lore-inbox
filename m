Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261204AbVARJgt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261204AbVARJgt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 04:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbVARJgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 04:36:49 -0500
Received: from [213.146.154.40] ([213.146.154.40]:10475 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261204AbVARJgs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 04:36:48 -0500
Date: Tue, 18 Jan 2005 09:36:45 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andi Kleen <ak@muc.de>
Cc: Christoph Hellwig <hch@infradead.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [PATCH] Support compat_ioctl for block devices
Message-ID: <20050118093645.GA24935@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andi Kleen <ak@muc.de>, akpm@osdl.org, linux-kernel@vger.kernel.org,
	viro@parcelfarce.linux.theplanet.co.uk
References: <20050118075602.GD76018@muc.de> <20050118091927.GA24768@infradead.org> <20050118093158.GB20002@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050118093158.GB20002@muc.de>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2005 at 10:31:58AM +0100, Andi Kleen wrote:
> >  - please don't introduce a new API with the BKL held.
> 
> Nope, I'm not going to audit zillions of low level functions for this.

So just stick a lock_kernel() unlock_kernel() into the handler, it's
not like there's more than a handfull of them.

> >  - prototype isn't nice.  just passing the gendisk for block_device
> >    should be enough.
> 
> No, it isn't, the compat handler needs cmd and arg, and file is useful
> when you pass it to an existing ioctl handler.

cmd/arg is needed, file shouldn't.  If you care for the underlying handler
add a version that doesn't take the file * either.
