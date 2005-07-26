Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262280AbVGZWt3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262280AbVGZWt3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 18:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262316AbVGZWtW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 18:49:22 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:15253 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262280AbVGZWsY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 18:48:24 -0400
Subject: Re: Memory pressure handling with iSCSI
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>
In-Reply-To: <20050726151003.6aa3aecb.akpm@osdl.org>
References: <1122399331.6433.29.camel@dyn9047017102.beaverton.ibm.com>
	 <20050726111110.6b9db241.akpm@osdl.org>
	 <1122403152.6433.39.camel@dyn9047017102.beaverton.ibm.com>
	 <20050726114824.136d3dad.akpm@osdl.org>
	 <20050726121250.0ba7d744.akpm@osdl.org>
	 <1122412301.6433.54.camel@dyn9047017102.beaverton.ibm.com>
	 <20050726142410.4ff2e56a.akpm@osdl.org>
	 <1122414300.6433.57.camel@dyn9047017102.beaverton.ibm.com>
	 <20050726151003.6aa3aecb.akpm@osdl.org>
Content-Type: multipart/mixed; boundary="=-QfRwilUKhN6W2dGZQD/R"
Date: Tue, 26 Jul 2005 15:48:08 -0700
Message-Id: <1122418089.6433.62.camel@dyn9047017102.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-QfRwilUKhN6W2dGZQD/R
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2005-07-26 at 15:10 -0700, Andrew Morton wrote:
> Badari Pulavarty <pbadari@us.ibm.com> wrote:
> >
> > On Tue, 2005-07-26 at 14:24 -0700, Andrew Morton wrote:
> > > Badari Pulavarty <pbadari@us.ibm.com> wrote:
> > > >
> > > > ext2 is incredibly better. Machine is very responsive. 
> > > > 
> > > 
> > > OK.  Please, always monitor and send /proc/meminfo.  I assume that the
> > > dirty-memory clamping is working OK with ext2 and that perhaps it'll work
> > > OK with ext3/data=writeback.
> > 
> > Nope. Dirty is still very high..
> 
> That's a relief in a way.  Can you please try decreasing the number of
> filesystems now?

Here is the data with 5 ext2 filesystems. I also collected /proc/meminfo
every 5 seconds. As you can see, we seem to dirty 6GB of data in 20
seconds of starting the test. I am not sure if its bad, since we have
lots of free memory..

Thanks,
Badari



--=-QfRwilUKhN6W2dGZQD/R
Content-Disposition: attachment; filename=vmstat-5-ext2.out
Content-Type: text/plain; name=vmstat-5-ext2.out; charset=utf-8
Content-Transfer-Encoding: 7bit

procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 2 11    120  32912  10624 6813476    0    0     0  6766 10364   485  0  4  0 96
 0 11    120  33036  10652 6813964    0    0     2  8889 10079   475  0  4  0 96
 0 11    120  33036  10712 6813904    0    0     0  8077 9984   469  0  4  0 96
 0 11    120  32912  10752 6814380    0    0     0 15576 10226   514  0  4  0 95
 0 11    120  33036  10668 6813432    0    0     0 11334 10112   488  0  4  0 96
 0 11    120  33656  10600 6813500    0    0     0 11811 10238   497  0  4  0 96
 0 11    120  33036  10596 6814020    0    0     0 12713 10191   489  0  4  0 96
 0 11    120  33036  10648 6813968    0    0     1 15775 10195   508  0  4  0 96
 0 10    120  33780  10656 6812928    0    0     2  5390 10265   503  0  3  5 92
 0 11    120  33036  10660 6813440    0    0     0  9700 10217   518  0  4  2 94



--=-QfRwilUKhN6W2dGZQD/R
Content-Disposition: inline; filename=meminfo.out
Content-Type: text/plain; name=meminfo.out; charset=utf-8
Content-Transfer-Encoding: 7bit

MemTotal:      7143628 kB
MemFree:       7001860 kB
Buffers:          5080 kB
Cached:          23300 kB
SwapCached:          0 kB
Active:          48600 kB
Inactive:         5872 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:      7143628 kB
LowFree:       7001860 kB
SwapTotal:     1048784 kB
SwapFree:      1048780 kB
Dirty:               0 kB
Writeback:           0 kB
Mapped:          45948 kB
Slab:            56348 kB
CommitLimit:   4620596 kB
Committed_AS:   148436 kB
PageTables:       1544 kB
VmallocTotal: 34359738367 kB
VmallocUsed:      9888 kB
VmallocChunk: 34359728447 kB
HugePages_Total:     0
HugePages_Free:      0
Hugepagesize:     2048 kB

MemTotal:      7143628 kB
MemFree:       4871864 kB
Buffers:         14564 kB
Cached:        2091232 kB
SwapCached:          0 kB
Active:          51380 kB
Inactive:      2081780 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:      7143628 kB
LowFree:       4871864 kB
SwapTotal:     1048784 kB
SwapFree:      1048780 kB
Dirty:         2070752 kB
Writeback:           0 kB
Mapped:          46368 kB
Slab:           107912 kB
CommitLimit:   4620596 kB
Committed_AS:   148524 kB
PageTables:       1608 kB
VmallocTotal: 34359738367 kB
VmallocUsed:      9888 kB
VmallocChunk: 34359728447 kB
HugePages_Total:     0
HugePages_Free:      0
Hugepagesize:     2048 kB

MemTotal:      7143628 kB
MemFree:        406384 kB
Buffers:         18940 kB
Cached:        6443960 kB
SwapCached:          0 kB
Active:          55688 kB
Inactive:      6435048 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:      7143628 kB
LowFree:        406384 kB
SwapTotal:     1048784 kB
SwapFree:      1048780 kB
Dirty:         6144652 kB
Writeback:      252152 kB
Mapped:          46380 kB
Slab:           216580 kB
CommitLimit:   4620596 kB
Committed_AS:   148756 kB
PageTables:       1608 kB
VmallocTotal: 34359738367 kB
VmallocUsed:      9888 kB
VmallocChunk: 34359728447 kB
HugePages_Total:     0
HugePages_Free:      0
Hugepagesize:     2048 kB

MemTotal:      7143628 kB
MemFree:         32772 kB
Buffers:         10028 kB
Cached:        6817680 kB
SwapCached:          4 kB
Active:          48180 kB
Inactive:      6804552 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:      7143628 kB
LowFree:         32772 kB
SwapTotal:     1048784 kB
SwapFree:      1048664 kB
Dirty:         6489496 kB
Writeback:      285264 kB
Mapped:          46000 kB
Slab:           228172 kB
CommitLimit:   4620596 kB
Committed_AS:   148756 kB
PageTables:       1608 kB
VmallocTotal: 34359738367 kB
VmallocUsed:      9888 kB
VmallocChunk: 34359728447 kB
HugePages_Total:     0
HugePages_Free:      0
Hugepagesize:     2048 kB

MemTotal:      7143628 kB
MemFree:         32524 kB
Buffers:         10056 kB
Cached:        6816620 kB
SwapCached:          4 kB
Active:          48672 kB
Inactive:      6803212 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:      7143628 kB
LowFree:         32524 kB
SwapTotal:     1048784 kB
SwapFree:      1048664 kB
Dirty:         6465124 kB
Writeback:      268876 kB
Mapped:          46008 kB
Slab:           229580 kB
CommitLimit:   4620596 kB
Committed_AS:   148996 kB
PageTables:       1608 kB
VmallocTotal: 34359738367 kB
VmallocUsed:      9888 kB
VmallocChunk: 34359728447 kB
HugePages_Total:     0
HugePages_Free:      0
Hugepagesize:     2048 kB

--=-QfRwilUKhN6W2dGZQD/R--

