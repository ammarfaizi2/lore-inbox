Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261927AbTDXJCC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 05:02:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261962AbTDXJCC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 05:02:02 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:53421 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S261927AbTDXJCB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 05:02:01 -0400
Date: Thu, 24 Apr 2003 11:12:36 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@digeo.com>
Cc: Nigel Cunningham <ncunningham@clear.net.nz>, cat@zip.com.au,
       mbligh@aracnet.com, gigerstyle@gmx.ch, geert@linux-m68k.org,
       linux-kernel@vger.kernel.org
Subject: Re: Fix SWSUSP & !SWAP
Message-ID: <20030424091236.GA3039@elf.ucw.cz>
References: <1051136725.4439.5.camel@laptop-linux> <1584040000.1051140524@flay> <20030423235820.GB32577@atrey.karlin.mff.cuni.cz> <20030423170759.2b4e6294.akpm@digeo.com> <20030424001733.GB678@zip.com.au> <1051143408.4305.15.camel@laptop-linux> <20030423173720.6cc5ee50.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030423173720.6cc5ee50.akpm@digeo.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > I'm curious. What does a swapfile solve that a swapdev does not? Either
> > > way you need to prealloc the case (either have a chunky file in a
> > > partition or a partition set aside) or you need to keep enough room
> > > avail to fit the file when it's needed.
> > 
> > Nothing but further bloat in swsusp :> With a swapfile, we need to know
> > the location of the file (and be able to find it again when it changes,
> > and know how to find the next block in the file system - it might be
> > fragmented).
> 
> That's because swsusp is using the mm/page_io.c functions for suspend, but
> is using the fs/buffer.c functions direct to the blockdev for resume.
> 
> If you can use the swapper_space a_ops for both suspend and resume (say:
> "cleanup") then it will just work.

No, ext3 will be "unclean" during resume (you can't really unmount it
during suspend!) and r-o mounting of ext3 will replay journal and
cause data corruption.
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
