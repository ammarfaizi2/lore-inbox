Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932216AbWCTIaO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbWCTIaO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 03:30:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932220AbWCTIaO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 03:30:14 -0500
Received: from z2.cat.iki.fi ([212.16.98.133]:59812 "EHLO z2.cat.iki.fi")
	by vger.kernel.org with ESMTP id S932216AbWCTIaM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 03:30:12 -0500
Date: Mon, 20 Mar 2006 10:30:06 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Xin Zhao <uszhaoxin@gmail.com>
Cc: mingz@ele.uri.edu, mikado4vn@gmail.com,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org
Subject: Re: Question regarding to store file system metadata in database
Message-ID: <20060320083006.GC3927@mea-ext.zmailer.org>
References: <4ae3c140603182048k55d06d87ufc0b9f0548574090@mail.gmail.com> <441CE71E.5090503@gmail.com> <4ae3c140603190948s4fcd135er370a15003a0143a8@mail.gmail.com> <1142791121.31358.21.camel@localhost.localdomain> <4ae3c140603191011r7b68f4aale01238202656d122@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ae3c140603191011r7b68f4aale01238202656d122@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 19, 2006 at 01:11:41PM -0500, Xin Zhao wrote:
> Do you have any statistics on how many metadata accesses are required
> for a heavy load file system?  I don't have on in hand, but
> intuitively I think 300 per second should be enough. If storing
> metadata in database will not hit the file system performance, plus
> database allows flexible file searching, the database-based file
> system might not be a bad idea. :)
> 
> Xin

  Folks,  first of all,  DO NOT TOP POST!
You are attempting to violate causality.  (At least it looks like such.)

One thing to realize in UNIX filesystems is that they are OPTIMIZED
for finding files (with huge majority - 3 to 5 nines worth).
That means there are many cute caches to help lookups. 

Cases where directory contents are modified (e.g. creat/rename/unlink)
are considered extremely rare, and there the only really interesting
thing is correctness.

In some very odd cases a lot more files are created / destroyed in
a system, than is average - such applications include: Squid and INN.
For INN this particular detail has been known to be a bottle neck, and
thus was born Cyclic News Filesystem - a way to use pre-allocated big
files as storage space for news items.

> On 3/19/06, Ming Zhang <mingz@ele.uri.edu> wrote:
> > database can reside on a raw block device.
> >
> > but 300 metadata iops is not that fast. ;)
> >
> > ming

I should think that 300 IOPS is a lot from single PC hard-drive.
Indeed they usually can't go that fast.

Again, that is where all these marvellous caches come to play.

/Matti Aarnio
