Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293705AbSCAUQs>; Fri, 1 Mar 2002 15:16:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293709AbSCAUQi>; Fri, 1 Mar 2002 15:16:38 -0500
Received: from 216-42-72-159.ppp.netsville.net ([216.42.72.159]:8068 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S293705AbSCAUQZ>; Fri, 1 Mar 2002 15:16:25 -0500
Date: Fri, 01 Mar 2002 15:15:59 -0500
From: Chris Mason <mason@suse.com>
To: "Stephen C. Tweedie" <sct@redhat.com>,
        Wayne Whitney <whitney@math.berkeley.edu>
cc: LKML <linux-kernel@vger.kernel.org>, ext2-devel@lists.sourceforge.net
Subject: Re: [OOPS 2.5.5-dj2] ext3 BUG in do_get_write_access()
Message-ID: <259120000.1015013734@tiny>
In-Reply-To: <20020301194155.H2682@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0202281703130.4893-100000@mf1.private> <20020301194155.H2682@redhat.com>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Friday, March 01, 2002 07:41:55 PM +0000 "Stephen C. Tweedie" <sct@redhat.com> wrote:

> In this particular case, I think I'll just have to relax the assertion
> and cause it to printk instead of BUG()ing, because I don't want to
> lose the protection of this test entirely.  
> 
> I'd really like to be able to detect such direct buffered-io
> "interference" from user-space, though, so that I could preserve the
> BUG() in cases where ext3 is getting this wrong internally.  I'll look
> at that --- I may be able to achieve it through ext3's existing
> metadata flags.

Do I misunderstand the assertion?  It seems to be saying:

'this buffer has been written out of order.  If we were to crash 
now, it will result in FS corruption'.
BUG()

If so, a printk alone might be better, since it would give the FS
the chance to put the correct data there anyway.

-chris



