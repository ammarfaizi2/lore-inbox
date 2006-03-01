Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750914AbWCASmw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750914AbWCASmw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 13:42:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751807AbWCASmw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 13:42:52 -0500
Received: from smtp.osdl.org ([65.172.181.4]:17834 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750914AbWCASmv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 13:42:51 -0500
Date: Wed, 1 Mar 2006 10:42:12 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Mark Lord <lkml@rtr.ca>
cc: Matthias Andree <matthias.andree@gmx.de>,
       Douglas Gilbert <dougg@torque.net>, Mark Rustad <mrustad@mac.com>,
       linux-scsi@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: sg regression in 2.6.16-rc5
In-Reply-To: <4405E8AA.1090803@rtr.ca>
Message-ID: <Pine.LNX.4.64.0603011036110.22647@g5.osdl.org>
References: <E94491DE-8378-41DC-9C01-E8C1C91B6B4E@mac.com> <4404AA2A.5010703@torque.net>
 <20060301083824.GA9871@merlin.emma.line.org> <Pine.LNX.4.64.0603011027400.22647@g5.osdl.org>
 <4405E8AA.1090803@rtr.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 1 Mar 2006, Mark Lord wrote:

> Linus Torvalds wrote:
> > 
> > On Wed, 1 Mar 2006, Matthias Andree wrote:
> > > On Tue, 28 Feb 2006, Douglas Gilbert wrote:
> > > 
> > > > You can stop right there with the 1 MB reads. Welcome
> > > > to the new, blander sg driver which now shares many
> > > > size shortcomings with the block subsystem.
> > > What is the reason to break user-space applications like this?
> > 
> > Did you read the whole thread? It was a low-level SCSI driver issue, where
> > nothing broke user space, but the command was just fed to the drive
> > differently, which then hit a limit in the driver.
> 
> Will this break major applications like CD/DVD rippers,
> DVD players, etc.. which read LARGE blocks at a time?
> 
> If not, then good!

I wouldn't expect it to. Most people use ATA for that, and it tends to 
have lower limits than most SCSI HBA's (well, at least the old PATA), so 
the change - if any - should at most change some of the sg.c limits to be 
no less than what SG_IO has had on ATA forever.

Not that I expect people to have a SCSI CD/DVD drive anyway in this day 
and age, so the sg.c changes probably won't show up at all.

The problem that was reported was apparently for a rather special use.

			Linus
