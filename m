Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261413AbTCOL6Q>; Sat, 15 Mar 2003 06:58:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261425AbTCOL6Q>; Sat, 15 Mar 2003 06:58:16 -0500
Received: from packet.digeo.com ([12.110.80.53]:24201 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261413AbTCOL6P>;
	Sat, 15 Mar 2003 06:58:15 -0500
Date: Sat, 15 Mar 2003 04:08:19 -0800
From: Andrew Morton <akpm@digeo.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: bzzz@tmi.comex.ru, adilger@clusterfs.com, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, hawkes@sgi.com, hannal@us.ibm.com
Subject: Re: [PATCH] concurrent block allocation for ext2 against 2.5.64
Message-Id: <20030315040819.1d7e43c6.akpm@digeo.com>
In-Reply-To: <20030315115856.GU20188@holomorphy.com>
References: <20030313165641.H12806@schatzie.adilger.int>
	<m38yvixvlz.fsf@lexa.home.net>
	<20030315043744.GM1399@holomorphy.com>
	<20030314205455.49f834c2.akpm@digeo.com>
	<20030315054910.GN20188@holomorphy.com>
	<20030315062025.GP20188@holomorphy.com>
	<20030314224413.6a1fc39c.akpm@digeo.com>
	<20030315070511.GQ20188@holomorphy.com>
	<20030315082431.GG5891@holomorphy.com>
	<20030315094758.GT20188@holomorphy.com>
	<20030315115856.GU20188@holomorphy.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Mar 2003 12:08:09.0440 (UTC) FILETIME=[8B427E00:01C2EAEB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> On Sat, Mar 15, 2003 at 12:24:31AM -0800, William Lee Irwin III wrote:
> >> Next pass involves lockmeter:
> 
> On Sat, Mar 15, 2003 at 01:47:58AM -0800, William Lee Irwin III wrote:
> > Throughput 39.2014 MB/sec 128 procs
> > dbench 128  142.51s user 10828.91s system 964% cpu 18:57.88 total
> > That's an 83% reduction in throughput from applying lockmeter.
> > Um, somebody should look into this. The thing is a bloody doorstop:
> 
> Okay, dump_stack() every once in a while when we schedule() in down().

Thanks.

> No good ideas how to script the results so I have the foggiest idea
> who's the bad guy. gzipped and MIME attached (Sorry!) for space reasons.

lock_super() in the ext2 inode allocator mainly.  It needs the same treatment.

