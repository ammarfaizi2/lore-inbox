Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129828AbRBGARY>; Tue, 6 Feb 2001 19:17:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129768AbRBGARP>; Tue, 6 Feb 2001 19:17:15 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:14840 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S129677AbRBGARH>;
	Tue, 6 Feb 2001 19:17:07 -0500
Date: Tue, 6 Feb 2001 19:16:39 -0500 (EST)
From: Richard A Nelson <cowboy@vnet.ibm.com>
X-X-Sender: <cowboy@badlands.lexington.ibm.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Device driver port from 2.2 to 2.4
Message-ID: <Pine.LNX.4.33.0102061908520.2720-100000@badlands.lexington.ibm.com>
X-No-Markup: yes
x-No-ProductLinks: yes
x-No-Archive: yes
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm porting a device driver from 2.2 to 2.4 and have run across one
spot that I'm just not sure how to handle...  'Twould help if I new
either(or both) the driver or kernel internals better ;-}

It overrides the vm_operations_struct nopage function to share a trace
buffer between user and driver.

in the nopage function, there is this:
offset = address - vma->vm_start + vma->vm_offset;
newPtr = ( (void *)devExt->Trace + offset );
atomic_inc(&mem_map[ MAP_NR(newPtr) ].count ); // increment usage count

now, it looks like this might map to:
atomic_inc(virt_to_page(newPtr).count );

But I'd like to be sure I'm not missing something...  I already feel
like something is amiss in that I can't find any corresponding
decrements !!

-- 
Rick Nelson
Life'll kill ya                         -- Warren Zevon
Then you'll be dead                     -- Life'll kill ya

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
