Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261171AbULROs0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261171AbULROs0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 09:48:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261158AbULROs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 09:48:26 -0500
Received: from [213.146.154.40] ([213.146.154.40]:57569 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261171AbULROsP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 09:48:15 -0500
Date: Sat, 18 Dec 2004 14:48:13 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Mike Werner <werner@sgi.com>
Cc: davej@codemonkey.org.uk, linux-kernel@vger.kernel.org,
       dri-devel@lists.sourceforge.net
Subject: Re: [patch 2.6.10-rc3 1/4] agpgart: allow multiple backends to be initialized
Message-ID: <20041218144813.GA7635@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Mike Werner <werner@sgi.com>, davej@codemonkey.org.uk,
	linux-kernel@vger.kernel.org, dri-devel@lists.sourceforge.net
References: <200412171255.59390.werner@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412171255.59390.werner@sgi.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2004 at 12:55:59PM -0800, Mike Werner wrote:
> This new version reduces the number of changes required by users of the agpgart
> such as drm to support the new api for multiple agp bridges. 
> The first patch doesn't touch any platform specific files and all current platform
> gart drivers will just work the same as they do now since the global 
> agp_bridge is still supported as the default bridge.

The agp_bridge_find function pointer is bogus, that way you can only support
one backend at a time.  I'm not really sure how to do that propery, best have
the generic code walk down the pci device parent chain until it finds an AGP
bridge and allow drivers that don't present their bridges as PCI devices to
supply additional ways to search.

Most other bits of the patch are fine, but in either case you first need to
change the agp bridge driver API to take a struct agp_bridge_data in every
method, else all these changes don't make sense at all.

