Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263303AbTDXLXg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 07:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263333AbTDXLXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 07:23:35 -0400
Received: from [12.47.58.68] ([12.47.58.68]:6427 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S263303AbTDXLXf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 07:23:35 -0400
Date: Thu, 24 Apr 2003 04:36:37 -0700
From: Andrew Morton <akpm@digeo.com>
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: pavel@suse.cz, cat@zip.com.au, mbligh@aracnet.com, gigerstyle@gmx.ch,
       geert@linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: Fix SWSUSP & !SWAP
Message-Id: <20030424043637.71c3812e.akpm@digeo.com>
In-Reply-To: <1051182797.2250.10.camel@laptop-linux>
References: <1051136725.4439.5.camel@laptop-linux>
	<1584040000.1051140524@flay>
	<20030423235820.GB32577@atrey.karlin.mff.cuni.cz>
	<20030423170759.2b4e6294.akpm@digeo.com>
	<20030424001733.GB678@zip.com.au>
	<1051143408.4305.15.camel@laptop-linux>
	<20030423173720.6cc5ee50.akpm@digeo.com>
	<20030424091236.GA3039@elf.ucw.cz>
	<20030424022505.5b22eeed.akpm@digeo.com>
	<20030424093534.GB3084@elf.ucw.cz>
	<20030424024613.053fbdb9.akpm@digeo.com>
	<1051182797.2250.10.camel@laptop-linux>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Apr 2003 11:35:38.0757 (UTC) FILETIME=[A115E350:01C30A55]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham <ncunningham@clear.net.nz> wrote:
>
> On Thu, 2003-04-24 at 21:46, Andrew Morton wrote:
> > > > Sorry, I still don't get it.  Go through the steps for me:
> > > > 
> > > > 1) suspend writes pages to disk
> > > > 
> > > > 2) machine is shutdown
> > > > 
> > > > 3) restart, journal replay
> 
> Corruption comes here. The journal reply tidies things up that shouldn't
> be tidied up. They shouldn't be tidied up because once we reload the
> image, things should be in the same state as prior to suspend. If replay
> frees a block (thinking it wasn't properly linked or something similar),
> it introduces corruption.

No, this will not happen.  All swapfile blocks must be allocated by swapon
time.  It is just a chunk of disk and replay will not touch it.

That's for ext3, and no other filesystems journal data anyway...
