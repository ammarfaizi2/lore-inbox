Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262391AbSJVJgo>; Tue, 22 Oct 2002 05:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262400AbSJVJgo>; Tue, 22 Oct 2002 05:36:44 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:2503 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262391AbSJVJgn>;
	Tue, 22 Oct 2002 05:36:43 -0400
Subject: Re: [PATCH] 2.5.44: lkcd (9/9): dump driver and build files
From: "Suparna Bhattacharya" <suparna@sparklet.in.ibm.com>
Date: Tue, 22 Oct 2002 20:35:36 +0530
Message-Id: <pan.2002.10.22.20.35.36.992053.2611@sparklet.in.ibm.com>
References: <200210211016.g9LAG5J21214@nakedeye.aparity.com> <20021021172112.C14993@sgi.com>
X-Comment-To: "Christoph Hellwig" <hch@sgi.com>
Pan-Reverse-Path: suparna@sparklet.in.ibm.com
Pan-Mail-To: "Christoph Hellwig" <hch@sgi.com>
Pan-Server: ibm-ltc
Organization: IBM
Pan-Attribution: On Mon, 21 Oct 2002 19:43:20 +0530, Christoph Hellwig wrote:
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Oct 2002 19:43:20 +0530, Christoph Hellwig wrote:


>> +
>> +	if ((dump_bio = kmalloc(sizeof(struct bio), GFP_KERNEL)) == NULL) { +
>> 	DUMP_PRINTF("Cannot allocate bio\n"); +		retval = -ENOMEM;
>> +		goto err2;
>> +	}
> 
> Shouldn't you use the generic bio allocator?
> 

Not sure that this should come from the bio mempool. Objects
allocated from the mem pool are expected to be released back to
the pool within a reasonable period (after i/o is done), which is
not quite the case here.

Dump preallocates the bio early when configured and holds on to 
it all through the time the system is up (avoids allocs at 
actual dump time). Doesn't seem like the right thing to hold
on to a bio mempool element that long.

Regards
Suparna
