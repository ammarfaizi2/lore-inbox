Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265974AbUF2UCl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265974AbUF2UCl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 16:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266002AbUF2UCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 16:02:41 -0400
Received: from [63.81.117.10] ([63.81.117.10]:25037 "EHLO mail00hq.adic.com")
	by vger.kernel.org with ESMTP id S265974AbUF2UCi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 16:02:38 -0400
Message-ID: <40E1CA9A.8080701@xfs.org>
Date: Tue, 29 Jun 2004 15:01:30 -0500
From: Steve Lord <lord@xfs.org>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Xavier Roche <guest+roche@httrack.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: aggressive random read/write on large files == oops (page allocation
 failure)
References: <40E1C0B1.7060704@httrack.com>
In-Reply-To: <40E1C0B1.7060704@httrack.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Jun 2004 20:02:39.0319 (UTC) FILETIME=[079B4670:01C45E14]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Xavier Roche wrote:
> Hi,
> 
> We (exalead.com) are encountering oops'es and then a partial filesystem 
> hang (ls /proc freezes, ls in other directories also freezes randomly, 
> the machine is "half dead") when agressively accessing random data 
> through large mapped (mmap) memory areas. The system apparently oops'ed 
> while failing to allocate memory somewhere in xfs.
> 
> The kernel first message is:
> "kswapd0: page allocation failure. order:5, mode:0x50"
> (see complete dump below)
> 
> The only notable running process was a single process mapping ~100 GB of 
> data, doing aggressively:
> - random read(2) i/o on a 5 GB file
> - random read/write accesses in the mapped data
> - all on the large xfs filesystem.
> 
> Could it be a VM problem (no more available pages due to aggressive 
> access to mmap'ed memory ?) or a synchronization problem ? Any 
> hint/suggestion is welcome - and we can issue more tests with 
> symbols-enabled kernel.
> 

Looks like you are getting some fragmented files in xfs, and the
in memory copy of the extents is getting too large for your system to
find memory for. There are some recent changes to the memory
interface in xfs which should make it try a lot harder to get
this memory. You need Linus's bitkeeper tree or the sgi's xfs cvs
tree to get this code at the moment.

Steve
