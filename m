Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264479AbUBEFHi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 00:07:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265056AbUBEFHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 00:07:38 -0500
Received: from web9708.mail.yahoo.com ([216.136.128.166]:35723 "HELO
	web9708.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264479AbUBEFHd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 00:07:33 -0500
Message-ID: <20040205050730.40649.qmail@web9708.mail.yahoo.com>
Date: Wed, 4 Feb 2004 21:07:30 -0800 (PST)
From: Alok Mooley <rangdi@yahoo.com>
Subject: Re: Active Memory Defragmentation: Our implementation & problems
To: root@chaos.analogic.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>
In-Reply-To: <Pine.LNX.4.53.0402041427270.2947@chaos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- "Richard B. Johnson" <root@chaos.analogic.com>
wrote:
> All "blocks" are the same size, i.e., PAGE_SIZE.
> When RAM
> is tight the content of a page is written to the
> swap-file
> according to a least-recently-used protocol. This
> frees
> a page. Pages are allocated to a process only one
> page at
> a time. This prevents some hog from grabbing all the
> memory
> in the machine. Memory allocation and physical page
> allocation
> are two different things, I can malloc() a gigabyte
> of RAM on
> a machine. It only gets allocated when an attempt is
> made
> to access a page.

Only userspace processes are allocated pages via
page-faults, i.e., one page at a time. Processes
running in kernel mode can request higher order blocks
(8K,16K...4M, which are 2 pages,4 pages...1024 pages
respectively) from the buddy allocator directly. If
external fragmentation is rampant, requests for these
higher order blocks may fail. The defragmentation
utility intends to provide a faster option for higher
order block formation before swapping (which is the
last alternative). By the way, 
malloc finally takes memory from the buddy allocator
itself (by page-faults), & the defragmenter is out to
reduce the external fragmentation caused by the buddy
allocator. Swapping ofcourse cannot be completely
avoided if the machine is genuinely short of memory.
Defragmentation may now sound better than needless
swapping or memory allocation failures, not just
another cpu hog! 

Regards,
Alok


__________________________________
Do you Yahoo!?
Yahoo! Finance: Get your refund fast by filing online.
http://taxes.yahoo.com/filing.html
