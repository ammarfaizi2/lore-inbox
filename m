Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262845AbTDNIOP (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 04:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262853AbTDNIOP (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 04:14:15 -0400
Received: from holomorphy.com ([66.224.33.161]:4993 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262845AbTDNIOO (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 04:14:14 -0400
Date: Mon, 14 Apr 2003 01:25:43 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: dentry leak in 2.5.x
Message-ID: <20030414082543.GB706@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <20030413222908.GA8956@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030413222908.GA8956@holomorphy.com>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 13, 2003 at 03:29:08PM -0700, wli@holomorphy.com wrote:
> Seen on 2.5.65-mm3, updatedb got dentry + inode caches eating 740/768MB:

Looks like an oops may have caused it:

  printing eip:
 c0159cf7
 Oops: 0000 [#1]
 CPU:    0
 EIP:    0060:[iput+39/112]    Not tainted VLI
 EFLAGS: 00010202
 EIP is at iput+0x27/0x70
 eax: 00000004   ebx: d2effb74   ecx: d2effb84   edx: d2effb84
 esi: d2effb74   edi: dc809380   ebp: 0000005d   esp: efd37e80
 ds: 007b   es: 007b   ss: 0068
 Process kswapd0 (pid: 8, threadinfo=efd36000 task=efd4b900)
 Stack: efd36000 c01575ed d2effb74 00000080 000000c5 efd36000 00000000 c0157a05 
        00000080 c0133c9c 00000080 000000d0 000002a2 c0485b54 ffffff5a 00000006 
        0458db60 00000000 c0486218 000273d8 effeebc0 c0134c6f 000002a2 000000d0 
 Call Trace:
  [prune_dcache+301/416] prune_dcache+0x12d/0x1a0
  [shrink_dcache_memory+21/64] shrink_dcache_memory+0x15/0x40
  [shrink_slab+252/352] shrink_slab+0xfc/0x160
  [balance_pgdat+207/320] balance_pgdat+0xcf/0x140
  [kswapd+235/240] kswapd+0xeb/0xf0
  [kswapd+0/240] kswapd+0x0/0xf0
  [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
  [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
  [kernel_thread_helper+5/24] kernel_thread_helper+0x5/0x18
 
 Code: 04 c3 89 f6 53 8b 5c 24 08 85 db 74 60 8b 83 88 00 00 00 8b 40 24 83 bb 3
0 01 00 00 20 75 08 0f 0b 16 04 ed a4 3e c0 85 c0 74 0d <8b> 40 14 85 c0 74 06 5
3 ff d0 83 c4 04 68 0c 6f 48 c0 8d 43 1c


-- wli
