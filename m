Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277330AbRJZCg1>; Thu, 25 Oct 2001 22:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277347AbRJZCgT>; Thu, 25 Oct 2001 22:36:19 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:14740 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id <S277330AbRJZCgF>; Thu, 25 Oct 2001 22:36:05 -0400
Date: Fri, 26 Oct 2001 11:36:34 +0900
Message-ID: <g087jff1.wl@nisaaru.dvs.cs.fujitsu.co.jp>
From: Tachino Nobuhiro <tachino@open.nm.fujitsu.co.jp>
To: Robert Love <rml@tech9.net>
Cc: Tachino Nobuhiro <tachino@open.nm.fujitsu.co.jp>,
        "Michael F. Robbins" <compumike@compumike.com>,
        linux-kernel@vger.kernel.org
Subject: Re: SiS/Trident 4DWave sound driver oops
In-Reply-To: <1004061741.11366.32.camel@phantasy>
In-Reply-To: <1004016263.1384.15.camel@tbird.robbins>
	<7ktjw58u.wl@nisaaru.dvs.cs.fujitsu.co.jp>
	<1004060759.11258.12.camel@phantasy>
	<6693w4ds.wl@nisaaru.dvs.cs.fujitsu.co.jp>
	<1004061741.11366.32.camel@phantasy>
User-Agent: Wanderlust/2.7.5 (Too Funky) EMY/1.13.9 (Art is long, life is short) SLIM/1.14.7 () APEL/10.3 MULE XEmacs/21.1 (patch 14) (Cuyahoga Valley) (i586-kondara-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 25 Oct 2001 22:02:20 -0400,
Robert Love wrote:
> 
> On Thu, 2001-10-25 at 21:56, Tachino Nobuhiro wrote:
> > Robert Love wrote:
> > > Hm, I don't think so.  The last area is marked zero so code can know
> > > when it ends.  This is common practice.
> > 
> > But the code does not use the last area. this is the code in
> > ac97_probe_codec().
> 
> ARRAY_SIZE(x) returns the number of elements in x, but since everything
> is 0-referenced going from 0 to i < ARRAY_SIZE isn't a problem.
> 
> ie int x[3];
> ARRAY_SIZE(x) = 3;
> but x[2] is last element... so no issue here.

  No. {0, } is the last elemnet of ac97_codec_ids[] and that index is
ARRAY_SIZE(ac97_code_ids) - 1. So this element which should be used as
a loop terminator is used as a valid entry in for loop incorrectly. 

Please read ac97_codec.c
