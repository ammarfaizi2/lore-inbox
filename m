Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262545AbTCMUxd>; Thu, 13 Mar 2003 15:53:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262546AbTCMUxd>; Thu, 13 Mar 2003 15:53:33 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:48853 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S262545AbTCMUxb>; Thu, 13 Mar 2003 15:53:31 -0500
Subject: Re: [Ext2-devel] Re: [Bug 417] New: htree much slower than regular
	ext3
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andreas Dilger <adilger@clusterfs.com>
Cc: Daniel Phillips <phillips@arcor.de>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net, "Theodore Ts'o" <tytso@mit.edu>,
       chrisl@vmware.com, Stephen Tweedie <sct@redhat.com>
In-Reply-To: <20030227140019.G1373@schatzie.adilger.int>
References: <11490000.1046367063@[10.10.2.4]>
	 <20030227200425.253F03FE26@mx01.nexgo.de>
	 <20030227140019.G1373@schatzie.adilger.int>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047589455.1924.97.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-3) 
Date: 13 Mar 2003 21:04:15 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 2003-02-27 at 21:00, Andreas Dilger wrote:

> I've got a patch which should help here, although it was originally written
> to speed up the "create" case instead of the "lookup" case.  In the lookup
> case, it will do a pre-read of a number of inode table blocks, since the cost
> of doing a 64kB read and doing a 4kB read is basically the same - the cost
> of the seek.

No it's not --- you're evicting 16 times as much other
potentially-useful data from the cache for each lookup.  You'll improve
the "du" or "ls -l" case by prefetching, but you may well slow down the
overall system performance when you're just doing random accesses (eg.
managing large spools.)

It would be interesting to think about how we can spot the cases where
the prefetch is likely to be beneficial, for example by observing
"stat"s coming in in strict hash order.

--Stephen

