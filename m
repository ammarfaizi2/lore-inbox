Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267229AbSK3KIh>; Sat, 30 Nov 2002 05:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267230AbSK3KIh>; Sat, 30 Nov 2002 05:08:37 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:56242 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S267229AbSK3KIg>;
	Sat, 30 Nov 2002 05:08:36 -0500
Message-ID: <3DE88FD9.5010906@colorfullife.com>
Date: Sat, 30 Nov 2002 11:15:53 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org,
       Bernd Harries <bha@gmx.de>
Subject: Re: ioremap returns NULL
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 >>[...]
 >> For each card I ioremap() 2 * 16 MB of PCI memory space.
 >> It succeeds for the 1st card but for the 2nd card I get NULL
 >> as result. This means I cannot use the 2nd card...
 >
 >I think you are screwed. The ioremap grabs from vmalloc area,
 >which is something like 64MB on i386. The best option is
 >to rewrite the driver to allocate less, and perhaps use
 >fewer modules.


The size of the vmalloc area is 128 MB, 96 for highmem kernels.
Either:
- compile a kernel without 4G support, then you have 128 MB
- increase PKMAP_BASE (include/asm-i386/highmem.h) to
	0xff800000 (it's 0xfe000000 in 2.5.50)
Right now 32 MB virtual memory are reserved for kmap, but only 4 MB are 
used. Changing PKMAP_BASE gives you 24 MB additional vmalloc space for free.
- increase __VMALLOC_RESERVE.

--
	Manfred



