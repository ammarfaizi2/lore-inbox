Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129464AbRCZWL7>; Mon, 26 Mar 2001 17:11:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129408AbRCZWLu>; Mon, 26 Mar 2001 17:11:50 -0500
Received: from sgi.SGI.COM ([192.48.153.1]:16414 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S129464AbRCZWJg>;
	Mon, 26 Mar 2001 17:09:36 -0500
Message-ID: <3ABFBD89.6ECCCC2D@sgi.com>
Date: Mon, 26 Mar 2001 14:07:05 -0800
From: LA Walsh <law@sgi.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en, en-US, en-GB, fr
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 64-bit block sizes on 32-bit systems
In-Reply-To: <009201c0b61e$c83f7550$5517fea9@local> <3ABF9B40.6B93ECA2@sgi.com> <00c701c0b63f$2d4fe720$5517fea9@local>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:
> Which field do you access? bh->b_blocknr instead of bh->r_sector?
---
	Yes.
> 
> There were plans to split the buffer_head into 2 structures: buffer
> cache data and the block io data.
> b_blocknr is buffer cache only, no driver should access them.
---
	My 'device' only lives in the buffer cache.  I write
to the device 95% only from kernel space and then it is read
out in large 256K reads by a user-land daemon to copy to a file.
The user-land daemon may also use 'sendfile' to pull the
data out of the device and copy it to a file which should, as I
understand it, result in a kernel only copy from the device
to the output file buffers -- meaning no copy of the data
to user space would be needed.  My primary 'dig' in all this is the 
32-bit block_nr's in the buffer cache.

-l

-- 
L A Walsh                        | Trust Technology, Core Linux, SGI
law@sgi.com                      | Voice: (650) 933-5338
