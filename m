Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263010AbTJBAYT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 20:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263058AbTJBAYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 20:24:19 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37304 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263010AbTJBAYS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 20:24:18 -0400
Message-ID: <3F7B701C.5020708@pobox.com>
Date: Wed, 01 Oct 2003 20:23:56 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Larry McVoy <lm@bitmover.com>
CC: Andrew Morton <akpm@osdl.org>, Hanna Linder <hannal@us.ibm.com>,
       lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Minutes from 10/1 LSE Call
References: <37940000.1065035945@w-hlinder> <20031001162916.5fc2241b.akpm@osdl.org> <20031001233815.GB29605@work.bitmover.com>
In-Reply-To: <20031001233815.GB29605@work.bitmover.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:
> On Wed, Oct 01, 2003 at 04:29:16PM -0700, Andrew Morton wrote:
> 
>>If you have a loop like:
>>
>>	char *buf;
>>
>>	for (lots) {
>>		read(fd, buf, size);
>>	}
>>
>>the optimum value of `size' is small: as little as 8k.  Once `size' gets
>>close to half the size of the L1 cache you end up pushing the memory at
>>`buf' out of CPU cache all the time.
> 
> 
> I've seen this too, not that Andrew needs me to back him up, but in many 
> cases even 4k is big enough.  Linux has a very thin system call layer so
> it is OK, good even, to use reasonable buffer sizes.


Slight tangent, FWIW...   Back when I was working on my "race-free 
userland" project, I noticed that the fastest cp(1) implementation was 
GNU's:  read/write from a single, statically allocated, page-aligned 4K 
buffer.  I experimented with various buffer sizes, mmap-based copies, 
and even with sendfile(2) where both arguments were files. 
read(2)/write(2) of a single 4K buffer was always the fastest.

	Jeff



