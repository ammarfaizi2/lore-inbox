Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274680AbRITWiB>; Thu, 20 Sep 2001 18:38:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274684AbRITWhw>; Thu, 20 Sep 2001 18:37:52 -0400
Received: from [195.223.140.107] ([195.223.140.107]:5622 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S274680AbRITWhk>;
	Thu, 20 Sep 2001 18:37:40 -0400
Date: Fri, 21 Sep 2001 00:37:42 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Robert Love <rml@tech9.net>
Cc: Dieter =?iso-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Andrew Morton <akpm@zip.com.au>, Chris Mason <mason@suse.com>,
        Beau Kuiper <kuib-kl@ljbc.wa.edu.au>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: [PATCH] Significant performace improvements on reiserfs systems
Message-ID: <20010921003742.I729@athlon.random>
In-Reply-To: <20010920170812.CCCACE641B@ns1.suse.com> <3BAA29C2.A9718F49@zip.com.au> <1001019170.6090.134.camel@phantasy> <200109202112.f8KLCXG16849@zero.tech9.net> <1001024694.6048.246.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1001024694.6048.246.camel@phantasy>; from rml@tech9.net on Thu, Sep 20, 2001 at 06:24:48PM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2001 at 06:24:48PM -0400, Robert Love wrote:
> On Thu, 2001-09-20 at 17:11, Dieter Nützel wrote:
> > > I am putting together a conditional scheduling patch to fix some of the
> > > worst cases, for use in conjunction with the preemption patch, and this
> > > might be useful.
> > 
> > The conditional_schedule() function hampered me from running it already.
> 
> hrm, i didnt notice that conditional_schedule wasnt defined in that
> patch.  you will need to do it, but do something more like
> 
> if (current->need_resched && current->lock_depth == 0) {
> 	unlock_kernel();
> 	lock_kernel();
> }
> 
> like Andrew wrote.

nitpicking: the above is fine but it isn't complete, it may work for
most cases but for a generic function it would be better implemented
similarly to release_kernel_lock_save/restore so you take care of
lock_depth > 0 too:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.2/2.2.20pre10aa1/72_copy-user-unlock-1

Andrea
