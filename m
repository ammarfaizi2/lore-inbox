Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317474AbSG2BY1>; Sun, 28 Jul 2002 21:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317478AbSG2BY1>; Sun, 28 Jul 2002 21:24:27 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6931 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317474AbSG2BY0>;
	Sun, 28 Jul 2002 21:24:26 -0400
Message-ID: <3D449C14.46683B2A@zip.com.au>
Date: Sun, 28 Jul 2002 18:36:20 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH 2.5] Introduce 64-bit versions of 
 PAGE_{CACHE_,}{MASK,ALIGN}
References: <5.1.0.14.2.20020728193528.04336a80@pop.cus.cam.ac.uk> <Pine.LNX.4.44.0207281622350.8208-100000@home.transmeta.com> <3D448808.CF8D18BA@zip.com.au> <20020729005649.GT25038@holomorphy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> 
> On Sun, Jul 28, 2002 at 05:10:48PM -0700, Andrew Morton wrote:
> > - Few pages use ->private for much.  Hash for it.  4(ish) bytes
> >   saved.
> 
> Do you know an approximate reasonable constant of proportionality
> for how many pages have ->private attached?

Well, it depends on what the mapping is using ->private for.
In the case of ext2, ext3 and (soon) reiserfs mappings, ->private
is only used for pagecache pages which were written to with write(2).

But for other filesystems, basically all pagecache pages have
buffers at present, so I exaggerate.  But as filesystems migrate
to using direct-to-BIO reads, the situation gets better.

It might be useful to buffer-strip written-to pages as well, if
a clean way of doing that presents itself.  Maybe in refill_inactive
or something.

> On Sun, Jul 28, 2002 at 05:10:48PM -0700, Andrew Morton wrote:
> > - Remove the rmap chain (I just broke ptep_to_address() anyway).  4 bytes
> >   saved.  struct page is now 20 bytes.
> 
> How did ptep_to_address() break? I browsed over your latest changes and
> missed the bit where that fell apart. I'll at least take a stab at fixing
> it up until the other bits materialize.

I broke it in my five-minute thought-coding exercise.  By removing
page->index.

-
