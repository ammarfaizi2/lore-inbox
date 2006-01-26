Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932402AbWAZSyD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932402AbWAZSyD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 13:54:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932403AbWAZSyC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 13:54:02 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:27676 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932402AbWAZSyA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 13:54:00 -0500
Date: Thu, 26 Jan 2006 19:56:13 +0100
From: Jens Axboe <axboe@suse.de>
To: Edward Shishkin <edward@namesys.com>
Cc: Hans Reiser <reiser@namesys.com>, LKML <linux-kernel@vger.kernel.org>,
       Reiserfs mail-list <Reiserfs-List@namesys.com>
Subject: Re: random minor benchmark: Re: Copy 20 tarfiles: ext2 vs (reiser4, unixfile) vs (reiser4,cryptcompress)
Message-ID: <20060126185612.GM4311@suse.de>
References: <43D7C6BE.1010804@namesys.com> <43D7CA7F.4010502@namesys.com> <20060126153343.GH4311@suse.de> <43D91225.3030605@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43D91225.3030605@namesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26 2006, Edward Shishkin wrote:
> Jens Axboe wrote:
> 
> >On Wed, Jan 25 2006, Hans Reiser wrote:
> > 
> >
> >>Notice how CPU speed (and number of cpus) completely determines
> >>compression performance.
> >>
> >>cryptcompress refers to the reiser4 compression plugin, (unix file)
> >>refers to the reiser4 non-compressing plugin.
> >>
> >>Edward Shishkin wrote:
> >>
> >>   
> >>
> >>>Here are the tests that vs asked for:
> >>>Creation (dd) of 20 tarfiles (the original 200M file is in ramfs)
> >>>Kernel: 2.6.15-mm4 + current git snapshot of reiser4
> >>>
> >>>------------------------------------------
> >>>
> >>>Laputa workstation
> >>>Uni Intel Pentium 4 (2.26 GHz) 512M RAM
> >>>
> >>>ext2:
> >>>real 2m, 15s
> >>>sys 0m, 14s
> >>>
> >>>reiser4(unix file)
> >>>real 2m, 7s
> >>>sys  0m, 23s
> >>>
> >>>reiser4(cryptcompress, lzo1, 64K)
> >>>real 2m, 13s
> >>>sys 0m, 11s
> >>>     
> >>>
> >
> >Just curious - does your crypt plugin reside in user space?
> >
> > 
> >
> 
> Nop.
> This is just wrappers for linux crypto api, zlib, etc..
> so user time is zero and not interesting.

Then why is the sys time lower than the "plain" writes on ext2 and
reiser4? Surely compressing isn't for free, yet the sys time is lower on
the compression write than the others.

-- 
Jens Axboe

