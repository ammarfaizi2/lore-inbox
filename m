Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291806AbSCDGLU>; Mon, 4 Mar 2002 01:11:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291780AbSCDGLL>; Mon, 4 Mar 2002 01:11:11 -0500
Received: from zok.SGI.COM ([204.94.215.101]:48518 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S291775AbSCDGLF>;
	Mon, 4 Mar 2002 01:11:05 -0500
Date: Sun, 3 Mar 2002 22:09:35 -0800 (PST)
From: Jeremy Higdon <jeremy@classic.engr.sgi.com>
Message-Id: <10203032209.ZM424559@classic.engr.sgi.com>
In-Reply-To: Daniel Phillips <phillips@bonn-fries.net>
        "Re: [PATCH] 2.4.x write barriers (updated for ext3)" (Mar  4,  6:31am)
In-Reply-To: <200202281536.g1SFaqF02079@localhost.localdomain> 
	<E16heCm-0000Q5-00@starship.berlin> 
	<10203032021.ZM443706@classic.engr.sgi.com> 
	<E16hl4R-0000Zx-00@starship.berlin>
X-Mailer: Z-Mail (3.2.3 08feb96 MediaMail)
To: Daniel Phillips <phillips@bonn-fries.net>,
        James Bottomley <James.Bottomley@SteelEye.com>,
        Chris Mason <mason@suse.com>, "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: [PATCH] 2.4.x write barriers (updated for ext3)
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 4,  6:31am, Daniel Phillips wrote:
> On March 4, 2002 05:21 am, Jeremy Higdon wrote:
> > On Mar 3, 11:11pm, Daniel Phillips wrote:
> > > I have a standing offer from at least one engineer to make firmware changes 
> > > to the drives if it makes Linux work better.  So a reasonable plan is: first 
> > > know what's ideal, second ask for it.  Coupled with that, we'd need a way of 
> > > identifying drives that don't work in the ideal way, and require a fallback.
> > > 
> > > In my opinion, the only correct behavior is a write barrier that completes
> > > when data is on the platter, and that does this even when write-back is
> > > enabled.  Surely this is not rocket science at the disk firmware level.  Is
> > > this or is this not the way ordered tags were supposed to work?
> > 
> > Ordered tags just specify ordering in the command stream.  The WCE bit
> > specifies when the write command is complete.
> 
> WCE is per-command?  And 0 means no caching, so the command must complete
> when the data is on the media?

My reading is that WCE==1 means that the command is complete when the
data is in the drive buffer.

> > I have never heard of
> > any implied requirement to flush to media when a drive receives an
> > ordered tag and WCE is set.  It does seem like a useful feature to have
> > in the standard, but I don't think it's there.
> 
> It seems to be pretty strongly implied that things should work that way.
> What is the use of being sure the write with the ordered tag is on media
> if you're not sure about the writes that were supposedly supposed to
> precede it?  Spelling this out would indeed be helpful.

WCE==1 and ordered tag means that the data for previous commands is in
the drive buffer before the data for the ordered tag is in the drive
buffer.

> > So if one vendor implements those semantics, but the others don't where
> > does that leave us?
> 
> It leaves us with a vendor we want to buy our drives from, if we want our
> data to be safe.

The point is, do you write code that depends on one vendor's interpretation?
If so, then the vendor needs to be identified.  Perhaps other vendors will
then align themselves.

> Daniel

jeremy
