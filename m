Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751428AbWCNUEh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751428AbWCNUEh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 15:04:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751352AbWCNUEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 15:04:36 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:65004 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S1751337AbWCNUEg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 15:04:36 -0500
Date: Tue, 14 Mar 2006 13:04:30 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Garzik <jeff@garzik.org>, linux-scsi@vger.kernel.org,
       promise_linux@promise.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.16-rc6] Promise SuperTrak driver
Message-ID: <20060314200430.GW1653@parisc-linux.org>
References: <20060313224112.GA19513@havoc.gtf.org> <20060313154236.32293cf9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060313154236.32293cf9.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2006 at 03:42:36PM -0800, Andrew Morton wrote:
> > +#include <linux/irq.h>
> 
> Can't include linux/irq.h from generic code (we really ought to fix that).

In a sense we have -- everybody should include <linux/interrupt.h> and
not <*/irq.h>.  Perhaps we need to poison the includes.

> > +static inline u16 shasta_alloc_tag(u32 *bitmap)
> > +{
> > +	u16 i;
> > +	for (i = 0; i < TAG_BITMAP_LENGTH; i++) 
> > +		if (!((*bitmap) & (1 << i))) {
> > +			*bitmap |= (1 << i);
> > +			return i;
> > +		}
> > +
> > +	return TAG_BITMAP_LENGTH;
> > +}
> 
> This is too large to be inlined.

And if I read the driver right, is unnecessary code.  It could just use
the midlayer tag code (ok, not scsi_populate_tag_msg() which is
SPI-specific, but scsi_activate_tcq(), scsi_deactivate_tcq(),
scsi_find_tag(), scsi_set_tag_type(), and scsi_get_tag_type() should all
work, being thin wrappers around the block layer functionality.

