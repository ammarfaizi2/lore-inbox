Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293534AbSCEXBo>; Tue, 5 Mar 2002 18:01:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293650AbSCEXBf>; Tue, 5 Mar 2002 18:01:35 -0500
Received: from dsl-213-023-039-135.arcor-ip.net ([213.23.39.135]:33954 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S293517AbSCEXBU>;
	Tue, 5 Mar 2002 18:01:20 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Jeremy Higdon <jeremy@classic.engr.sgi.com>,
        James Bottomley <James.Bottomley@SteelEye.com>,
        Chris Mason <mason@suse.com>, "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: [PATCH] 2.4.x write barriers (updated for ext3)
Date: Tue, 5 Mar 2002 23:56:57 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <200202281536.g1SFaqF02079@localhost.localdomain> <E16hnLN-0000aV-00@starship.berlin> <10203042309.ZM444102@classic.engr.sgi.com>
In-Reply-To: <10203042309.ZM444102@classic.engr.sgi.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16iNrd-0002lO-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On March 5, 2002 08:09 am, Jeremy Higdon wrote:
> On Mar 4,  8:57am, Daniel Phillips wrote:
> > 
> > On March 4, 2002 07:09 am, Jeremy Higdon wrote:
> > > On Mar 4,  6:31am, Daniel Phillips wrote:
> > > > On March 4, 2002 05:21 am, Jeremy Higdon wrote:
> > > > > I have never heard of
> > > > > any implied requirement to flush to media when a drive receives an
> > > > > ordered tag and WCE is set.  It does seem like a useful feature to have
> > > > > in the standard, but I don't think it's there.
> > > > 
> > > > It seems to be pretty strongly implied that things should work that way.
> > > > What is the use of being sure the write with the ordered tag is on media
> > > > if you're not sure about the writes that were supposedly supposed to
> > > > precede it?  Spelling this out would indeed be helpful.
> > > 
> > > WCE==1 and ordered tag means that the data for previous commands is in
> > > the drive buffer before the data for the ordered tag is in the drive
> > > buffer.
> > 
> > Right, and what we're talking about is going further and requiring that WCE=0
> > and ordered tag means the data for previous commands is *not* in the buffer,
> > i.e., on the platter, which is the only interpretation that makes sense.
> 
> Sorry to be slow here, but if WCE=0, then commands aren't complete until
> data is on the media,

Sorry, I meant FUA, not WCE.  For this error I offer the apology that there
is a whole new set of TLA's to learn here, and I started yesterday.

> so since previous commands don't complete until
> data is on the media, and they must complete before the ordered tag
> command does, what you say would have to be the case.  I thought the idea
> was to buffer commands to drive memory (so that the drive could increase
> performance by writing back to back commands without losing a rev) and
> then issue a command with a "flush" side effect.
> 
> Here is an interesting question.  If you use WCE=1 and then send an
> ordered tag with FUA=1, does that imply that data from previous
> write commands is flushed to media?  I don't think so, though it
> would be a useful feature if it did.

That's my point all right.  And what I tried to say is, it's useless to
have it otherwise, so we should now start beating up drive makers to do it
this way (I don't think they'll need a lot of convincing actually) and we
should write a test procedure to determine which drives do it correctly,
according to our definition of correctness.  If we agree on what is
correct of course.

-- 
Daniel
