Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291745AbSCDFgP>; Mon, 4 Mar 2002 00:36:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291759AbSCDFgG>; Mon, 4 Mar 2002 00:36:06 -0500
Received: from dsl-213-023-043-059.arcor-ip.net ([213.23.43.59]:24977 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S291741AbSCDFfu>;
	Mon, 4 Mar 2002 00:35:50 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Jeremy Higdon <jeremy@classic.engr.sgi.com>,
        James Bottomley <James.Bottomley@SteelEye.com>,
        Chris Mason <mason@suse.com>, "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: [PATCH] 2.4.x write barriers (updated for ext3)
Date: Mon, 4 Mar 2002 06:31:34 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <200202281536.g1SFaqF02079@localhost.localdomain> <E16heCm-0000Q5-00@starship.berlin> <10203032021.ZM443706@classic.engr.sgi.com>
In-Reply-To: <10203032021.ZM443706@classic.engr.sgi.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16hl4R-0000Zx-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On March 4, 2002 05:21 am, Jeremy Higdon wrote:
> On Mar 3, 11:11pm, Daniel Phillips wrote:
> > I have a standing offer from at least one engineer to make firmware changes 
> > to the drives if it makes Linux work better.  So a reasonable plan is: first 
> > know what's ideal, second ask for it.  Coupled with that, we'd need a way of 
> > identifying drives that don't work in the ideal way, and require a fallback.
> > 
> > In my opinion, the only correct behavior is a write barrier that completes
> > when data is on the platter, and that does this even when write-back is
> > enabled.  Surely this is not rocket science at the disk firmware level.  Is
> > this or is this not the way ordered tags were supposed to work?
> 
> Ordered tags just specify ordering in the command stream.  The WCE bit
> specifies when the write command is complete.

WCE is per-command?  And 0 means no caching, so the command must complete
when the data is on the media?

> I have never heard of
> any implied requirement to flush to media when a drive receives an
> ordered tag and WCE is set.  It does seem like a useful feature to have
> in the standard, but I don't think it's there.

It seems to be pretty strongly implied that things should work that way.
What is the use of being sure the write with the ordered tag is on media
if you're not sure about the writes that were supposedly supposed to
precede it?  Spelling this out would indeed be helpful.

> So if one vendor implements those semantics, but the others don't where
> does that leave us?

It leaves us with a vendor we want to buy our drives from, if we want our
data to be safe.

-- 
Daniel
