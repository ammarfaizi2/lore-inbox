Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267348AbVBEQ34@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267348AbVBEQ34 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 11:29:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267422AbVBEQ34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 11:29:56 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:49055 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S267522AbVBEQ3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 11:29:49 -0500
Date: Sat, 5 Feb 2005 16:29:45 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Laurent Riffard <laurent.riffard@free.fr>, linux-kernel@vger.kernel.org,
       "viro@parcelfarce.linux.theplanet.co.uk" 
	<viro@parcelfarce.linux.theplanet.co.uk>,
       Matt Mackall <mpm@selenic.com>
Subject: Re: 2.6.11-rc3-mm1 : can't insmod dm-mod
Message-ID: <20050205162945.GA3928@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>,
	Laurent Riffard <laurent.riffard@free.fr>,
	linux-kernel@vger.kernel.org,
	"viro@parcelfarce.linux.theplanet.co.uk" <viro@parcelfarce.linux.theplanet.co.uk>,
	Matt Mackall <mpm@selenic.com>
References: <20050204103350.241a907a.akpm@osdl.org> <4204880A.3010703@free.fr> <20050205032605.764eedac.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050205032605.764eedac.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 05, 2005 at 03:26:05AM -0800, Andrew Morton wrote:
> You've enabled CONFIG_BASE_SMALL and so the major_names[] hashtable has
> just one element.  device-mapper uses dynamic major allocation, the range
> of which is limited to the size of the top-level major_names[] array.  You
> ran out of slots and register_blkdev() failed.
> 
> So for now I guess we must drop base-small-shrink-major_names-hash.patch.
> 
> Al, that code looks rather crappy.  Shouldn't we be using an idr tree or
> something?

It'd be nice to see major_names just gone completely.  It's only used
for /proc/devices output, and with the infrastucture for easily sharing
majors that one is completely misleading..

