Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132701AbRD3D5x>; Sun, 29 Apr 2001 23:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132057AbRD3D5n>; Sun, 29 Apr 2001 23:57:43 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:5738 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S130768AbRD3D5d>; Sun, 29 Apr 2001 23:57:33 -0400
To: Andrea Arcangeli <andrea@suse.de>
Cc: "Magnus Naeslund(f)" <mag@fbab.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Alpha compile problem solved by Andrea (pte_alloc)
In-Reply-To: <052901c0ceca$e6a543c0$020a0a0a@totalmef> <20010427155246.O16020@athlon.random> <m1k843qoc1.fsf@frodo.biederman.org> <20010430014653.C923@athlon.random>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 29 Apr 2001 21:55:06 -0600
In-Reply-To: Andrea Arcangeli's message of "Mon, 30 Apr 2001 01:46:53 +0200"
Message-ID: <m1g0erqbxh.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> writes:

> On Sun, Apr 29, 2001 at 05:27:10PM -0600, Eric W. Biederman wrote:
> > 
> > Do you know if anyone has fixed the lazy vmalloc code?  I know of
> > as of early 2.4 it was broken on alpha.  At the time I noticed it I didn't
> > have time to persue it, but before I forget to even put in a bug
> > report I thought I'd ask if you know anything about it?
> 
> On alpha it's racy if you set CONFIG_ALPHA_LARGE_VMALLOC y (so don't do
> that as you don't need it). As long as you use only 1 entry of the pgd
> for the whole vmalloc space (CONFIG_ALPHA_LARGE_VMALLOC n) alpha is
> safe.

Hmm. I was having problems reproducible with
CONFIG_ALPHA_LARGE_VMALLOC n.

Enabling the large vmalloc was my work around, because the large
vmalloc whet back to the prelazy allocation code.

I was getting repeatable problems inside of an mtd driver.  The
problem I had was entries failed to propagate across different tasks.
I think it was something like the first pgd was lazily allocated and
not propagated.   

I don't have a SRM on my 264 alpha so alpha (for reference on which
code paths were followed.

> 
> OTOH x86 is racy and there's no workaround available at the moment.

GH

Well racy is easier to work with than just plain non-functional. 

Eric

