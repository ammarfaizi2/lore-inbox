Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267561AbUHEFri@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267561AbUHEFri (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 01:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267557AbUHEFrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 01:47:37 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:3473 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S267561AbUHEFrY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 01:47:24 -0400
Date: Thu, 5 Aug 2004 07:47:12 +0200
From: Jens Axboe <axboe@suse.de>
To: "H.Rosmanith (Kernel Mailing List)" <kernel@wildsau.enemy.org>
Cc: linux-kernel@vger.kernel.org, schilling@fokus.fraunhofer.de
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-ID: <20040805054712.GF10376@suse.de>
References: <20040804125818.GM10340@suse.de> <200408050056.i750ujfQ010136@wildsau.enemy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408050056.i750ujfQ010136@wildsau.enemy.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05 2004, H.Rosmanith (Kernel Mailing List) wrote:
> > On Wed, Aug 04 2004, Jens Axboe wrote:
> > > > + * Sat Jun 12 12:48:12 CEST 2004 herp - Herbert Rosmanith
> > > > + *     Force ATAPI driver if dev= starts with /dev/hd and device
> > > > + *     is present in /proc/ide/hdX
> > > > + *
> > > 
> > > That's an extremely bad idea, you want to force ATA driver in either
> > > case.
> > 
> > Which, happily, is what already happens and why it works fine when you
> 
> okay - my last email in this matter to LKML, but: it seems to only work
> fine if you use ide-scsi and configure it acordingly. on our system, where
> I have disabled scsi completely (ide-scsi doesnt work at all for certain
> tasks, and beside from that, I need scsi), cdrecord/cdrtools will
> terminate with "Cannot open /dev/hdX. Cannot open SCSI driver".
> 
> this is the reason why the patch forces the ata (atapi?) driver. no
> SCSI driver or configuring of ide-scsi required.

Maybe newer version broke then. Until very recently, cdrecord worked
just fine as-is and used SG_IO access method when you used open by
device name. Which was just the way we wanted it.

If that doesn't work now, I suggest you take it up with Joerg. It's a
problem with his program.

> > just do -dev=/dev/hdX. What should be removed is the warning that
> > cdrecord spits out when you do this, and the whole ATAPI thing
> > should just mirror ATA and scsi-linux-ata be killed completely.
> > 
> > So I suggest you do that instead and send it to Joerg,
> > cdrecord/cdrtool
> 
> well, sigh .... been there, done that, but emails to Joerg seem to
> have a long RTT. therefore, LKML. sorry for the inconvenience :->

Is there no cdrecord list? lkml surely isn't appropriate.

-- 
Jens Axboe

