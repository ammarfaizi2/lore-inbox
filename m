Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263428AbRFFAEh>; Tue, 5 Jun 2001 20:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263430AbRFFAE1>; Tue, 5 Jun 2001 20:04:27 -0400
Received: from mailout2-0.nyroc.rr.com ([24.92.226.121]:47461 "EHLO
	mailout2-0.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S263428AbRFFAEM>; Tue, 5 Jun 2001 20:04:12 -0400
Message-ID: <008001c0ee1d$90f1ec90$0701a8c0@morph>
From: "Dan Maas" <dmaas@dcine.com>
To: "Pete Wyckoff" <pw@osc.edu>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <04ea01c0ed67$ad3f38f0$0701a8c0@morph> <20010605182120.F23799@osc.edu> <078d01c0ee15$8072b960$0701a8c0@morph> <20010605193134.B8037@bigger.osc.edu>
Subject: Re: forcibly unmap pages in driver?
Date: Tue, 5 Jun 2001 20:13:51 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Later, the program calls the ioctl() again to set a smaller
>> buffer size, or closes the file descriptor. At this point
>> I'd like to shrink the buffer or free it completely. But I
>> can't assume that the program will be nice and munmap() the
>> region for me

> Look at drivers/char/drm, for example.  At mmap time they allocate a
> vm_ops to the address space.  With that you catch changes to the vma
> structure initiated by a user mmap, munmap, etc.  You could also
> dynamically map the pages in using the nopage method (optional).

OK I think I have a solution... Whenever I need to re-allocate or free the
DMA buffer, I could set all of the user's corresponding page table entries
to deny all access. Then I'd get a page fault on the next access to the
buffer, and inside nopage() I could update the user's mapping or send a
SIGBUS as appropriate (hmm, just like restoring a file mapping that was
thrown away)... So I just have to figure out how to find the user's page
table entries that are pointing to the DMA buffer.

Regards,
Dan

