Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262726AbTC0ATE>; Wed, 26 Mar 2003 19:19:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262711AbTC0ATE>; Wed, 26 Mar 2003 19:19:04 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:59282 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262710AbTC0ATD> convert rfc822-to-8bit;
	Wed, 26 Mar 2003 19:19:03 -0500
Content-Type: text/plain; charset=US-ASCII
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Jens Axboe <axboe@suse.de>, Nick Piggin <piggin@cyberone.com.au>
Subject: Re: [patch for playing] 2.5.65 patch to support > 256 disks
Date: Wed, 26 Mar 2003 16:29:34 -0800
User-Agent: KMail/1.4.1
Cc: Andrew Morton <akpm@digeo.com>, dougg@torque.net,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <200303211056.04060.pbadari@us.ibm.com> <3E8047C7.4070009@cyberone.com.au> <20030325123502.GW2371@suse.de>
In-Reply-To: <20030325123502.GW2371@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200303261629.34868.pbadari@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 25 March 2003 04:35 am, Jens Axboe wrote:

> Only testing will tell, so yes you are very welcome to give it a shot.
> Let me release a known working version first :)

Jens,

 I  found whats using 32MB out of 8192-byte slab.

size-8192       before:10 after:4012 diff:4002 size:8192 incr:32784384

It is deadline_init():

        dd->hash = kmalloc(sizeof(struct list_head)*DL_HASH_ENTRIES,GFP_KERNEL);

It is creating 8K hash table for each queue. Since we have 4000 queues,
it used 32MB. I wonder why the current code needs 1024 hash buckets, 
when maximum requests are only 256. And also, since you are making
request allocation dynamic, can you change this too ? Any issues here ?

Thanks,
Badari
