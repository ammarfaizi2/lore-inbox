Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317463AbSG2BeC>; Sun, 28 Jul 2002 21:34:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317471AbSG2BeB>; Sun, 28 Jul 2002 21:34:01 -0400
Received: from holomorphy.com ([66.224.33.161]:25770 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317463AbSG2BeB>;
	Sun, 28 Jul 2002 21:34:01 -0400
Date: Sun, 28 Jul 2002 18:37:02 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH 2.5] Introduce 64-bit versions of PAGE_{CACHE_,}{MASK,ALIGN}
Message-ID: <20020729013702.GV25038@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@zip.com.au>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <5.1.0.14.2.20020728193528.04336a80@pop.cus.cam.ac.uk> <Pine.LNX.4.44.0207281622350.8208-100000@home.transmeta.com> <3D448808.CF8D18BA@zip.com.au> <20020729005649.GT25038@holomorphy.com> <3D449C14.46683B2A@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <3D449C14.46683B2A@zip.com.au>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> Do you know an approximate reasonable constant of proportionality
>> for how many pages have ->private attached?

On Sun, Jul 28, 2002 at 06:36:20PM -0700, Andrew Morton wrote:
> Well, it depends on what the mapping is using ->private for.
> In the case of ext2, ext3 and (soon) reiserfs mappings, ->private
> is only used for pagecache pages which were written to with write(2).
> But for other filesystems, basically all pagecache pages have
> buffers at present, so I exaggerate.  But as filesystems migrate
> to using direct-to-BIO reads, the situation gets better.
> It might be useful to buffer-strip written-to pages as well, if
> a clean way of doing that presents itself.  Maybe in refill_inactive
> or something.

Collecting some numbers might be useful here.


On Sun, Jul 28, 2002 at 05:10:48PM -0700, Andrew Morton wrote:
>>> - Remove the rmap chain (I just broke ptep_to_address() anyway).  4 bytes
>>>   saved.  struct page is now 20 bytes.

William Lee Irwin III wrote:
>> How did ptep_to_address() break? I browsed over your latest changes and
>> missed the bit where that fell apart. I'll at least take a stab at fixing
>> it up until the other bits materialize.

On Sun, Jul 28, 2002 at 06:36:20PM -0700, Andrew Morton wrote:
> I broke it in my five-minute thought-coding exercise.  By removing
> page->index.

Sorry, I took fixing up the users as part of the ->index removal. This
isn't a serious issue.


Cheers,
Bill
