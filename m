Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262731AbTJPERs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 00:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262732AbTJPERs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 00:17:48 -0400
Received: from fw.osdl.org ([65.172.181.6]:46296 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262731AbTJPERr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 00:17:47 -0400
Date: Wed, 15 Oct 2003 21:21:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6] constant_test_bit doesn't like my gcc
Message-Id: <20031015212134.41a427d3.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.53.0310160008530.2328@montezuma.fsmlabs.com>
References: <Pine.LNX.4.53.0310152244330.2328@montezuma.fsmlabs.com>
	<20031015211012.5daac8fc.akpm@osdl.org>
	<Pine.LNX.4.53.0310160008530.2328@montezuma.fsmlabs.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo <zwane@arm.linux.org.uk> wrote:
>
>  > The volatile is rather important.
> 
>  Good point, how about;
> 
>  Index: linux-2.6.0-test7-mm1/include/asm-i386/bitops.h
>  ===================================================================
>  RCS file: /build/cvsroot/linux-2.6.0-test7-mm1/include/asm-i386/bitops.h,v
>  retrieving revision 1.1.1.1
>  diff -u -p -B -r1.1.1.1 bitops.h
>  --- linux-2.6.0-test7-mm1/include/asm-i386/bitops.h	15 Oct 2003 09:02:10 -0000	1.1.1.1
>  +++ linux-2.6.0-test7-mm1/include/asm-i386/bitops.h	16 Oct 2003 04:10:37 -0000
>  @@ -241,7 +241,7 @@ static int test_bit(int nr, const volati
>   
>   static __inline__ int constant_test_bit(int nr, const volatile unsigned long * addr)
>   {
>  -	return ((1UL << (nr & 31)) & (((const volatile unsigned int *) addr)[nr >> 5])) != 0;
>  +	return ((1UL << (nr & 31)) & (addr[nr >> 5])) != 0;
>   }
>  

Looks fine.  Does your compiler get this right? 
