Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262494AbTEMRP7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 13:15:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262488AbTEMRP7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 13:15:59 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:24982 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262490AbTEMRP5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 13:15:57 -0400
Date: Tue, 13 May 2003 19:28:39 +0200
From: Jens Axboe <axboe@suse.de>
To: Oliver Neukum <oliver@neukum.org>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Oleg Drokin <green@namesys.com>,
       lkhelp@rekl.yi.org, linux-kernel@vger.kernel.org
Subject: Re: 2.5.69, IDE TCQ can't be enabled
Message-ID: <20030513172839.GG17033@suse.de>
References: <200305121455.58022.oliver@neukum.org> <Pine.SOL.4.30.0305121513270.18058-100000@mion.elka.pw.edu.pl> <20030513153236.GB17033@suse.de> <200305131925.25121.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305131925.25121.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13 2003, Oliver Neukum wrote:
> Am Dienstag, 13. Mai 2003 17:32 schrieb Jens Axboe:
> > On Mon, May 12 2003, Bartlomiej Zolnierkiewicz wrote:
> > > On Mon, 12 May 2003, Oliver Neukum wrote:
> > > > > Just a note that we have found TCQ unusable on our IBM drives and we
> > > > > had some reports about TCQ unusable on some WD drives.
> > > > >
> > > > > Unusable means severe FS corruptions starting from mount.
> > > > > So if your FSs will suddenly start to break, start looking for cause
> > > > > with disabling TCQ, please.
> > > >
> > > > I can confirm that. This drive Model=IBM-DTLA-307045, FwRev=TX6OA60A,
> > > > SerialNo=YMCYMT3Y229 has eaten my filesystem with TCQ on 2.5.69
> >
> > Oliver, what hardware are you reproducing this on? The DTLA should work.
> 
> Athlon XP1600. But I am not reproducing this. I dare not. Is it important 
> enough to set up a scratch monkey? hdb did not show corruption. The raid
> controller of the motherboard isn't used. APIC was enabled, ACPI wasn't.
> The exact configuration died with the filesystem, sorry.

You don't have to reproduce, your case has two drives on a channel doing
tcq. That's not really supported, and the last patch sent should make
that scenario "work" (by not enabling tcq on any of them).

The DTTA, according to FreeBSD, has a bug with > 64K transfers. But you
said that worked fine, so...

Thanks for the feedback, much appreciated! FWIW, 2 hours of thrashing
the drive here and no problems so far.

-- 
Jens Axboe

