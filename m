Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262017AbUKJRRL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262017AbUKJRRL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 12:17:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262018AbUKJRRK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 12:17:10 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:60138 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262017AbUKJRRI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 12:17:08 -0500
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
Cc: Jens Axboe <axboe@suse.de>, Robert Love <rml@novell.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Message-Flag: Warning: May contain useful information
References: <4191A4E2.7040502@gmx.net> <1100066597.18601.124.camel@localhost>
	<20041110075450.GB5602@suse.de> <419249D8.1030100@gmx.net>
From: Roland Dreier <roland@topspin.com>
Date: Wed, 10 Nov 2004 09:17:00 -0800
In-Reply-To: <419249D8.1030100@gmx.net> (Carl-Daniel Hailfinger's message of
 "Wed, 10 Nov 2004 18:03:20 +0100")
Message-ID: <52k6st1v5f.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: [RFC] [PATCH] kmem_alloc (generic wrapper for kmalloc and
 vmalloc)
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 10 Nov 2004 17:17:06.0349 (UTC) FILETIME=[1A72D5D0:01C4C749]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Carl-Daniel> OK, so how should I allocate memory for 512 struct
    Carl-Daniel> loop_device's?  Because of its odd size (304 bytes)
    Carl-Daniel> it seems that if I use kmalloc seperately for each
    Carl-Daniel> struct, I'd waste 208 bytes per allocation. 68%
    Carl-Daniel> overhead would be a step backwards. Or am I missing
    Carl-Daniel> something here?

Would creating your own slab cache with kmem_cache_create() and
allocating with kmem_cache_alloc() work?  You can fit 13 304 byte
objects in a 4K page, which wastes 4096 - 13*304 = 144 bytes per page
or about 11 bytes per object.  Less than 4% overhead seems OK to me.

 - R.
