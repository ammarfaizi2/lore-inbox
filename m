Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269568AbRHCTxR>; Fri, 3 Aug 2001 15:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269569AbRHCTxG>; Fri, 3 Aug 2001 15:53:06 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:34066 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S269568AbRHCTwu>; Fri, 3 Aug 2001 15:52:50 -0400
Message-ID: <3B6B026A.C2D741B2@zip.com.au>
Date: Fri, 03 Aug 2001 12:58:34 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Greg Louis <glouis@dynamicro.on.ca>, ext3-users <ext3-users@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: ac4 ext3 recovery failure
In-Reply-To: <3B6AFBD1.5F43B496@zip.com.au> <Pine.GSO.4.21.0108031534210.3272-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> On Fri, 3 Aug 2001, Andrew Morton wrote:
> 
> > Do you think this happened during the e2fsck run, or during the
> > actual mount?
> 
> actual mount. s/fsync_dev/fsync_no_super/ in fs/jbd/*. Already fixed
> in Alan's tree.

Ah.  Thanks.  Linus doesn't seem to have fsync_no_super(), so some
compatibility hacks will be needed there.

Why does fsync_no_super() exist?  I assume some locking changes
somewhere?

> BTW, code around the place in question looks somewhat fishy - looks
> like you have a lot of stuff assuming that journal and fs are on the
> same device.

Yes - this was fixed up when we were testing the external journal
support for 0.9.5.  -ac4 has 0.9.3+bits.

-
