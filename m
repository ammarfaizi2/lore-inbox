Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264073AbUDBPNO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 10:13:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264075AbUDBPNO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 10:13:14 -0500
Received: from citrine.spiritone.com ([216.99.193.133]:52896 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S264073AbUDBPNM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 10:13:12 -0500
Date: Fri, 02 Apr 2004 07:13:08 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Yasunori Goto <ygoto@us.fujitsu.com>
cc: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Linux Hotplug Memory Support 
	<lhms-devel@lists.sourceforge.net>
Subject: Re: [Patch] physnode_map definition should be signed
Message-ID: <1276190000.1080918788@[10.10.2.4]>
In-Reply-To: <20040401095436.DFDD.YGOTO@us.fujitsu.com>
References: <20040401095436.DFDD.YGOTO@us.fujitsu.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In your modification of pfn_valid() for IA32 at 2.6.4 stock kernel,
> it doesn't return 0 even if the node is offline.
> 
> True problem is physnode_map's definition.
> Physnode_map[]'s default (offline) value is -1,
> but it is defined as UNSIGNED 8. 
> So, pfn_to_nid() return 255. 
> 
> I think this should be defined as signed like this patch.
> Maximum node number of IA32 is 16, so this is enough yet.
> 
> I found this problem on multi-node emulation for memory-hotplug test.
> When I started X on this emulation, system panicked at remap_pte_range()
> by this problem.
> I think that system will be down when a program will call mmap()
> for hardware area.

There are several breakages in this area, particularly on Summit with
4/4 split right now - in my tree I'm init'ing the array to 0 temporarily
to get around some problems, but we have better fixes lined up.

Anyway, your patch looks correct - 128 nodes should be plenty. I shall
apply it. Thanks,

M.

