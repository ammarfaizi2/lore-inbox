Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319463AbSIGJyk>; Sat, 7 Sep 2002 05:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319464AbSIGJyk>; Sat, 7 Sep 2002 05:54:40 -0400
Received: from dsl-213-023-038-028.arcor-ip.net ([213.23.38.28]:21943 "EHLO
	starship") by vger.kernel.org with ESMTP id <S319463AbSIGJyj>;
	Sat, 7 Sep 2002 05:54:39 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@zip.com.au>, Chuck Lever <cel@citi.umich.edu>
Subject: Re: invalidate_inode_pages in 2.5.32/3
Date: Sat, 7 Sep 2002 12:01:23 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0209051023490.5579-100000@dexter.citi.umich.edu> <3D77A22A.DC3F4D1@zip.com.au> <E17naX2-0006O0-00@starship>
In-Reply-To: <E17naX2-0006O0-00@starship>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17ncP5-0006QC-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 07 September 2002 10:01, Daniel Phillips wrote:
> On Thursday 05 September 2002 20:27, Andrew Morton wrote:
> > But be aware that invalidate_inode_pages has always been best-effort.
> > If someone is reading, or writing one of those pages then it
> > certainly will not be removed.  If you need assurances that the
> > pagecache has been taken down then we'll need something stronger
> > in there.
> 
> But what is stopping us now from removing a page from the page cache
> even while IO is in progress?  (Practical issue: the page lock, but
> that's a self-fullfilling prophesy.)

Never mind, I can see that the main function of the page lock here is to 
allow the filesystem to know there's no IO in progress on a block and so the 
block can be recovered and used for something else.  Leaving the page in the 
page cache during IO is a simple means of keeping track of this.

All the same, I have deep misgivings about the logic of the vfs truncate path 
in general, and given all the trouble it's caused historically, there's good 
reason to.  I don't know, it may be perfect the way it is, but history would 
suggest otherwise.

-- 
Daniel
