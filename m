Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263305AbVCDXwc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263305AbVCDXwc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 18:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263353AbVCDXut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 18:50:49 -0500
Received: from smartmx-05.inode.at ([213.229.60.37]:29838 "EHLO
	smartmx-05.inode.at") by vger.kernel.org with ESMTP id S263071AbVCDWwQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 17:52:16 -0500
Message-ID: <4228E68F.1030609@inode.info>
Date: Fri, 04 Mar 2005 23:51:59 +0100
From: Richard Fuchs <richard.fuchs@inode.info>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: slab corruption in skb allocs
References: <42283093.7040405@inode.info> <20050304035309.1da7774e.akpm@osdl.org> <42285354.5090900@inode.info> <20050304201153.GR3163@waste.org> <4228D0D9.9010301@inode.info> <20050304212730.GZ3120@waste.org> <4228D8A6.3080402@inode.info> <20050304220508.GA3120@waste.org>
In-Reply-To: <20050304220508.GA3120@waste.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall wrote:

> Which card/driver is this? Is this the same card that's showing ssh
> troubles? My theory about your ssh trouble only applies to cards with
> checksum offload.

i got the same on all three machines i was testing with, with both the 
e100 and the eepro100 driver. one of those three machines was the one 
with the ssh troubles, its card is identified as "Intel Corp. 82557/8/9 
[Ethernet Pro 100] (rev 08)", pci id 8086:1229. plus, i couldn't 
reproduce those problems on a machine with e1000, which does support all 
kinds of checksum offloading. (there might still be something fishy with 
the e1000 as well, as i'm not entirely trusting the errors from the slab 
checkers alone. especially since i don't see those messages when i 
enable page alloc debugging.)

another machine behaves even more strangely... its nic is identified as 
"Intel Corp. 82801BD PRO/100 VE (LOM) Ethernet Controller (rev 81)", pci 
id 8086:1039, also apparently not supporting hardware checksums. it does 
immediately produce the slab debug errors when i bombard it with udp 
packets while having disk access w/o dma, but remains silent when doing 
the same with a tcp transfer instead of udp packets. neither ssh traffic 
nor /dev/zero piped through netcat (no matter in which direction) makes 
it catch any errors. i only got a _single_ message from the slab 
debugger when sending /dev/zero through netcat in _both_ directions at 
the same time (in and out). however, i do get pages and pages of those 
messages when sending a simple stream of udp packets to the box... 
again, this is all with the e100 driver, i couldn't produce any similar 
results with the eepro100 or the e1000 driver yet, but apparently this 
doesn't necessarily mean that there isn't something wrong anyway...

cheers
richard
