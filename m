Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281161AbRKZDfw>; Sun, 25 Nov 2001 22:35:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281455AbRKZDfm>; Sun, 25 Nov 2001 22:35:42 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:12812 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S281161AbRKZDfe>; Sun, 25 Nov 2001 22:35:34 -0500
Message-ID: <3C01B845.33314F49@zip.com.au>
Date: Sun, 25 Nov 2001 19:34:29 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Oliver Xymoron <oxymoron@waste.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ext3: kjournald and spun-down disks
In-Reply-To: <3BFF06CA.71B99D3C@zip.com.au> <Pine.LNX.4.40.0111252110490.2207-100000@waste.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Xymoron wrote:
> 
> Ok, so what's the theory behind the journal timer? Why would we want
> ext3 journal flushed more or less often than ext2 metadata given that
> they're of equivalent importance?

umm, err..  If your machine crashes, ext3 will restore its state
to that which pertained between zero and five seconds before the crash.

With ext2+fsck, things are not as clear.  Your data will be restored
to that which pertained from zero to thirty seconds prior to crash.
inodes and superblock to that which pertained from zero to thirty
five seconds before the crash, stuff like that.

A five second window is short enough for you to be confident that
everything you want is still there.   With thirty seconds, uncertainty
creeps in.

Yes, it needs to be configurable.

-
