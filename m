Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281054AbRKOUw6>; Thu, 15 Nov 2001 15:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281055AbRKOUws>; Thu, 15 Nov 2001 15:52:48 -0500
Received: from postfix1-2.free.fr ([213.228.0.130]:57316 "HELO
	postfix1-2.free.fr") by vger.kernel.org with SMTP
	id <S281054AbRKOUwc> convert rfc822-to-8bit; Thu, 15 Nov 2001 15:52:32 -0500
Date: Thu, 15 Nov 2001 19:07:14 +0100 (CET)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: "David S. Miller" <davem@redhat.com>
Cc: <anton@samba.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] small sym-2 fix
In-Reply-To: <20011115.112606.62677098.davem@redhat.com>
Message-ID: <20011115183811.F1902-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 15 Nov 2001, David S. Miller wrote:

>    From: Gérard Roudier <groudier@free.fr>
>    Date: Thu, 15 Nov 2001 17:27:38 +0100 (CET)
>
>    The driver should not need more than 4096 bytes for a single allocation.
>
> If platform is 64-bit and PAGE_SIZE < 8K, yes it will.
> And ppc64 fits this criteria.

Btw, I didn't see any ppc64 stuff in linux kernel. As a result this
platform is still in the unsupported status. :-)

Indeed a 4K page on a 64 bit machine looks very suboptimal. Note that it
is also way too small for 32 bits machines with hundreds of megabytes of
memory. I am wondering about the reasons that made us keep with so small a
page size. As you know earlier BSDs used 2K on Vaxen that as you also know
had (have?) a physical PAGE_SIZE of 512 bytes.

About the sym-2 driver, it may well be some pointers that make it need
more than 4K allocation on 64 bit machines.

I will try to make it fit a page size max allocation even on such weird
configuration, since I do consider as high^H^H^H^Hslightly broken any
piece of software that requires more that 1 PAGE of physically contiguous
allocation. :-) :-) :-)

To be serious, the right fix is to have some logical page be some power of
two of the physical page when the physical page is too small. Can we hope
Linux-2.5 to allow this?

  Gérard.

