Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261847AbTEHQD0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 12:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbTEHQD0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 12:03:26 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:986 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261847AbTEHQDX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 12:03:23 -0400
Date: Thu, 8 May 2003 18:16:00 +0200
From: Jens Axboe <axboe@suse.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5 ide 48-bit usage
Message-ID: <20030508161600.GE20941@suse.de>
References: <1052405215.10038.44.camel@dhcp22.swansea.linux.org.uk> <Pine.SOL.4.30.0305081748030.24013-100000@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOL.4.30.0305081748030.24013-100000@mion.elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 08 2003, Bartlomiej Zolnierkiewicz wrote:
> 
> On 8 May 2003, Alan Cox wrote:
> > On Iau, 2003-05-08 at 14:35, Bartlomiej Zolnierkiewicz wrote:
> > > Yep, you are right, hwif->addressing logic is reversed, what a mess.
> >
> > No the problem is you keep treating it as a binary value. Addressing is
> > a mode. Right now 0 is LBA28/CHS and 1 is LBA48. SATA next generation

For drive->addressing, not hwif.

> > stuff extends this even further so will I imagine be addressing=2
> 
> You are right but currently it is a binary value.
> The same goes for actual usage of drive->addressing and comment in ide.h.

Maybe a define or two would help here. When you see drive->addressing
and hwif->addressing, you assume that they are used identically. That
!hwif->addressing means 48-bit is ok, while !drive->addressing means
it's not does not help at all.

#define IDE_LBA28	0
#define IDE_LBA48	1

and then change hwif->addressing to be addressed like the drive variant
would help a whole lot.

-- 
Jens Axboe

