Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274809AbRJaAEp>; Tue, 30 Oct 2001 19:04:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276670AbRJaAEg>; Tue, 30 Oct 2001 19:04:36 -0500
Received: from islay.mach.uni-karlsruhe.de ([129.13.162.92]:24232 "EHLO
	mailout.plan9.de") by vger.kernel.org with ESMTP id <S275990AbRJaAEY>;
	Tue, 30 Oct 2001 19:04:24 -0500
Date: Wed, 31 Oct 2001 01:05:00 +0100
From: <pcg@goof.com ( Marc) (A.) (Lehmann )>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.13-ac5 && vtun not working
Message-ID: <20011031010500.B383@schmorp.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20011030021740.A8708@schmorp.de> <20011030021740.A8708@schmorp.de> <5.1.0.14.0.20011029174700.08e93090@mail1> <20011030021740.A8708@schmorp.de> <20011030023933.A11774@schmorp.de> <5.1.0.14.0.20011029174700.08e93090@mail1> <20011029.175312.26299226.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5.1.0.14.0.20011029174700.08e93090@mail1> <20011029.175312.26299226.davem@redhat.com>
X-Operating-System: Linux version 2.4.13-ac5 (root@cerebro) (gcc version 2.95.4 20010319 (prerelease)) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2001 at 05:53:12PM -0800, "David S. Miller" <davem@redhat.com> wrote:
> Basically, don't pass a string lack one "%d" into dev_alloc_name
> because dev_alloc_name() runs sprintf on that string with an
> integer argument.

I fail to follow you - yes, dev_alloc_name calls sprintf on it, but
sprintf works fine on strings without "%d", and dev_alloc_name also works
fine (despite a little suboptimal).

On Mon, Oct 29, 2001 at 05:48:35PM -0800, Maksim Krasnyanskiy <maxk@qualcomm.com> wrote:
> >(oh, and after reading the comments int hat file, I think that maybe tun.c
> >simply shouldn't call dev_alloc_name...)
> Hmm, let me check that. 
> I was under the assumption that it's dev.c bug :)

well, reading the part again it seems that dev_alloc_name is not "allocating
a name" but just looking for a free one. If it is indeed logically allocating
the devicename then it's a bug in dev.c. If it is just used to find a free
existing name, then it's a bug in tun.c (and elsewhere), in that it simply
shouldn't call dev_alloc_name, but instead allocates the name itself.

my personal opinion is that dev_alloc_name should work, as it would be the
logical place to do this stuff, an abstraction. it could be coded more
efficiently, but it doesn't seem to be a terrible important place anyways.

but I also must admit that I, well, know nothing ;)

-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@goof.com      |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |
