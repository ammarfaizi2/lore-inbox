Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261329AbVCHF4i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261329AbVCHF4i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 00:56:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261523AbVCHF4i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 00:56:38 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:23749 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261329AbVCHF4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 00:56:30 -0500
Date: Tue, 8 Mar 2005 05:56:27 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>, mpm@selenic.com,
       linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [PATCH] unified device list allocator
Message-ID: <20050308055627.GA1515@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, mpm@selenic.com,
	linux-kernel@vger.kernel.org,
	viro@parcelfarce.linux.theplanet.co.uk
References: <20050308051818.GI3120@waste.org> <20050307213302.560de053.akpm@osdl.org> <20050308054325.GA1262@infradead.org> <20050307215035.345c3f63.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050307215035.345c3f63.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2005 at 09:50:35PM -0800, Andrew Morton wrote:
> > register_blkdev only happens at module_init time (and in fact should go
> > away completely, so I'm not happy wit hthe surgey to keep it barely alive
> > at all)
> 
> Is anyone working on that?

I had a patch from a long time ago that just killed it, but that one isn't
useable for current users anymore.

There's two things it's doing currently:

 - when called with the major argument as 0 it returns an unused major number
   from the top of the old 255 entries major list.  This should be replaced
   by a real dynamic dev_t allocator, similar to alloc_chrdev_region.
 - /proc/devices.  This interface has traditionally been used by things
   like installer but these day's it's totally bogus as the one major, one
   driver limitation got lifeted.  We'll probably have to deprecate it and
   kill it in half a year or a similar timespan.
