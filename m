Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275289AbRJJKxl>; Wed, 10 Oct 2001 06:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275301AbRJJKxb>; Wed, 10 Oct 2001 06:53:31 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:9900 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S275289AbRJJKxU>;
	Wed, 10 Oct 2001 06:53:20 -0400
Date: Wed, 10 Oct 2001 06:53:50 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: BALBIR SINGH <balbir.singh@wipro.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] register_blkdev and unregister_blkdev
In-Reply-To: <3BC4278C.6070907@wipro.com>
Message-ID: <Pine.GSO.4.21.0110100651080.17790-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 10 Oct 2001, BALBIR SINGH wrote:

> Alexander Viro wrote:
> 
> >>I was looking at the code for register_blkdev and unregister_blkdev. I 
> >>found that no
> >>locking (spinlocks) are used to protect the blkdevs struture in these 
> >>functions. I suspect
> >>we have not seen a problem till now since
> >>
> >
> >... they are only called under BKL; ditto for lookups in the tables they
> >(de-)populate.
> >
> What I wanted to know was, who is calling/holding the BKL? Is it because
> lock_kernel is called in sys_create_module() and sys_init_module().

All module init code is under BKL and will stay that way for a long time.
If that ever becomes not true, we are in for much more pain that
register_blkdev() races - you would need to do audit of all drivers to
pull something like that.

