Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261616AbTCOW5y>; Sat, 15 Mar 2003 17:57:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261619AbTCOW5y>; Sat, 15 Mar 2003 17:57:54 -0500
Received: from holomorphy.com ([66.224.33.161]:49619 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261616AbTCOW5x>;
	Sat, 15 Mar 2003 17:57:53 -0500
Date: Sat, 15 Mar 2003 15:08:24 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>, bzzz@tmi.comex.ru,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: [PATCH] concurrent inode allocation for ext2 against 2.5.64
Message-ID: <20030315230824.GB20188@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, bzzz@tmi.comex.ru,
	linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
References: <m365qk1gzx.fsf@lexa.home.net> <20030315220241.GX20188@holomorphy.com> <20030315143718.60e006b7.akpm@digeo.com> <20030315225842.GA20188@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030315225842.GA20188@holomorphy.com>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 15, 2003 at 02:37:18PM -0800, Andrew Morton wrote:
>> Looks like it's gone nuts when 128 processes all try to close lots of
>> files at the same time.
>> One possible reason for this leaping out is that all the instances are now
>> achieving more uniform runtimes.   You can tell that by comparing the dbench
>> dots.

On Sat, Mar 15, 2003 at 02:58:42PM -0800, William Lee Irwin III wrote:
> For some reason this version of dbench doesn't produce dots. I logged
> what it did produce, though. It looks something like this:

There's a problem with the old dbench:

Throughput 82.0899 MB/sec (NB=102.612 MB/sec  820.899 MBit/sec)
$ (time ./dbench/dbench 128) |& tee -a ~/dbench.output.15
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++128 clients started
********************************************************************************************************************************
Throughput 1841.38 MB/sec (NB=2301.72 MB/sec  18413.8 MBit/sec)
./dbench/dbench 128  73.31s user 6.75s system 1802% cpu 4.440 total

