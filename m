Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276364AbRKHQ4x>; Thu, 8 Nov 2001 11:56:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276249AbRKHQ4n>; Thu, 8 Nov 2001 11:56:43 -0500
Received: from ns.xdr.com ([209.48.37.1]:57502 "EHLO xdr.com")
	by vger.kernel.org with ESMTP id <S275270AbRKHQ4k>;
	Thu, 8 Nov 2001 11:56:40 -0500
Date: Thu, 8 Nov 2001 08:56:43 -0800
From: Dave Ashley (linux mailing list) <linux@xdr.com>
Message-Id: <200111081656.fA8Guht24668@xdr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmap + wrapping around to 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a fix for this problem. In the file
include/linux/mm.h
in the inline function do_mmap(), change
        if ((offset + PAGE_ALIGN(len)) < offset)
to
        if ((offset + PAGE_ALIGN(len)-1) < offset)

-Dave

On Wed, 7 Nov 2001, Dave Ashley wrote:

> I'm using linux on an embedded system based on the 2.4.2 kernel. There
> is a flash rom at physical address FFE00000 of 2 megabytes size. I have
> a flash utility that uses mmap() on /dev/mem, but I can't call it with
> offset 0xffe00000, size 0x00200000, I must call it with size
> 0x001ff000 (1 page size less than the real size). I figure this is because
> the end address has wrapped around to 0 and this messes up the system.
>
> This should work, the memory is there. But I can't access that last page.
>
> BTW the cpu is a ppc 8260 (603e core).
>
> -Dave
