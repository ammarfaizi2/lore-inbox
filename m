Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267361AbRGKRIV>; Wed, 11 Jul 2001 13:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267364AbRGKRIL>; Wed, 11 Jul 2001 13:08:11 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:20570 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S267361AbRGKRIB>; Wed, 11 Jul 2001 13:08:01 -0400
Date: Wed, 11 Jul 2001 19:08:21 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Brian Strand <bstrand@switchmanagement.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2x Oracle slowdown from 2.2.16 to 2.4.4
Message-ID: <20010711190821.K3496@athlon.random>
In-Reply-To: <3B4BA19C.3050706@switchmanagement.com> <20010711031556.A3496@athlon.random> <3B4C8263.6000407@switchmanagement.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B4C8263.6000407@switchmanagement.com>; from bstrand@switchmanagement.com on Wed, Jul 11, 2001 at 09:44:19AM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2001 at 09:44:19AM -0700, Brian Strand wrote:
> Our Oracle configuration is on reiserfs on lvm on Mylex.  Our workload 
> is not entirely cached, as we are working against an 8GB table, Oracle 
> is configured to use slightly more than 1GB of memory, and there is 
> always several MB/s of IO going on during our queries.  The "working 
> set" of the main table and indexes occupies over 2GB.

As I suspected there is the VM in our way. Also reiserfs could be an
issue but I am not aware of any regression on the reiserfs side, Chris?

I tend to believe it is a VM regression (and I admit, this is what I
would bet as soon as I read your report before being sure the VM was in
our way).

One way to verify this could be to run Oracle on top of rawio and then
on ext2. If it's the vm you should still get the slowdown on ext2 too
and you should run as fast as 2.2 with rawio. Most people uses Oracle on
top of rawio on top of lvm, and incidentally this is was the first
slowdown report I got about 2.4 when compared to 2.2.

Andrea
