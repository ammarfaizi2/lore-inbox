Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130059AbRBZAeF>; Sun, 25 Feb 2001 19:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130060AbRBZAdz>; Sun, 25 Feb 2001 19:33:55 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:18190 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S130059AbRBZAds>;
	Sun, 25 Feb 2001 19:33:48 -0500
Date: Mon, 26 Feb 2001 01:33:26 +0100
From: Jens Axboe <axboe@suse.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: Nate Eldredge <neldredge@hmc.edu>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.2-ac3: loop threads in D state
Message-ID: <20010226013326.X7830@suse.de>
In-Reply-To: <20010226012430.V7830@suse.de> <Pine.GSO.4.21.0102251927170.26808-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0102251927170.26808-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Sun, Feb 25, 2001 at 07:29:21PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 25 2001, Alexander Viro wrote:
> Erm... Jens, it really should be
> 	if (atomic_dec_and_test(...))
> 		up(...);
> not just
> 	atomic_dec(...);
> 	up(...);
> 
> Otherwise you can end up with too early exit of loop_thread. Normally
> it would not matter, but in pathological cases...

How so? We dec it and up the semaphore, loop_thread runs until it's
done and ups lo_sem.

-- 
Jens Axboe

