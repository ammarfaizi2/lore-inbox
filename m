Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932202AbWCBDhb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbWCBDhb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 22:37:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbWCBDhb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 22:37:31 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:17023 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932202AbWCBDha convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 22:37:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Xil/mz0EQiRULfqQs4hkvATJmE6Fy+dpQZZqJw8HMmhMs6EpYxmGd26YL/0quhB3ovyXefYawTDxsRadlLwWrAeQKY0yH5yYpZXefcUfMPsbh/cOU/rgP94pDZCNMjoSRPPvTLa0maDJFQv0nL8XFU039gUSEJToOSjGY0AvAPA=
Message-ID: <6d6a94c50603011937p61bea6ddl691ee1cdb309d14d@mail.gmail.com>
Date: Thu, 2 Mar 2006 11:37:30 +0800
From: Aubrey <aubreylee@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: page allocation failure when cached memory is close to the total memory.
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060301023604.76ce5658.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <6d6a94c50603010154hbbcdb68n8cd7e05f7f30aba5@mail.gmail.com>
	 <20060301023604.76ce5658.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/06, Andrew Morton <akpm@osdl.org> wrote:
> You mean 10MB.
Sorry for the typo.

> The chances of finding 10MB of contiguous free pages are basically nil, so
> the page allocator doesn't even try to free up pages to attempt to satisfy
> such a large request.  If it can't find the 10MB of free memory
> immediately, it just gives up.

Nope. I've tested the case on the host. See below. The allocation for
300MB was sucessful when the cached memory was close to the total
memory.

Any thoughts why?

Thanks,
-Aubrey


=============================================================
aubrey@linux:~/cvs/kernel/uClinux-dist> cat /proc/meminfo
MemTotal:      1034848 kB
MemFree:         15424 kB
Buffers:          2368 kB
Cached:         751104 kB
SwapCached:          0 kB
Active:         306116 kB
Inactive:       650060 kB
HighTotal:      129560 kB
HighFree:          120 kB
LowTotal:       905288 kB
LowFree:         15304 kB
SwapTotal:     1558296 kB
SwapFree:      1557268 kB
Dirty:          140032 kB
Writeback:           0 kB
Mapped:         265188 kB
Slab:            53556 kB
CommitLimit:   2075720 kB
Committed_AS:   290860 kB
PageTables:       1968 kB
VmallocTotal:   114680 kB
VmallocUsed:     14940 kB
VmallocChunk:    96880 kB
HugePages_Total:     0
HugePages_Free:      0
Hugepagesize:     4096 kB
aubrey@linux:~/cvs/kernel/uClinux-dist> ./ma
Alloc 300 MB !
alloc successful
===============================================================
