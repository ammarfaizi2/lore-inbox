Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262484AbVCIVha@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262484AbVCIVha (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 16:37:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262485AbVCIVhM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 16:37:12 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:38631 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262449AbVCIVdQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 16:33:16 -0500
Subject: Re: inode cache, dentry cache, buffer heads usage
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Dipankar Sharma <dipankar@in.ibm.com>
Cc: ext2-devel <ext2-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050309212732.GA5036@in.ibm.com>
References: <1110394558.24286.203.camel@dyn318077bld.beaverton.ibm.com>
	 <20050309212732.GA5036@in.ibm.com>
Content-Type: text/plain
Organization: 
Message-Id: <1110403763.24286.213.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 09 Mar 2005 13:29:23 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-09 at 13:27, Dipankar Sarma wrote:
> On Wed, Mar 09, 2005 at 10:55:58AM -0800, Badari Pulavarty wrote:
> > Hi,
> > 
> > We have a 8-way P-III, 16GB RAM running 2.6.8-1. We use this as
> > our server to keep source code, cscopes and do the builds.
> > This machine seems to slow down over the time. One thing we
> > keep noticing is it keeps running out of lowmem. Most of 
> > the lowmem is used for ext3 inode cache + dentry cache +
> > bufferheads + Buffers. So we did 2:2 split - but it improved
> > thing, but again run into same issues.
> > 
> > So, why is these slab cache are not getting purged/shrinked even
> > under memory pressure ? (I have seen lowmem as low as 6MB). What
> > can I do to keep the machine healthy ?
> 
> How does /proc/sys/fs/dentry-state look when you run low on lowmem ?



badari@kernel:~$ cat /proc/sys/fs/dentry-state
1434093 1348947 45      0       0       0
badari@kernel:~$ grep dentry /proc/slabinfo
dentry_cache      1434094 1857519    144   27    1 : tunables  120  
60    8 : slabdata  68797  68797      0
badari@kernel:~$ cat /proc/meminfo
MemTotal:     16377076 kB
MemFree:       8343724 kB
Buffers:        579232 kB
Cached:        5051848 kB
SwapCached:          0 kB
Active:        2911084 kB
Inactive:      3878044 kB
HighTotal:    14548952 kB
HighFree:      8330944 kB
LowTotal:      1828124 kB
LowFree:         12780 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:             216 kB
Writeback:           0 kB
Mapped:         301940 kB
Slab:          1225772 kB
Committed_AS:   771340 kB
PageTables:       5768 kB
VmallocTotal:   114680 kB
VmallocUsed:       312 kB
VmallocChunk:   114368 kB
HugePages_Total:     0
HugePages_Free:      0
Hugepagesize:     2048 kB



