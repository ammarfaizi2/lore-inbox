Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272028AbRIDRSJ>; Tue, 4 Sep 2001 13:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272025AbRIDRSA>; Tue, 4 Sep 2001 13:18:00 -0400
Received: from fe070.worldonline.dk ([212.54.64.208]:1545 "HELO
	fe070.worldonline.dk") by vger.kernel.org with SMTP
	id <S272003AbRIDRRs>; Tue, 4 Sep 2001 13:17:48 -0400
Date: Tue, 4 Sep 2001 19:17:59 +0200
From: Jens Axboe <axboe@suse.de>
To: Jonathan Lahr <lahr@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: io_request_lock/queue_lock patch
Message-ID: <20010904191759.P550@suse.de>
In-Reply-To: <20010830134930.F23680@us.ibm.com> <20010831075613.A2855@suse.de> <20010831075201.N23680@us.ibm.com> <20010831200333.A9069@suse.de> <20010831113308.A28193@us.ibm.com> <20010903090703.C6875@suse.de> <20010904094600.A6082@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010904094600.A6082@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04 2001, Jonathan Lahr wrote:
> 
> > You are now browsing the request list without agreeing on what lock
> > is
> > being held -- what happens to drivers assuming that io_request_lock
> > protects the list? Boom. For 2.4 we simply cannot afford to muck
> > around
> > with this, it's jsut too dangerous. For 2.5 I already completely
> > removed
> > the io_request_lock (also helps to catch references to it from
> > drivers).
> 
> In this patch, io_request_lock and queue_lock are both acquired in  
> generic_unplug_device, so request_fn invocations protect request queue 
> integrity.  __make_request acquires queue_lock instead of
> io_request_lock 
> thus protecting queue integrity while allowing greater concurrency.

You fixed SCSI for q->queue_head usage, that part looks ok. The low
level call backs are a much bigger mess though. And you broke IDE,
cciss, cpqarray, DAC960, etc etc in the process.

> Nevertheless, I understand your unwillingness to change locking as 
> pervasive as io_request_lock.  Such changes would of course involve 
> risk.  I am simply trying to improve 2.4 i/o performance, since 2.4
> could have a long time left to live.  

I can certainly understand that, but I really hope you see what I mean
that we cannot change this locking now.

-- 
Jens Axboe

