Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261914AbUFWWFR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbUFWWFR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 18:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261907AbUFWWED
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 18:04:03 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30084 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261763AbUFWWDP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 18:03:15 -0400
Date: Wed, 23 Jun 2004 23:03:15 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: mikem@beardog.cca.cpqcorp.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: problems with alloc_disk in genhd.c
Message-ID: <20040623220314.GL12308@parcelfarce.linux.theplanet.co.uk>
References: <20040623211829.GC16336@beardog.cca.cpqcorp.net> <20040623212459.GK12308@parcelfarce.linux.theplanet.co.uk> <20040623215512.GD16336@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040623215512.GD16336@beardog.cca.cpqcorp.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2004 at 04:55:12PM -0500, mikem@beardog.cca.cpqcorp.net wrote:
> On Wed, Jun 23, 2004 at 10:24:59PM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> > On Wed, Jun 23, 2004 at 04:18:29PM -0500, mikem@beardog.cca.cpqcorp.net wrote:
> > > In the  ioctl we are doing
> > > 
> > >         /* count partitions 1 to 15 with sizes > 0 */
> > >         for(i=0; i <MAX_PART; i++) {
> > 
> > ... followed by what?
> Here's the actual code, I typoed this first time.
> 	/* count partitions 1 to 15 with sizes > 0 */
> 	for(i=1; i <MAX_PART; i++) {
> 		if (!disk->part[i])
> 			continue;
> 		if (disk->part[i]->nr_sects != 0)
> 			luninfo.num_parts++;
> We're trying to figure how many partitions are physically on the disk. We do
> this for one of our utilities. Is there a kernel API that will return this
> data for us?

A bunch of those, starting with readdir on /sys/block/<whatever>.  Why do
you want that as a driver-specific ioctl?

That stuff has no business being in the driver.  At all.
