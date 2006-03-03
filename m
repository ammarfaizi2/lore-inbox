Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751166AbWCCSzS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166AbWCCSzS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 13:55:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbWCCSzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 13:55:18 -0500
Received: from smtp.osdl.org ([65.172.181.4]:51415 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750952AbWCCSzQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 13:55:16 -0500
Date: Fri, 3 Mar 2006 10:55:03 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Steve Byan <smb@egenera.com>
cc: Mark Lord <lkml@rtr.ca>, Matthias Andree <matthias.andree@gmx.de>,
       Douglas Gilbert <dougg@torque.net>, Mark Rustad <mrustad@mac.com>,
       linux-scsi@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: sg regression in 2.6.16-rc5
In-Reply-To: <CF493E39-B369-46D8-85EE-013F2484F1C6@egenera.com>
Message-ID: <Pine.LNX.4.64.0603031035140.22647@g5.osdl.org>
References: <E94491DE-8378-41DC-9C01-E8C1C91B6B4E@mac.com> <4404AA2A.5010703@torque.net>
 <20060301083824.GA9871@merlin.emma.line.org> <Pine.LNX.4.64.0603011027400.22647@g5.osdl.org>
 <4405E8AA.1090803@rtr.ca> <Pine.LNX.4.64.0603011036110.22647@g5.osdl.org>
 <CF493E39-B369-46D8-85EE-013F2484F1C6@egenera.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 3 Mar 2006, Steve Byan wrote:
> 
> On Mar 1, 2006, at 1:42 PM, Linus Torvalds wrote:
> > 
> > I wouldn't expect it to. Most people use ATA for that, and it tends to
> > have lower limits than most SCSI HBA's (well, at least the old PATA), so
> > the change - if any - should at most change some of the sg.c limits to be
> > no less than what SG_IO has had on ATA forever.
> > 
> > Not that I expect people to have a SCSI CD/DVD drive anyway in this day
> > and age, so the sg.c changes probably won't show up at all.
> 
> CD-ROM support is a frequently-requested feature on the iSCSI Enterprise
> Target (iet) email list. It won't be long before iSCSI CD and DVD devices
> start showing up, although the underlying hardware will be ATAPI or else
> missing entirely (i.e. ISO image file).

Yes, but the point that the ATA limits tend to be on the low side still 
stands.

For example, I think the IDE driver defaults to a maximum transfer of 256 
sectors, and the same number of max scatter-gather entries. Some 
controllers will actually lower that, due to silly hw problems.

The point being that it has worked fine for IDE, and if a SCSI controller 
has noticeably lower limits than that, there's something really strange 
going on, like a real bug.

			Linus
