Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273931AbRIRVMB>; Tue, 18 Sep 2001 17:12:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273929AbRIRVLp>; Tue, 18 Sep 2001 17:11:45 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:47909 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S273931AbRIRVLa>; Tue, 18 Sep 2001 17:11:30 -0400
Date: Tue, 18 Sep 2001 23:11:50 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        akpm@zip.com.au
Subject: Re: 2.4.10pre11 vm rewrite fixes for mainline inclusion and testing
Message-ID: <20010918231150.H720@athlon.random>
In-Reply-To: <Pine.LNX.4.21.0109181627340.7836-100000@freak.distro.conectiva> <Pine.LNX.4.21.0109181636200.7836-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0109181636200.7836-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Tue, Sep 18, 2001 at 04:39:34PM -0300
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2001 at 04:39:34PM -0300, Marcelo Tosatti wrote:
> 
> 
> On Tue, 18 Sep 2001, Marcelo Tosatti wrote:
> 
> > 
> > 
> > On Tue, 18 Sep 2001, Andrea Arcangeli wrote:
> > 
> > (testing now)
> 
> Well, unfortunately:

I'm not so pessimistic, I was pretty sure it would have worked out.

> 
> Sep 18 17:59:01 matrix PAM_pwdb[842]: (sshd) session opened for user
> marcelo by (uid=0)
> Sep 18 17:59:27 matrix kernel: __alloc_pages: 0-order allocation failed
> (gfp=0x20/0) from c012c5fe
> Sep 18 17:59:28 matrix sshd[860]: Accepted password for marcelo from
> 10.0.17.22 port 1020
> Sep 18 17:59:29 matrix PAM_pwdb[860]: (sshd) session opened for user
> marcelo by (uid=0)
> Sep 18 17:59:42 matrix sshd[873]: Accepted password for marcelo from
> 10.0.17.22 port 1021
> Sep 18 17:59:43 matrix PAM_pwdb[873]: (sshd) session opened for user
> marcelo by (uid=0)
> Sep 18 17:59:48 matrix PAM_pwdb[875]: (su) session opened for user root by
> marcelo(uid=719)
> Sep 18 17:59:55 matrix kernel: __alloc_pages: 0-order allocation failed
> (gfp=0x20/0) from c012c5fe

That's just a GREAT log: those are GFP_ATOMIC allocations, all is _more_
than _perfect_ in the above log.

> I really think we need the "fail: loop again: try_to_free_pages()" logic,

What do you want to do with GFP_ATOMIC? we cannot do anything at the
moment unless you want to make an atomic list that we can free from
atomic context, I thought about something like that but I guess we can
do it after 2.4.11 (possibly in 2.4.x, it doesn't sound a showstopper).

> Andrea: If there is not enough memory we HAVE to block in the page
> reclaiming work.

we obviously cannot block with GFP_ATOMIC.

Andrea
