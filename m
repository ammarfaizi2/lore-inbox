Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292270AbSBBM6q>; Sat, 2 Feb 2002 07:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292271AbSBBM6h>; Sat, 2 Feb 2002 07:58:37 -0500
Received: from brick.kernel.dk ([195.249.94.204]:43412 "EHLO
	burns.home.kernel.dk") by vger.kernel.org with ESMTP
	id <S292270AbSBBM60>; Sat, 2 Feb 2002 07:58:26 -0500
Date: Sat, 2 Feb 2002 13:57:49 +0100
From: Jens Axboe <axboe@suse.de>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: crc32 and lib.a (was Re: [PATCH] nbd in 2.5.3 does
Message-ID: <20020202135749.B4934@suse.de>
In-Reply-To: <20020131.145904.41634460.davem@redhat.com> <E16WQYs-0003Ux-00@the-village.bc.nu> <20020131232119.GN10772@conectiva.com.br> <200202021232.g12CWat01313@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200202021232.g12CWat01313@Port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> include/linux/blk.h
> 
>         Changed NR_REQUEST from 256 to 16.  This reduces the number of
>         requests that can be queued.  The size of the queue is reduced
>         from 16K to 1K.

You can do even more than this -- I dunno what I/O interface these
embedded system generally uses (the mtd stuff?). Provided you provide a
direct make_request_fn entry into these instead of using the queue, you
can basically cut all of ll_rw_blk.c and elevator.c. ll_rw_block,
submit_bh, and generic_make_request would be all that is left.

That should reclaim quite a lot of space. If there's any interest in
this (has it already been done?), I can help out getting it done.

-- 
Jens Axboe

