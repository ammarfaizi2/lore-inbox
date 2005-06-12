Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261828AbVFLLum@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261828AbVFLLum (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 07:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262305AbVFLLul
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 07:50:41 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:28684 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261828AbVFLLug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 07:50:36 -0400
Date: Sun, 12 Jun 2005 13:50:20 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4.31 7/9] gcc4: fix const function warnings
Message-ID: <20050612115019.GJ28759@alpha.home.local>
References: <200506121121.j5CBLGd4019750@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506121121.j5CBLGd4019750@harpo.it.uu.se>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mikael,

Just out of curiosity, I understand why we can have a const on an inline
function to help the compiler optimize the code at compile time in cases
such as below :

> -static inline const unsigned char dehex(char c) {
> +static inline __attribute_const__ unsigned char dehex(char c) {
>  	if ((c>='0')&&(c<='9')) {
>  		return c-'0';
>  	}

But I don't see how it can be useful in asm code like below, since the
compiler cannot evaluate it at compile time :

> -static __inline__ __const__ __u32 ___arch__swab32(__u32 x)
> +static __inline__ __attribute_const__ __u32 ___arch__swab32(__u32 x)
>  {
>  #ifdef CONFIG_X86_BSWAP
>  	__asm__("bswap %0" : "=r" (x) : "0" (x));

Am I missing something, or could we simply remove the __const__ every
time the function only uses asm ?

Regards,
Willy

