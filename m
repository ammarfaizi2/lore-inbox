Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266794AbSKOR6b>; Fri, 15 Nov 2002 12:58:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266795AbSKOR6b>; Fri, 15 Nov 2002 12:58:31 -0500
Received: from packet.digeo.com ([12.110.80.53]:51197 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266794AbSKOR63>;
	Fri, 15 Nov 2002 12:58:29 -0500
Message-ID: <3DD5375D.96736A69@digeo.com>
Date: Fri, 15 Nov 2002 10:05:17 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Stephen C. Tweedie" <sct@redhat.com>
CC: Mark Hazell <nutts@penguinmail.com>, adilger@clusterfs.com,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [patch/2.4] ll_rw_blk stomping on bh state [Re: kernel BUG at 
 journal.c:1732! (2.4.19)]
References: <20021028111357.78197071.nutts@penguinmail.com> <20021112150711.F2837@redhat.com> <3DD140F1.F4AED387@digeo.com> <20021112185345.H2837@redhat.com> <20021115173858.S4512@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Nov 2002 18:05:18.0752 (UTC) FILETIME=[8E8E0200:01C28CD1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Stephen C. Tweedie" wrote:
> 
> Hi,
> 
> On Tue, Nov 12, 2002 at 06:53:45PM +0000, Stephen C. Tweedie wrote:
> 
> > On Tue, Nov 12, 2002 at 09:57:05AM -0800, Andrew Morton wrote:
> > > "Stephen C. Tweedie" wrote:
> > > >
> > > >                 if (maxsector < count || maxsector - count < sector) {
> > > >                         /* Yecch */
> > > >                         bh->b_state &= (1 << BH_Lock) | (1 << BH_Mapped);
> > > > ...
> > > > Folks, just which buffer flags do we want to preserve in this case?
> >
> > > Why do we want to clear any flags in there at all?  To prevent
> > > a storm of error messages from a buffer which has a silly block
> > > number?
> >
> > That's the only reason I can think of.  Simply scrubbing all the state
> > bits is totally the wrong way of going about that, of course.
> 
> So what's the vote on this?  It's a decision between clearing only the
> obvious bit (BH_Dirty) on the one hand, and keeping the code as
> unchanged as possible to reduce the possibility of introducing new
> bugs.
> 
> But frankly I can't see any convincing argument for clearing anything
> except the dirty state in this case.
> 

I'd agree with that.  And the dirty bit will already be cleared, won't it?

Maybe just treat it as an IO error and leave it at that; surely that won't
introduce any problems, given all the testing that has gone into the
error handling paths :)
