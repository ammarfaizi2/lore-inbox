Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261205AbVDJB7b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbVDJB7b (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 21:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbVDJB73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 21:59:29 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:3506 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261191AbVDJB7S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 21:59:18 -0400
Date: Sat, 9 Apr 2005 18:56:36 -0700
From: Paul Jackson <pj@engr.sgi.com>
To: Chris Wedgwood <cw@f00f.org>
Cc: torvalds@osdl.org, davem@davemloft.net, andrea@suse.de, mbp@sourcefrog.net,
       linux-kernel@vger.kernel.org, dlang@digitalinsight.com
Subject: Re: Kernel SCM saga..
Message-Id: <20050409185636.0945abdf.pj@engr.sgi.com>
In-Reply-To: <20050410001435.GA23401@taniwha.stupidest.org>
References: <1112852302.29544.75.camel@hope>
	<Pine.LNX.4.58.0504071626290.28951@ppc970.osdl.org>
	<1112939769.29544.161.camel@hope>
	<Pine.LNX.4.58.0504072334310.28951@ppc970.osdl.org>
	<20050408083839.GC3957@opteron.random>
	<Pine.LNX.4.58.0504081647510.28951@ppc970.osdl.org>
	<20050409022701.GA14085@opteron.random>
	<Pine.LNX.4.58.0504082240460.28951@ppc970.osdl.org>
	<20050409155511.7432d5c7.davem@davemloft.net>
	<Pine.LNX.4.58.0504091611570.1267@ppc970.osdl.org>
	<20050410001435.GA23401@taniwha.stupidest.org>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris wrote:
> How many is alot?  Are we talking 100k, 1m, 10m?

I pulled some numbers out of my bk tree for Linux.

I have 16817 source files.

They average 12.2 bitkeeper changes per file (counting the number of
changes visible from doing 'bk sccslog' on each of the 16817 files). 

These 16817 files consume:

	224 MBytes uncompressed and
	 95 MBytes compressed

(using zlib's minigzip, on a 4 KB page reiserfs.)

Since each change will get its own copy of the file, multiplying these
two sizes (224 and 95) by 12.2 changes per file means the disk cost
would be:

	2.73 GByte uncompressed, or
	1.16 GBytes compressed.

I was pleasantly surprised at the degree of compression, shrinking files
to 42% of their original size.  I expected, since the classic rule of
thumb here to archive before compressing wasn't being followed (nor
should it be) and we were compressing lots a little files, we would save
fewer disk blocks than this.

Of course, since as Linus reminds us, it's disk buffers in memory,
not blocks on disk, that are precious, it's more like we will save
224 - 95 == 129 MBytes of RAM to hold one entire tree.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
