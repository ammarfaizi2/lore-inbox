Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264934AbSK0XS0>; Wed, 27 Nov 2002 18:18:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264938AbSK0XS0>; Wed, 27 Nov 2002 18:18:26 -0500
Received: from webmail36.rediffmail.com ([203.199.83.248]:9908 "HELO
	webmail36.rediffmail.com") by vger.kernel.org with SMTP
	id <S264934AbSK0XSZ>; Wed, 27 Nov 2002 18:18:25 -0500
Date: 27 Nov 2002 23:24:31 -0000
Message-ID: <20021127232431.7188.qmail@webmail36.rediffmail.com>
MIME-Version: 1.0
From: "Alex  Ryan" <alexryan1@rediffmail.com>
Reply-To: "Alex  Ryan" <alexryan1@rediffmail.com>
To: linux-kernel@vger.kernel.org
Subject: optimal value for blksize_size
Content-type: text/plain;
	format=flowed
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am writing a Linux block driver for our RAID firmware, and I am 
very confused about blksize_size.

The documentation simply says that blksize_size should be the size 
of the block used by the device in bytes.
Now, for my device(hard disk), the only restriction is that calls 
must be a multiple of 512 bytes(1 sector).

I thought the natural choice for blksize_size would be 512, but I 
saw that if I make it as 512 then the upper layer breaks up all 
calls into buffer heads , each of size 512.
I think that is bad for sequential performance, even though my 
device has scatter gather capability.

And if I make blksize_size of a higher value(e.g 4K), then the 
upper layer gives calls of 4k size even for 512 byte reads.

Making blksize_size greater than PAGE_SIZE results in kernel 
panic.

I am really very confused about what  blksize_size really means, 
and what should be an optimum value to put in there.

One more question about clustering:
All IO requests for consecutive sectors are clustered in the same 
request structure, this much I understand.  My question is, does 
the b_data field of the corresponding bufferheads are also 
sequential in the physical memory? In other words, can I satisfy a 
request if I simply transfer req->nr_sectors amount of data to 
req->buffer?

-Alex
