Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262482AbTDXJdQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 05:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262502AbTDXJdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 05:33:15 -0400
Received: from [12.47.58.68] ([12.47.58.68]:47894 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S262482AbTDXJdO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 05:33:14 -0400
Date: Thu, 24 Apr 2003 02:46:13 -0700
From: Andrew Morton <akpm@digeo.com>
To: Pavel Machek <pavel@suse.cz>
Cc: ncunningham@clear.net.nz, cat@zip.com.au, mbligh@aracnet.com,
       gigerstyle@gmx.ch, geert@linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: Fix SWSUSP & !SWAP
Message-Id: <20030424024613.053fbdb9.akpm@digeo.com>
In-Reply-To: <20030424093534.GB3084@elf.ucw.cz>
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
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Apr 2003 09:45:15.0617 (UTC) FILETIME=[3562ED10:01C30A46]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> wrote:
>
> Hi!
> 
> > > No, ext3 will be "unclean" during resume (you can't really unmount it
> > > during suspend!) and r-o mounting of ext3 will replay journal and
> > > cause data corruption.
> > 
> > Sorry, I still don't get it.  Go through the steps for me:
> > 
> > 1) suspend writes pages to disk
> > 
> > 2) machine is shutdown
> > 
> > 3) restart, journal replay
> > 
> > 4) resume reads pages from disk.
> 
> And now you have kernel which expects data still in journal (that was
> state before suspend), but reality on disk is quite different (journal
> was replayed). Data corruption.

swapfiles are not journalled - the swap a_ops write direct to the swapfile's
blocks with submit_bio().  Journal replay wouldn't touch the swapfile.

I can see that locating the swapfile for the resume-time swapon could be a
problem, but the corruption thing still escapes me.

