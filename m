Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271105AbTHCJxM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 05:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271110AbTHCJxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 05:53:12 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:25754 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S271105AbTHCJxJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 05:53:09 -0400
Date: Sun, 3 Aug 2003 11:52:52 +0200
From: Jens Axboe <axboe@suse.de>
To: Erik Andersen <andersen@codepoet.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andries Brouwer <aebr@win.tue.nl>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] ide-disk.c rev 1.13 killed CONFIG_IDEDISK_STROKE
Message-ID: <20030803095252.GN7920@suse.de>
References: <20030802124536.GB3689@win.tue.nl> <Pine.SOL.4.30.0308021506550.7779-100000@mion.elka.pw.edu.pl> <20030802174229.GA3741@win.tue.nl> <1059858379.20305.23.camel@dhcp22.swansea.linux.org.uk> <20030802233438.GA7652@codepoet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030802233438.GA7652@codepoet.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 02 2003, Erik Andersen wrote:
> On Sat Aug 02, 2003 at 10:06:19PM +0100, Alan Cox wrote:
> > On Sad, 2003-08-02 at 18:42, Andries Brouwer wrote:
> > > OK, so we have to investigate. This strange test was inserted
> > > in 2.4 and 2.5 via Alan, and google gives me Alan's changelog:
> > > 
> > > Linux 2.5.66-ac1
> > > o Don't issue WIN_SET_MAX on older drivers (Jens Axboe)
> > >   (Breaks some Samsung)
> > 
> > Some older Samsung drives don't abort WIN_SET_MAX but the firmware
> > hangs hence the check.
> 
> Ok, I think I can actually test that one.
> 
>     <rummages in ye olde box of hardware>
> 
> Cool, found it, I have an ancient Samsung SHD-3212A (426MB)
> drive that will hopefully show the problem.
> 
>     <sound of testing in the distance>
> 
> Ok, found the problem.  The current code (in addition to being
> badly written) does not even bother to test if the drive supports
> the HPA feature set before issuing a WIN_SET_MAX call.  In my
> case, it didn't crash my Samsung drive, but it certainly did make
> it complain rather loudly.
> 
> I have rewritten the init_idedisk_capacity() function and taught
> it to behave itself.  It is now much cleaner IMHO, and will only
> issues SET_MAX* calls to drives that claim they support such
> things.  I've tested this patch with a 200GB drive, a 120GB
> drive, an 80GB drive and my ancient Samsung drive and in each
> case (48bit LBA, 28bit LBA, 28bit CHS w/o support for HPA), my
> new version appears to the Right Thing(tm).
> 
> Attached is a patch vs 2.4.22-pre10, and a patch vs 2.6.0-pre2. 
> Please apply,

Very nice Erik, looks good!

-- 
Jens Axboe

