Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287939AbSA0KuO>; Sun, 27 Jan 2002 05:50:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287979AbSA0KuF>; Sun, 27 Jan 2002 05:50:05 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:11534 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S287939AbSA0Kt4>;
	Sun, 27 Jan 2002 05:49:56 -0500
Date: Sun, 27 Jan 2002 11:49:43 +0100
From: Jens Axboe <axboe@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make ide-scsi compile in 2.5
Message-ID: <20020127114942.A4140@suse.de>
In-Reply-To: <20020127024631.A28936@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020127024631.A28936@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 27 2002, Andi Kleen wrote:
> 
> ide-scsi doesn't compile currently in 2.5.x. This patch fixes it in a 
> rather hackish way by adding some kmap_atomic()s.  It would be 
> probably better to kmap earlier in process context in the request 
> function instead, but I leave this to the people who know more 
> about IDE/block layer than me (but apparently not compile ide-scsi..)

axboe@burns:~/src/linux> make drivers/scsi/ide-scsi.o
gcc -D__KERNEL__ -I/home/axboe/src/linux/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686   -c -o drivers/scsi/ide-scsi.o drivers/scsi/ide-scsi.c
axboe@burns:~/src/linux>

Works for me, what didn't compile?

Are you sure that you aren't hitting the sg address change? AFAICS,
there should not be a need for highmem mapping here. Requests coming out
of the block layer for /dev/scd* should be bounced for you, and sg
doesn't pass on highmem pages iirc.

Puzzled...

-- 
Jens Axboe

