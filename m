Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129061AbQKGUw5>; Tue, 7 Nov 2000 15:52:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129111AbQKGUwr>; Tue, 7 Nov 2000 15:52:47 -0500
Received: from denise.shiny.it ([194.20.232.1]:13323 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id <S129061AbQKGUwo>;
	Tue, 7 Nov 2000 15:52:44 -0500
Message-ID: <3A060357.BE2C381E@denise.shiny.it>
Date: Sun, 05 Nov 2000 20:03:19 -0500
From: Giuliano Pochini <pochini@denise.shiny.it>
X-Mailer: Mozilla 4.6 [en] (X11; I; Linux 2.2.18pre19 ppc)
X-Accept-Language: en
MIME-Version: 1.0
To: Miles Lane <miles@speakeasy.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Blocked processes <=> Elevator starvation?
In-Reply-To: <20001027134603.A513@suse.de> <Pine.LNX.4.21.0010280408520.1157-100000@localhost.localdomain> <20001027202710.A825@suse.de> <39FC78BF.90607@speakeasy.org> <20001029144543.D615@suse.de> <39FE16A3.5070608@speakeasy.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> I just reproduced the problem in test10-pre7.  Here's the
> output you requested:
> 
> vmstat 1
>     procs                      memory    swap          io     system         cpu
>   r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
>   0  2  2      0  45764  76000  59520   0   0     0   509  272   508   0   0 100
>   0  2  2      0  45300  76324  59520   0   0     0   636  276   548   1   0  99
>   0  2  2      0  44896  76680  59520   0   0     0   636  273   523   0   0 100
>   0  2  2      0  44088  77392  59520   0   0     0   650  281  1307   0   7  93
>   1  1  2      0  43736  77680  59548   0   0     0  1279  908  2637   1   8  91
>   0  2  3      0  43072  78040  59592   0   0     0  1660 1281  4119   5   6  89
> 
>  >>> /var/log/kernel output stopped being emitted here <<<
>  >>>  CRUNCH!  <<<
> 
>   0  2  3      0  42656  78384  59592   0   0     0   259  271   551   0   0 100
>   0  2  3      0  42656  78384  59592   0   0     0     5  271   499   0   0 100
>   0  2  3      0  42656  78384  59592   0   0     0     5  272   511   0   2  98
>   0  2  3      0  42656  78384  59592   0   0     0     4  268   502   0   0 100
>   0  2  3      0  42656  78384  59592   0   0     0     5  272   508   0   0 100
>   0  2  3      0  42656  78384  59592   0   0     0     5  274   523   0   0 100


test7 had the problem that when the rq queue if full new requests are no
longer
merged together (the disk is slow because it writes a lot of 512 bytes blocks
instead of 128K blocks).  There is a patch for this. There still is the
problem that when the rq queue if full other processes can no more access to
*any*
device that uses ll_rw_block() and they remain blocked in D state.


Bye.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
