Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266226AbUBKWbJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 17:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266230AbUBKWbJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 17:31:09 -0500
Received: from nwkea-mail-1.sun.com ([192.18.42.13]:11181 "EHLO
	nwkea-mail-1.sun.com") by vger.kernel.org with ESMTP
	id S266226AbUBKWaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 17:30:16 -0500
Date: Wed, 11 Feb 2004 14:28:50 -0800
From: Tim Hockin <thockin@sun.com>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, viro@parcelfarce.linux.theplanet.co.uk,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH - raise max_anon limit
Message-ID: <20040211222849.GL9155@sun.com>
Reply-To: thockin@sun.com
References: <20040206221545.GD9155@sun.com> <20040207005505.784307b8.akpm@osdl.org> <20040207094846.GZ21151@parcelfarce.linux.theplanet.co.uk> <20040211203306.GI9155@sun.com> <Pine.LNX.4.58.0402111236460.2128@home.osdl.org> <20040211210930.GJ9155@sun.com> <20040211135325.7b4b5020.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040211135325.7b4b5020.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 11, 2004 at 01:53:25PM -0800, Andrew Morton wrote:
> > How's this then?  It doesn't get any simpler..
> 
> Well it is lazy, wastes 0.4% of a 2M machine's memory and still has a
> hard-wired limit.
> 
> Wanna test this?

sure:

-------------------
sysfs: could not mount!
Unable to handle kernel paging request at virtual address ffffff01
 printing eip:
c014d288
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c014d288>]    Not tainted
EFLAGS: 00010086
EIP is at kmem_cache_alloc+0x2d/0x76
eax: 00000000   ebx: 00000246   ecx: c0450f4c   edx: ffffff01
esi: 000000d0   edi: 00000000   ebp: c04b5ef4   esp: c04b5ee0
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c04b4000 task=c044a7a0)
Stack: c03f6606 00000740 c0450f4c f7fe9e00 c0539e68 c04b5f14 c025f671 00000000
       000000d0 00000000 c0450f4c f7fe9e00 c0454220 c04b5f28 c0170c77 c0539e68
       00000077 00000000 c04b5f48 c016fecc f7fe9e00 00000000 f7fe9e00 f7fe74c0
Call Trace:
 [<c025f671>] idr_pre_get+0x39/0xc5
 [<c0170c77>] set_anon_super+0x3d/0x89
 [<c016fecc>] sget+0xf2/0x22b
 [<c0170f66>] get_sb_nodev+0x32/0x8e
 [<c0170c3a>] set_anon_super+0x0/0x89
 [<c01710d8>] do_kern_mount+0x56/0xc5
 [<c01d67b8>] ramfs_fill_super+0x0/0x75
 [<c0105000>] rest_init+0x0/0x93
 [<c04c90ac>] init_mount_tree+0x2d/0x191
 [<c0105000>] rest_init+0x0/0x93
 [<c04c8eb9>] vfs_caches_init+0xa4/0xc8
 [<c016910c>] filp_ctor+0x0/0xb4
 [<c01691c0>] filp_dtor+0x0/0xac
 [<c04b6818>] start_kernel+0x15d/0x1e5
 [<c04b6427>] unknown_bootoption+0x0/0xfa

Code: 8b 02 85 c0 74 1f 83 e8 01 c7 42 0c 01 00 00 00 89 02 8b 44
 <0>Kernel panic: Attempted to kill the idle task!
In idle task - not syncing
-------------------


This was a lab machine, and I'm not at the lab.  I'll try to get someone to
reboot it for me. :P
