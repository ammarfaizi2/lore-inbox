Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288374AbSA1JIu>; Mon, 28 Jan 2002 04:08:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288485AbSA1JIi>; Mon, 28 Jan 2002 04:08:38 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:28171 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S288374AbSA1JIX>;
	Mon, 28 Jan 2002 04:08:23 -0500
Date: Mon, 28 Jan 2002 10:08:04 +0100
From: Jens Axboe <axboe@suse.de>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi uodate to remove io_request_lock
Message-ID: <20020128100804.A8894@suse.de>
In-Reply-To: <20020128073357.53c9569f.johnpol@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020128073357.53c9569f.johnpol@2ka.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28 2002, Evgeniy Polyakov wrote:
> Hello, Jens Axboe, Linus Torvalds and other linux kernel hackers.
> 
> Here is patch against 2.5.3-pre5 which removes io_request_lock.

You seem to be using &host->host_lock, which isn't quite right. SCSI
adapters pass down a preferred lock with scsi_assign_lock, and host_lock
_points_ to that lock. So you need to be using host->host_lock. A
compile should have caught this error (build SMP, of course).

> But unfortunnually here is 1 file (drivers/scsi/3w-xxxx.c), 
> which still use spinning locks with io_request_lock because of detect()
> method, in which we cann't send Scsi_Host pointer. So this file must be
> corrected in some other way.

->detect() is not called with the lock held anymore...

> So, please check and apply.

You still have a bit of work to do :-)

-- 
Jens Axboe

