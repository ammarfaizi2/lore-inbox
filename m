Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271306AbRICHHS>; Mon, 3 Sep 2001 03:07:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271318AbRICHHI>; Mon, 3 Sep 2001 03:07:08 -0400
Received: from fe010.worldonline.dk ([212.54.64.195]:2579 "HELO
	fe010.worldonline.dk") by vger.kernel.org with SMTP
	id <S271310AbRICHGw>; Mon, 3 Sep 2001 03:06:52 -0400
Date: Mon, 3 Sep 2001 09:07:03 +0200
From: Jens Axboe <axboe@suse.de>
To: Jonathan Lahr <lahr@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: io_request_lock/queue_lock patch
Message-ID: <20010903090703.C6875@suse.de>
In-Reply-To: <20010830134930.F23680@us.ibm.com> <20010831075613.A2855@suse.de> <20010831075201.N23680@us.ibm.com> <20010831200333.A9069@suse.de> <20010831113308.A28193@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010831113308.A28193@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31 2001, Jonathan Lahr wrote:
> 
> > > Please elaborate on "no, no, no".   Are you suggesting that no further
> > > improvements can be made or should be attempted on the 2.4 i/o subsystem?
> > 
> > Of course not. The no no no just means that attempting to globally remove the
> > io_request_lock at this point is a no-go, so don't even go there. The
> > sledgehammer approach will not fly at this point, it's just way too risky.
> 
> I agree that reducing locking scope is often problematic.  However,
> this patch does not globally remove the io_request_lock.  The purpose
> of the patch is to protect request queue integrity with a per queue 
> lock instead of the global io_request_lock.  My intent was to leave 
> other io_request_lock serialization intact.  Any insight into whether
> the patch leaves data unprotected would be appreciated.

You are now browsing the request list without agreeing on what lock is
being held -- what happens to drivers assuming that io_request_lock
protects the list? Boom. For 2.4 we simply cannot afford to muck around
with this, it's jsut too dangerous. For 2.5 I already completely removed
the io_request_lock (also helps to catch references to it from drivers).

I agree with your SCSI approach, it's the same we took. Low level
drivers must be responsible for their own locking, the mid layer should
not pre-grab anything for them. 

-- 
Jens Axboe

