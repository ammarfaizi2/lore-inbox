Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264615AbTFELjh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 07:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264618AbTFELjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 07:39:37 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:53519 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S264615AbTFELjf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 07:39:35 -0400
Message-ID: <3EDF302B.70601@aitel.hist.no>
Date: Thu, 05 Jun 2003 13:57:31 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: no, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org, neilb@cse.unsw.edu.au
Subject: Re: 2.5.70-mm5 new oops that wasn't in 2.5.70-mm4
References: <20030605021231.2b3ebc59.akpm@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mm5 has a raid-1-related boot oops that wasn't in mm4.
Unlike my earlier reports this was a single oops, not
a string of them.

This is an UP machine with / on raid-1, no raid-0.
The kernel is monolithic and compiled with gcc 3.3

The last boot message before the crash was
md: ... autorun DONE.
The next one is normally
VFS: Mounted root (ext2 filesystem) readonly.
So I guess this failed.

Here is the oops, written down form a framebuffer using
the 4x6 font (urgh...)

unable to handle kernel paging request at 6b6b6b97 (poison?)
PREEMP DEBUG_PAGEALLOC not tainted
EIP: put_all_bios
process swapper
trace:
raid_end_bio_io
raid1_end_request
kernel_map_pages
mempool_free
bio_endio
_end_that_request_first
ide_end_request
ide_dma_intr
ide_intr
handle_IRQ_event
do_IRQ
default_idle
common_interrupt
default_idle
default_idle
cpu_idle
rest_init
start_kernel
unknown_bootoption

This is 2.5.70-mm5 without other patches.


Helge Hafting


