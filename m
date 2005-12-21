Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932324AbVLUJMG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932324AbVLUJMG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 04:12:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932323AbVLUJMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 04:12:06 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:47323 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S932324AbVLUJME
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 04:12:04 -0500
Message-ID: <43A91C57.20102@cosmosbay.com>
Date: Wed, 21 Dec 2005 10:11:51 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Andi Kleen <ak@suse.de>
Subject: [POLL] SLAB : Are the 32 and 192 bytes caches really usefull on x86_64
 machines ?
References: <7vbqzadgmt.fsf@assigned-by-dhcp.cox.net>
In-Reply-To: <7vbqzadgmt.fsf@assigned-by-dhcp.cox.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Wed, 21 Dec 2005 10:11:52 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wonder if the 32 and 192 bytes caches are worth to be declared in 
include/linux/kmalloc_sizes.h, at least on x86_64

(x86_64 : PAGE_SIZE = 4096, L1_CACHE_BYTES = 64)

On my machines, I can say that the 32 and 192 sizes could be avoided in favor 
in spending less cpu cycles in __find_general_cachep()

Could some of you post the result of the following command on your machines :

# grep "size-" /proc/slabinfo |grep -v DMA|cut -c1-40

size-131072            0      0 131072
size-65536             0      0  65536
size-32768             2      2  32768
size-16384             0      0  16384
size-8192             13     13   8192
size-4096            161    161   4096
size-2048          40564  42976   2048
size-1024            681    800   1024
size-512           19792  37168    512
size-256              81    105    256
size-192            1218   1280    192
size-64            31278  86907     64
size-128            5457  10380    128
size-32              594    784     32

Thank you

PS : I have no idea why the last lines (size-192, 64, 128, 32) are not ordered...

Eric
