Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314548AbSHBNzA>; Fri, 2 Aug 2002 09:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314551AbSHBNy7>; Fri, 2 Aug 2002 09:54:59 -0400
Received: from tolkor.sgi.com ([192.48.180.13]:46748 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S314548AbSHBNy5>;
	Fri, 2 Aug 2002 09:54:57 -0400
Subject: Re: A new ide warning message
From: Steve Lord <lord@sgi.com>
To: Jens Axboe <axboe@suse.de>
Cc: martin@dalecki.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020802124139.GR3010@suse.de>
References: <1028288066.1123.5.camel@laptop.americas.sgi.com>
	<20020802114713.GD1055@suse.de> <3D4A7178.7050307@evision.ag>
	<1028289940.1123.19.camel@laptop.americas.sgi.com>
	<3D4A771A.9020308@evision.ag> <20020802123055.GQ3010@suse.de>
	<3D4A7BBE.90104@evision.ag>  <20020802124139.GR3010@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 02 Aug 2002 08:50:55 -0500
Message-Id: <1028296255.30192.9.camel@jen.americas.sgi.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-08-02 at 07:41, Jens Axboe wrote:
> 
> Yeah it's a request for data, what else could it be? That's the only
> place where we call blk_rq_map_sg().
> 
> Stephen, please provoke with this patch applied. I hope it works, it's
> untested :-)
> 

Consider it provoked, I added a trace to the submit_bio call in XFS
as well, dumping sector number, bio length in bytes and number of
vector elements submitted:

submit_bio(READ, sector 0x414870, len 65536 vec_len 16
submit_bio(READ, sector 0x4148f0, len 65536 vec_len 16
pcidma: build 2 segments, supplied 1/16, sectors 128/8
bio 0: phys 1, hw 16
segment 0: phys 69599232, size 4096
segment 1: phys 69603328, size 4096
segment 2: phys 69607424, size 4096
segment 3: phys 69611520, size 4096
segment 4: phys 69615616, size 4096
segment 5: phys 69619712, size 4096
segment 6: phys 69623808, size 4096
segment 7: phys 69627904, size 4096
segment 8: phys 69632000, size 4096
segment 9: phys 69636096, size 4096
segment 10: phys 69640192, size 4096
segment 11: phys 69644288, size 4096
segment 12: phys 69648384, size 4096
segment 13: phys 69652480, size 4096
segment 14: phys 69656576, size 4096
segment 15: phys 69660672, size 4096
pcidma: build 2 segments, supplied 1/16, sectors 128/8
bio 0: phys 1, hw 16
segment 0: phys 69664768, size 4096
segment 1: phys 69668864, size 4096
segment 2: phys 69672960, size 4096
segment 3: phys 69677056, size 4096
segment 4: phys 69681152, size 4096
segment 5: phys 69685248, size 4096
segment 6: phys 69689344, size 4096
segment 7: phys 69693440, size 4096
segment 8: phys 69697536, size 4096
segment 9: phys 69701632, size 4096
segment 10: phys 69705728, size 4096
segment 11: phys 69709824, size 4096
segment 12: phys 69713920, size 4096
segment 13: phys 69718016, size 4096
segment 14: phys 69722112, size 4096
segment 15: phys 69726208, size 4096

And so on.....

The bio size being used is based purely on the BIO_MAX_SECTORS
constant, same code as ll_rw_kio. Looks like the direct I/O
path uses similar math.

Steve

-- 

Steve Lord                                      voice: +1-651-683-3511
Principal Engineer, Filesystem Software         email: lord@sgi.com
