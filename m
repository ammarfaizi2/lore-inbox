Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316682AbSEVS6T>; Wed, 22 May 2002 14:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316681AbSEVS6S>; Wed, 22 May 2002 14:58:18 -0400
Received: from [129.46.51.59] ([129.46.51.59]:36844 "EHLO
	ithilien.qualcomm.com") by vger.kernel.org with ESMTP
	id <S316682AbSEVS6Q>; Wed, 22 May 2002 14:58:16 -0400
Message-Id: <5.1.0.14.2.20020522103053.07be5808@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 22 May 2002 11:57:40 -0700
To: David Brownell <david-b@pacbell.net>
From: "Maksim (Max) Krasnyanskiy" <maxk@qualcomm.com>
Subject: Re: [linux-usb-devel] Re: What to do with all of the USB UHCI
  drivers in the kernel ?
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
In-Reply-To: <3CEB1F7F.4000000@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 09:33 PM 5/21/2002 -0700, David Brownell wrote:
>Maksim (Max) Krasnyanskiy wrote:
>>One-shot interrupt transfers are broken in *-hcd drivers. core/hcd.c 
>>returns EINVAL if urb->interval==0.
><....>
>Meanwhile, I suppose I can see wanting access to that UHCI-ism.
>However your patch would do that wrong, since it should only
>apply to interrupt transfers.
Yeah, I guess it doesn't make sense to do one-shot iso.

>>On a side note. Why are URBs still not SLABified ?
>
>Hasn't seemed to be necessary.  kmalloc() is slabified already,
>so it's not clear that a control/bulk/interrupt URB pool shared
>between drivers -- size, maybe a handful -- would be better than
>sharing that same memory with other kernel code.
Well, kmalloc has slabs of a fixed size and will round requested amount
to the nearest value. For example on x86 sizeof(struct urb) == 84 which
will be rounded to 96 by kmalloc ie 12 bytes unused (on Sparc64 it's about 
20 bytes).
Also we could use slab constructor to pre-initialize some urb fields.

Max

