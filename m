Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264337AbTDXA4u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 20:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264346AbTDXA4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 20:56:50 -0400
Received: from [12.47.58.232] ([12.47.58.232]:46020 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264337AbTDXA4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 20:56:49 -0400
Date: Wed, 23 Apr 2003 18:06:46 -0700
From: Andrew Morton <akpm@digeo.com>
To: CaT <cat@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fix SWSUSP & !SWAP
Message-Id: <20030423180646.14854676.akpm@digeo.com>
In-Reply-To: <20030424005436.GF678@zip.com.au>
References: <1051136725.4439.5.camel@laptop-linux>
	<1584040000.1051140524@flay>
	<20030423235820.GB32577@atrey.karlin.mff.cuni.cz>
	<20030423170759.2b4e6294.akpm@digeo.com>
	<20030424001733.GB678@zip.com.au>
	<1051143408.4305.15.camel@laptop-linux>
	<20030423172628.0f71ab64.rddunlap@osdl.org>
	<20030423173837.08202f0b.akpm@digeo.com>
	<20030424005436.GF678@zip.com.au>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Apr 2003 01:08:50.0428 (UTC) FILETIME=[10C64BC0:01C309FE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CaT <cat@zip.com.au> wrote:
>
> On Wed, Apr 23, 2003 at 05:38:37PM -0700, Andrew Morton wrote:
> > "Randy.Dunlap" <rddunlap@osdl.org> wrote:
> > >
> > > That may be simple for you, but for lots of users, adding a partition
> > > (to a ususally full disk drive) isn't simple.  It means backups,
> > > shrink a filesystem, shrink a partition, add a partition, and run
> > > mkswap on it.   Yes, the latter 2 are simple, but the former ones
> > > are not.
> > 
> > Yeah.  swsusp is pretty much the only reason why you would want to have a
> > swap partition at all in a 2.5/2.6 kernel.
> 
> Is there really no difference any longer in terms of speed?

Nope.  Not unless the swapfile which you created is splattered all over the
disk, in whcih case you already have serious problems with that filesystem.

There will some performance differences with resume, because it is doing
page-at-a-time synchronous IO.  The device-level caching should make that
acceptable though.

