Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261966AbREYWBg>; Fri, 25 May 2001 18:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261969AbREYWB1>; Fri, 25 May 2001 18:01:27 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:15113 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261966AbREYWBX>;
	Fri, 25 May 2001 18:01:23 -0400
Date: Sat, 26 May 2001 00:01:19 +0200
From: Jens Axboe <axboe@suse.de>
To: Alexandr Andreev <andreev@niisi.msk.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Disabling interrupts before block device request call
Message-ID: <20010526000119.A23273@suse.de>
In-Reply-To: <3B0EE8CF.7040502@niisi.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B0EE8CF.7040502@niisi.msk.ru>; from andreev@niisi.msk.ru on Fri, May 25, 2001 at 07:20:47PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25 2001, Alexandr Andreev wrote:
> Hi, list
> In ll_rw_block.c, before calling block device specific request function 
> ( i mean do_hd_request, do_ftl_request, ... ) the io_request_lock is 
> locking, and all interrupts are disabling. I know, that request handler 
> routine have to be atomic, but when we read data from a flash device ( 
> for example ) we use a timeouts. Where do we have to enable timer 
> interrupts, or should we disable all interrupts?

Even with dropping io_request_lock, it's not recommended to sleep inside
the request_fn. WIth plugging, you are basically preventing the other
plugged queues from being run until you return.

You could use a timer or similar to call you on a specified timeout
instead.

-- 
Jens Axboe

