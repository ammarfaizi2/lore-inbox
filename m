Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292929AbSCEHLp>; Tue, 5 Mar 2002 02:11:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293614AbSCEHLg>; Tue, 5 Mar 2002 02:11:36 -0500
Received: from zok.SGI.COM ([204.94.215.101]:8361 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S292850AbSCEHLY>;
	Tue, 5 Mar 2002 02:11:24 -0500
Date: Mon, 4 Mar 2002 23:09:27 -0800 (PST)
From: Jeremy Higdon <jeremy@classic.engr.sgi.com>
Message-Id: <10203042309.ZM444102@classic.engr.sgi.com>
In-Reply-To: Daniel Phillips <phillips@bonn-fries.net>
        "Re: [PATCH] 2.4.x write barriers (updated for ext3)" (Mar  4,  8:57am)
In-Reply-To: <200202281536.g1SFaqF02079@localhost.localdomain> 
	<E16hl4R-0000Zx-00@starship.berlin> 
	<10203032209.ZM424559@classic.engr.sgi.com> 
	<E16hnLN-0000aV-00@starship.berlin>
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

On Mar 4,  8:57am, Daniel Phillips wrote:
> 
> On March 4, 2002 07:09 am, Jeremy Higdon wrote:
> > On Mar 4,  6:31am, Daniel Phillips wrote:
> > > On March 4, 2002 05:21 am, Jeremy Higdon wrote:
> > > > I have never heard of
> > > > any implied requirement to flush to media when a drive receives an
> > > > ordered tag and WCE is set.  It does seem like a useful feature to have
> > > > in the standard, but I don't think it's there.
> > > 
> > > It seems to be pretty strongly implied that things should work that way.
> > > What is the use of being sure the write with the ordered tag is on media
> > > if you're not sure about the writes that were supposedly supposed to
> > > precede it?  Spelling this out would indeed be helpful.
> > 
> > WCE==1 and ordered tag means that the data for previous commands is in
> > the drive buffer before the data for the ordered tag is in the drive
> > buffer.
> 
> Right, and what we're talking about is going further and requiring that WCE=0
> and ordered tag means the data for previous commands is *not* in the buffer,
> i.e., on the platter, which is the only interpretation that makes sense.


Sorry to be slow here, but if WCE=0, then commands aren't complete until
data is on the media, so since previous commands don't complete until
data is on the media, and they must complete before the ordered tag
command does, what you say would have to be the case.  I thought the idea
was to buffer commands to drive memory (so that the drive could increase
performance by writing back to back commands without losing a rev) and
then issue a command with a "flush" side effect.

Here is an interesting question.  If you use WCE=1 and then send an
ordered tag with FUA=1, does that imply that data from previous
write commands is flushed to media?  I don't think so, though it
would be a useful feature if it did.

jeremy
