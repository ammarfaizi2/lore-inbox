Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272012AbRIDQu5>; Tue, 4 Sep 2001 12:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272015AbRIDQut>; Tue, 4 Sep 2001 12:50:49 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:27054 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S271994AbRIDQum>;
	Tue, 4 Sep 2001 12:50:42 -0400
Date: Tue, 4 Sep 2001 09:46:00 -0700
From: Jonathan Lahr <lahr@us.ibm.com>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: io_request_lock/queue_lock patch
Message-ID: <20010904094600.A6082@us.ibm.com>
In-Reply-To: <20010830134930.F23680@us.ibm.com> <20010831075613.A2855@suse.de> <20010831075201.N23680@us.ibm.com> <20010831200333.A9069@suse.de> <20010831113308.A28193@us.ibm.com> <20010903090703.C6875@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010903090703.C6875@suse.de>; from axboe@suse.de on Mon, Sep 03, 2001 at 09:07:03AM +0200
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> You are now browsing the request list without agreeing on what lock is
> being held -- what happens to drivers assuming that io_request_lock
> protects the list? Boom. For 2.4 we simply cannot afford to muck around
> with this, it's jsut too dangerous. For 2.5 I already completely removed
> the io_request_lock (also helps to catch references to it from drivers).

In this patch, io_request_lock and queue_lock are both acquired in  
generic_unplug_device, so request_fn invocations protect request queue 
integrity.  __make_request acquires queue_lock instead of io_request_lock 
thus protecting queue integrity while allowing greater concurrency.

Nevertheless, I understand your unwillingness to change locking as 
pervasive as io_request_lock.  Such changes would of course involve 
risk.  I am simply trying to improve 2.4 i/o performance, since 2.4
could have a long time left to live.  

> I agree with your SCSI approach, it's the same we took. Low level
> drivers must be responsible for their own locking, the mid layer should
> not pre-grab anything for them. 

Yes, calling out of subsystem scope with locks held can cause problems.

Thanks for your feedback.  

Jonathan 

-- 
Jonathan Lahr
IBM Linux Technology Center
Beaverton, Oregon
lahr@us.ibm.com
503-578-3385

