Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261542AbTC3T7l>; Sun, 30 Mar 2003 14:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261545AbTC3T7l>; Sun, 30 Mar 2003 14:59:41 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:54032 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261542AbTC3T7k>; Sun, 30 Mar 2003 14:59:40 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: 64-bit kdev_t - just for playing
Date: 30 Mar 2003 12:10:43 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b67j03$2os$1@cesium.transmeta.com>
References: <UTC200303270109.h2R19ME28410.aeb@smtp.cwi.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <UTC200303270109.h2R19ME28410.aeb@smtp.cwi.nl>
By author:    Andries.Brouwer@cwi.nl
In newsgroup: linux.dev.kernel
>
> >> Maybe I should send another patch tonight, just for playing.
> 
> > Please, I'd like that.
> 
> Below a random version of kdev_t.h.
> (The file is smaller than the patch.)
> 
> kdev_t is the kernel-internal representation
> dev_t is the kernel idea of the user space representation
> (of course glibc uses 64 bits, split up as 8+8 :-)
> 
> kdev_t can be equal to dev_t.
> 
> The file below completely randomly makes kdev_t
> 64 bits, split up 32+32, and dev_t 32 bits, split up 12+20.
> 

I have a few brief questions:

a) Along all of these you have assumed that it's more efficient to
have a separate type (kdev_t) for kernel-internal "decoded" device number
handling, as opposed to "encoded" device number handling.  At some
point, however, it ends up being a struct char_dev * or struct
block_dev *.  How big is this gap and does it really make sense
introducing a special type for it?

b) If we do have such a type, would it make more sense to have cdev_t
and bdev_t, and have per-type distinction of block- versus charness?

c) If we do have such a type, any reason to have it be a "unsigned
long long" (really should be u64), instead of "u32 major; u32 minor;"?

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
