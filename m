Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261272AbTEKWI5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 18:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261203AbTEKWI5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 18:08:57 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:56033 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S261272AbTEKV5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 17:57:20 -0400
Date: Sun, 11 May 2003 23:09:57 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Christoph Hellwig <hch@infradead.org>, Adrian Bunk <bunk@fs.tum.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 2.5.69-dj1: agp_init shouldn't be static
Message-ID: <20030511220957.GA20415@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Christoph Hellwig <hch@infradead.org>, Adrian Bunk <bunk@fs.tum.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20030510145653.GA26216@suse.de> <20030511122934.GH1107@fs.tum.de> <20030511132120.GA8834@suse.de> <20030511145148.A20017@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030511145148.A20017@infradead.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 11, 2003 at 02:51:48PM +0100, Christoph Hellwig wrote:
 > On Sun, May 11, 2003 at 02:21:20PM +0100, Dave Jones wrote:
 > > duhh, the 810 framebuffer needs it early. I forgot about that.
 > > Will apply patch, and add a comment. Thanks.
 > 
 > no, it doesn't need the agp banner printk early :)  Fix i810fb instead.

Ahh crap, this may bring up another problem. The agpgart _has_ to be
initialised before the i810fb code, otherwise it won't work.
Now that agp_init() doesn't do anything useful, we're relying
on link order.  Whether we get that right or not right now depends..
Needs to be tested by someone who actually uses i810fb to be sure.

Volunteers?  (Just chop out the agp_init call in
drivers/video/i810/i810_main.c), oh and I'm only interested in
feedback from either users of 2.5.69-dj1, or 2.5 bitkeeper tree,
(Linus seems to have taken the first round of AGP updates in the last few hours).

		Dave

