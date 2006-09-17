Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965141AbWIQXCP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965141AbWIQXCP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 19:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965148AbWIQXCP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 19:02:15 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:43746 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965141AbWIQXCO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 19:02:14 -0400
Date: Mon, 18 Sep 2006 09:01:52 +1000
From: David Chinner <dgc@sgi.com>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: David Chinner <dgc@sgi.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, xfs-masters@oss.sgi.com,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [xfs-masters] Re: 2.6.18-rc6-mm2
Message-ID: <20060917230152.GS3034@melbourne.sgi.com>
References: <450914C4.2080607@gmail.com> <6bffcb0e0609140150n7499bf54k86e2b7da47766005@mail.gmail.com> <20060914090808.GS3024@melbourne.sgi.com> <6bffcb0e0609140229r59691de5i58d2d81f839d744e@mail.gmail.com> <6bffcb0e0609140303n72a73867qb308f5068733161c@mail.gmail.com> <6bffcb0e0609141001ic137201p6a2413f5ca915234@mail.gmail.com> <20060915025745.GM3034@melbourne.sgi.com> <20060914204801.e37a112b.akpm@osdl.org> <20060915055831.GP3034@melbourne.sgi.com> <6bffcb0e0609150106u1e97020bn5788f864e68ff045@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bffcb0e0609150106u1e97020bn5788f864e68ff045@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2006 at 10:06:48AM +0200, Michal Piotrowski wrote:
> On 15/09/06, David Chinner <dgc@sgi.com> wrote:
> >On Thu, Sep 14, 2006 at 08:48:01PM -0700, Andrew Morton wrote:
> >> "BAD" is a bisection point, as per
> >> http://www.zip.com.au/~akpm/linux/patches/stuff/bisecting-mm-trees.txt.  
> >So
> >> just 2.6.18-rc6+origin.patch exhibits the failure.  That is mainline.
> >
> >Ah - thanks for explaining that for me, Andrew.
> >
> >Michal, there were several XFS fixes (4, I think) that went into -rc7.  If
> >-rc6 fails and -rc7 doesn't then we need to check if one of those fixes is
> >responsible.
> 
> As I said before "I was wrong" (I use lockdep only with -mm kernels).
> 
> >The crash doesn't match any of the symptoms we've seen from them,
> >but it's worth checking.
> 
> http://www.ussg.iu.edu/hypermail/linux/kernel/0608.1/1202.html
> 
> The problem with this bug is "bad interaction" between lockdep and
> XFS. (I forgot about this probably because lockdep was broken for me
> in 2.6.18-rc5-mm* - and previous bug appeared while mounting XFS, not
> umounting).

According to the above link, unmount was the problem as well.

I know little about lockdep, but if this really is the superblock
lock that we are oopsing on then I cannot see how XFS is involved
at all seeing as it does not ever touch the superblock lock.

I'd say the first step is to get a lockdep expert to explain why
we are oopsing here....

> 2006-07-03 locdep was merged
> 2006-07-28 - 2006-08-10 a few XFS fixes
> 
> So I guess that binary search won't solve this mystery.

Don't use lockdep with XFS yet. XFS hasn't been instrumented
with lockdep notations, so nothing good will come from using
it right now. There is work in progress to fix this, but it's not
ready yet.

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group
