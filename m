Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280588AbRLUL5y>; Fri, 21 Dec 2001 06:57:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280537AbRLUL5e>; Fri, 21 Dec 2001 06:57:34 -0500
Received: from holomorphy.com ([216.36.33.161]:7808 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S280531AbRLUL5d>;
	Fri, 21 Dec 2001 06:57:33 -0500
Date: Fri, 21 Dec 2001 03:57:30 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: mingo@elte.hu, ak@muc.de, jamesclv@us.ibm.com, torvalds@transmeta.com,
        marcelo@conectiva.com.br
Subject: Re: [PATCH] MAX_MP_BUSSES increase
Message-ID: <20011221035730.A710@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel <linux-kernel@vger.kernel.org>, mingo@elte.hu,
	ak@muc.de, jamesclv@us.ibm.com, torvalds@transmeta.com,
	marcelo@conectiva.com.br
In-Reply-To: <200112210419.fBL4Jfq08533@butler1.beaverton.ibm.com> <Pine.LNX.4.33.0112211131130.2269-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <Pine.LNX.4.33.0112211131130.2269-100000@localhost.localdomain>; from mingo@elte.hu on Fri, Dec 21, 2001 at 11:42:40AM +0100
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2001 at 11:42:40AM +0100, Ingo Molnar wrote:
> William, could you please give us the amount of RAM saved on your box,
> with and without your tree-structure patch applied?

Please refer to my other messages regarding the true purposes of the
tree-based bootmem and so on.

Given that it's one architecture, a single very small machine, and one
kernel version, this is perhaps not as scientific as I'd like it to be,
but my personal computer (i386) at home shows the following results for
2.4.17-rc2 and my local patch set (plus or minus bootmem).


2.4.17-rc2-wli-bootmem:
Memory: 769332k/786368k available
	(1389k kernel code, 16648k reserved, 1019k data, 224k init, 0k highmem)

2.4.17-rc2-wli:
Memory: 769340k/786368k available
	(1389k kernel code, 16640k reserved, 1019k data, 216k init, 0k highmem)

After freeing init, the total memory is identical, not my expected 8KB:

--- bootmem.meminfo	Fri Dec 21 03:33:44 2001
+++ nobootmem.meminfo	Fri Dec 21 03:30:53 2001
@@ -1,18 +1,18 @@
         total:    used:    free:  shared: buffers:  cached:
-Mem:  788025344 78618624 709406720        0  5652480 33247232
+Mem:  788025344 87261184 700764160        0 12656640 34500608
 Swap: 518152192        0 518152192
 MemTotal:       769556 kB
-MemFree:        692780 kB
+MemFree:        684340 kB
 MemShared:           0 kB
-Buffers:          5520 kB
-Cached:          32468 kB
+Buffers:         12360 kB
+Cached:          33692 kB
 SwapCached:          0 kB
-Active:          53784 kB
-Inact_dirty:     4748 kB
+Active:          61728 kB
+Inact_dirty:     4876 kB
 Inact_clean:        0 kB
 HighTotal:           0 kB
 HighFree:            0 kB
 LowTotal:       769556 kB
-LowFree:        692780 kB
+LowFree:        684340 kB
 SwapTotal:      506008 kB
 SwapFree:       506008 kB


Cheers,
Bill
