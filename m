Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262386AbTLPU7E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 15:59:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262427AbTLPU7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 15:59:04 -0500
Received: from mtaw4.prodigy.net ([64.164.98.52]:21980 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S262386AbTLPU7B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 15:59:01 -0500
Date: Tue, 16 Dec 2003 12:58:53 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Helge Hafting <helgehaf@aitel.hist.no>, jw schultz <jw@pegasys.ws>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: raid0 slower than devices it is assembled of?
Message-ID: <20031216205853.GC1402@matchmail.com>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Helge Hafting <helgehaf@aitel.hist.no>, jw schultz <jw@pegasys.ws>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200312151434.54886.adasi@kernel.pl> <20031216040156.GJ12726@pegasys.ws> <3FDF1C03.2020509@aitel.hist.no> <Pine.LNX.4.58.0312160825570.1599@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312160825570.1599@home.osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 16, 2003 at 08:42:52AM -0800, Linus Torvalds wrote:
> My personal guess is that modern RAID0 stripes should be on the order of
> several MEGABYTES in size rather than the few hundred kB that most people
> use (not to mention the people who have 32kB stripes or smaller - they
> just kill their IO access patterns with that, and put the CPU at
> ridiculous strain).

Larger stripes may help in general, but I'd suggest that for raid5 (ie, not
raid0), the stripe size should not be enlarged as much.  On many
filesystems, a bitmap change, or inode table update shouldn't require
reading a large stripe from several drives to complete the pairity
calculations.

Probably finding the largest block of data the drive can return in one
command would be a good size for a raid5 stripe.  That's just speculation
though.
