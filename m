Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129145AbQKCRxq>; Fri, 3 Nov 2000 12:53:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130525AbQKCRxg>; Fri, 3 Nov 2000 12:53:36 -0500
Received: from fw.SuSE.com ([202.58.118.35]:39664 "EHLO linux.local")
	by vger.kernel.org with ESMTP id <S129145AbQKCRxc>;
	Fri, 3 Nov 2000 12:53:32 -0500
Date: Fri, 3 Nov 2000 11:04:04 -0800
From: Jens Axboe <axboe@suse.de>
To: Miles Lane <miles@speakeasy.org>
Cc: Rui Sousa <rsousa@grad.physics.sunysb.edu>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org,
        Matthew Dharm <mdharm-usb@one-eyed-alien.net>
Subject: Re: Blocked processes <=> Elevator starvation?
Message-ID: <20001103110404.I521@suse.de>
In-Reply-To: <20001027134603.A513@suse.de> <Pine.LNX.4.21.0010280408520.1157-100000@localhost.localdomain> <20001027202710.A825@suse.de> <39FC78BF.90607@speakeasy.org> <20001029144543.D615@suse.de> <39FE16A3.5070608@speakeasy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <39FE16A3.5070608@speakeasy.org>; from miles@speakeasy.org on Mon, Oct 30, 2000 at 04:47:31PM -0800
X-OS: Linux 2.4.0-test10 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30 2000, Miles Lane wrote:
> I just reproduced the problem in test10-pre7.  Here's the
> output you requested:

Thanks

> vmstat 1
>     procs                      memory    swap          io     system         cpu
>   r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
>   1  1  2      0  43736  77680  59548   0   0     0  1279  908  2637   1   8  91
>   0  2  3      0  43072  78040  59592   0   0     0  1660 1281  4119   5   6  89
> 
>  >>> /var/log/kernel output stopped being emitted here <<<
>  >>>  CRUNCH!  <<<
> 
>   0  2  3      0  42656  78384  59592   0   0     0   259  271   551   0   0 100
>   0  2  3      0  42656  78384  59592   0   0     0     5  271   499   0   0 100

Yes, I would assume this would be the case. The current vm does not
behave very well once the cache has been filled up. I'm not knocking
the new vm, this has been a problem for some time. Basically I/O
performance goes badly down the drain at this point.

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
