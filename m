Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268486AbUJDUro@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268486AbUJDUro (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 16:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268503AbUJDUro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 16:47:44 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:9187 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S268486AbUJDUoU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 16:44:20 -0400
Subject: Re: [PATCH] I/O space write barrier
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: jbarnes@engr.sgi.com, benh@kernel.crashing.org
Content-Type: text/plain
Organization: 
Message-Id: <1096922369.2666.177.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 04 Oct 2004 16:39:30 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> diff -Nru a/include/asm-ppc/io.h b/include/asm-ppc/io.h
> --- a/include/asm-ppc/io.h 2004-09-27 10:48:41 -07:00
> +++ b/include/asm-ppc/io.h 2004-09-27 10:48:41 -07:00
> @@ -197,6 +197,8 @@
>  #define memcpy_fromio(a,b,c)   memcpy((a),(void *)(b),(c))
>  #define memcpy_toio(a,b,c) memcpy((void *)(a),(b),(c))
> 
> +#define mmiowb() asm volatile ("eieio" ::: "memory")
> +
>  /*
>   * Map in an area of physical address space, for accessing
>   * I/O devices etc.

I don't think this is right. For ppc, eieio is
already included as part of the assembly for the
IO operations. If you could delete that, great,
but I suspect that nearly all drivers would break.

There's an existing eieio() inline function that
you could use, instead of fresh assembly code.

BTW, the "eieio" name is better. The "wb" part
of "mmiowb" looks like "write back" to me, as if
it were some sort of cache push operation. It is
also lacking an appropriate song. :-)


