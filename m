Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266528AbSKORdf>; Fri, 15 Nov 2002 12:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266578AbSKORdf>; Fri, 15 Nov 2002 12:33:35 -0500
Received: from pc-62-31-74-27-ed.blueyonder.co.uk ([62.31.74.27]:32133 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S266528AbSKORcS>; Fri, 15 Nov 2002 12:32:18 -0500
Date: Fri, 15 Nov 2002 17:38:58 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andrew Morton <akpm@digeo.com>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Mark Hazell <nutts@penguinmail.com>,
       adilger@clusterfs.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [patch/2.4] ll_rw_blk stomping on bh state [Re: kernel BUG at journal.c:1732! (2.4.19)]
Message-ID: <20021115173858.S4512@redhat.com>
References: <20021028111357.78197071.nutts@penguinmail.com> <20021112150711.F2837@redhat.com> <3DD140F1.F4AED387@digeo.com> <20021112185345.H2837@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021112185345.H2837@redhat.com>; from sct@redhat.com on Tue, Nov 12, 2002 at 06:53:45PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Nov 12, 2002 at 06:53:45PM +0000, Stephen C. Tweedie wrote:
 
> On Tue, Nov 12, 2002 at 09:57:05AM -0800, Andrew Morton wrote:
> > "Stephen C. Tweedie" wrote:
> > > 
> > >                 if (maxsector < count || maxsector - count < sector) {
> > >                         /* Yecch */
> > >                         bh->b_state &= (1 << BH_Lock) | (1 << BH_Mapped);
> > > ...
> > > Folks, just which buffer flags do we want to preserve in this case?
> 
> > Why do we want to clear any flags in there at all?  To prevent
> > a storm of error messages from a buffer which has a silly block
> > number?
> 
> That's the only reason I can think of.  Simply scrubbing all the state
> bits is totally the wrong way of going about that, of course.

So what's the vote on this?  It's a decision between clearing only the
obvious bit (BH_Dirty) on the one hand, and keeping the code as
unchanged as possible to reduce the possibility of introducing new
bugs.

But frankly I can't see any convincing argument for clearing anything
except the dirty state in this case.

--Stephen
