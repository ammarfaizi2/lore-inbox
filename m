Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315449AbSFCTto>; Mon, 3 Jun 2002 15:49:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315454AbSFCTtn>; Mon, 3 Jun 2002 15:49:43 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:42501 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315449AbSFCTtm>; Mon, 3 Jun 2002 15:49:42 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Atomic operations
Date: 3 Jun 2002 12:49:36 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <adgh8g$1vm$1@cesium.transmeta.com>
In-Reply-To: <EE83E551E08D1D43AD52D50B9F5110927E7A10@ntserver2> <3CFBB7DB.831BE453@didntduck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3CFBB7DB.831BE453@didntduck.org>
By author:    Brian Gerst <bgerst@didntduck.org>
In newsgroup: linux.dev.kernel
> 
> int atomic_xadd(int i, atomic_t *v)
> {
> 	int ret;
> 	__asm__(LOCK "xaddl %1,%0"
> 		: "=m" (v->counter), "=r" (ret)
> 		: "0" (v->counter), "1" (i));
> 	return ret;
> }
> 
> This one only works on 486+, but there are practically no real 386 SMP
> systems.
> 

<slaps forehead>

Boy do I feel dumb now.

The only nitpick is that it's probably better coded as:

int atomic_xadd(int i, atomic_t *v)
{
	asm volatile(LOCK "xaddl %1,%0"
		: "+m" (v->counter), "+r" (i));
	return i;
}
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
