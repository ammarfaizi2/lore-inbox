Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318093AbSG2VG4>; Mon, 29 Jul 2002 17:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318095AbSG2VGz>; Mon, 29 Jul 2002 17:06:55 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:5880 "EHLO e1.ny.us.ibm.com.")
	by vger.kernel.org with ESMTP id <S318093AbSG2VGy>;
	Mon, 29 Jul 2002 17:06:54 -0400
Subject: Re: [PATCH] vfs_read/vfs_write small bug fix (2.5.29)
From: Paul Larson <plars@austin.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <ai47gn$1dh$1@penguin.transmeta.com>
References: <200207291825.g6TIPj026021@eng2.beaverton.ibm.com> 
	<ai47gn$1dh$1@penguin.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 29 Jul 2002 16:06:52 -0500
Message-Id: <1027976813.7699.214.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-07-29 at 15:11, Linus Torvalds wrote:

> The fact is, the test for a negative "pos" should not be in
> vfs_read/write at all, since it can only happen for pread/pwrite.
That's where LTP has been seeing it fail.
 
> And pread/pwrite do not even _take_ a "loff_t" argument, they take a
> "off_t", and yet we've just happily claiming they do a loff_t, which
> means that they shouldn't work at all unless by pure changce user space
> happens to put a zero in memory in the right place.
> 
> Cristoph, I think you're the one that did this re-org. I think the code
> is wrong, and the right fix is something along these lines (untested,
> you get brownie-points for testing against some standards test).
> 
> 		Linus

This passes all the LTP pread and pwrite tests.

Thanks,
Paul Larson
Linux Test Project
http://ltp.sourceforge.net

