Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932143AbWA3JDr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbWA3JDr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 04:03:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932139AbWA3JDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 04:03:47 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:3253 "EHLO gw1.cosmosbay.com")
	by vger.kernel.org with ESMTP id S932143AbWA3JDq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 04:03:46 -0500
Message-ID: <43DDD66C.4060201@cosmosbay.com>
Date: Mon, 30 Jan 2006 10:03:40 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@kvack.org>, Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Questions about alloc_large_system_hash() and TLB entries
References: <m1r76rft2t.fsf@ebiederm.dsl.xmission.com> <m17j8jfs03.fsf@ebiederm.dsl.xmission.com> <20060128235113.697e3a2c.akpm@osdl.org> <200601291620.28291.ioe-lkml@rameria.de> <20060129113312.73f31485.akpm@osdl.org> <43DD1FDC.4080302@cosmosbay.com> <20060129200504.GD28400@kvack.org> <43DD2C15.1090800@cosmosbay.com>
In-Reply-To: <43DD2C15.1090800@cosmosbay.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Mon, 30 Jan 2006 10:03:39 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

alloc_large_system_hash() is used to allocate large hash tables at boot time.

Example on a 2 nodes NUMA machine :

Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes)
IP route cache hash table entries: 2097152 (order: 12, 16777216 bytes)
TCP established hash table entries: 2097152 (order: 12, 16777216 bytes)

Memory is taken from :
	bootmem if (flags & HASH_EARLY)
         __vmalloc() if (hashdist is set) (NUMA knob)
         __get_free_pages(GFP_ATOMIC, order);


What would be the needed changes in the code to get both :

   - Allocate ram equally from all the nodes of the machine

   - Use large pages (2MB) to lower TLB stress

Thank you
Eric
