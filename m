Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261492AbSKBXDP>; Sat, 2 Nov 2002 18:03:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261493AbSKBXDP>; Sat, 2 Nov 2002 18:03:15 -0500
Received: from chiark.greenend.org.uk ([193.201.200.170]:64524 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id <S261492AbSKBXDO>; Sat, 2 Nov 2002 18:03:14 -0500
Date: Sat, 2 Nov 2002 23:09:45 +0000
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Athlon cache-line fix
Message-ID: <20021102230945.A5273@chiark.greenend.org.uk>
References: <20021102005122.2205.AKIRA-T@suna-asobi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021102005122.2205.AKIRA-T@suna-asobi.com>; from akira-t@suna-asobi.com on Sat, Nov 02, 2002 at 07:32:02AM +0000
From: Andrew Kanaber <akanaber@chiark.greenend.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Akira Tsukamoto wrote:
> For Athlon CPU, CONFIG_X86_MK7,
> the X86_L1_CACHE_SHIFT is set to 6, 128 Bytes

Eh? L1_CACHE_BYTES is defined as (1 << L1_CACHE_SHIFT) in
include/asm-i386/cache.h, which makes for a cache line size of 64 bytes
which is right. Perhaps you were assuming the cache line size was
2 << L1_CACHE_SHIFT ?

>  config X86_L1_CACHE_SHIFT
>         int
> -       default "5" if MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCRUSOE || MCYRIXIII || MK6 || MPENTIUMIII || M686 || M586MMX || M586TSC || M586
> +       default "5" if MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCRUSOE || MCYRIXIII || MK6 || MK7|| MPENTIUMIII || M686 || M586MMX || M586TSC || M586
>         default "4" if MELAN || M486 || M386
> -       default "6" if MK7
>         default "7" if MPENTIUM4

Regardless of the above this patch can't be right: the PIII's cache line
size is 32 bytes and the P4's is 128 bytes. Interesting that it increases
performance (on at least one benchmark) though.

Andrew
