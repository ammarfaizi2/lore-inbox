Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265341AbTGCT7m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 15:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265346AbTGCT7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 15:59:42 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:737 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S265341AbTGCT7h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 15:59:37 -0400
Message-ID: <3F048E77.8080402@colorfullife.com>
Date: Thu, 03 Jul 2003 22:13:43 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andy Pfiffer <andyp@osdl.org>
CC: linux-kernel@vger.kernel.org, yoshfuji@linux-ipv6.org,
       Andrew Morton <akpm@digeo.com>
Subject: Re: Linux 2.5.74: BUG at mm/slab.c:1537
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The problem is caused by changeset 1.1310.102.3, 2003/07/01 
02:01:51+10:00, yoshfuji@linux-ipv6.org:

http://linus.bkbits.net:8080/linux-2.5/diffs/net/ipv4/raw.c@3f005eebc5YsuvTFXhDo-QDhPEgh5Q?nav=index.html
(Subject: [NET] fixed /proc/net/raw{,6} seq_file support)

raw_iter_state is just an integer. Without that patch, the integer is 
stored directly in the seq->private pointer (note the & in the define of 
raw_seq_private, around line 690 of net/ipv4/raw.c). The patch converts 
part of the code to an pointer to an integer, but other parts still 
consider seq->private as an integer. The oops is actually a BUG 
statement in kmalloc: it complains (if CONFIG_DEBUG_SLAB is enabled) 
about the invalid pointer.

--
    Manfred

