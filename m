Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261236AbUFWWB6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbUFWWB6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 18:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbUFWWA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 18:00:57 -0400
Received: from ztxmail05.ztx.compaq.com ([161.114.1.209]:22532 "EHLO
	ztxmail05.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S261236AbUFWVyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 17:54:03 -0400
Date: Wed, 23 Jun 2004 16:55:12 -0500
From: mikem@beardog.cca.cpqcorp.net
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: problems with alloc_disk in genhd.c
Message-ID: <20040623215512.GD16336@beardog.cca.cpqcorp.net>
References: <20040623211829.GC16336@beardog.cca.cpqcorp.net> <20040623212459.GK12308@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040623212459.GK12308@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2004 at 10:24:59PM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Wed, Jun 23, 2004 at 04:18:29PM -0500, mikem@beardog.cca.cpqcorp.net wrote:
> > In the  ioctl we are doing
> > 
> >         /* count partitions 1 to 15 with sizes > 0 */
> >         for(i=0; i <MAX_PART; i++) {
> 
> ... followed by what?
Here's the actual code, I typoed this first time.
	/* count partitions 1 to 15 with sizes > 0 */
	for(i=1; i <MAX_PART; i++) {
		if (!disk->part[i])
			continue;
		if (disk->part[i]->nr_sects != 0)
			luninfo.num_parts++;
We're trying to figure how many partitions are physically on the disk. We do
this for one of our utilities. Is there a kernel API that will return this
data for us?

mikem
> 
> Array of per-partition structures contains the data for partitions,
> obviously.  And drivers have no damn business to ever touching it
> directly, while we are at it.
> 
> BTW, take a look at the comment and loop following it.  And note
> that you are doing 16 iterations in the loop, contrary to what
> the comment above it says.
