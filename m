Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264379AbUFKWQq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264379AbUFKWQq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 18:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264377AbUFKWQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 18:16:45 -0400
Received: from fw.osdl.org ([65.172.181.6]:19884 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264373AbUFKWQh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 18:16:37 -0400
Date: Fri, 11 Jun 2004 15:19:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] s390: speedup strn{cpy,len}_from_user.
Message-Id: <20040611151918.00f47792.akpm@osdl.org>
In-Reply-To: <20040611173204.GB3279@mschwid3.boeblingen.de.ibm.com>
References: <20040611173204.GB3279@mschwid3.boeblingen.de.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:
>
> [PATCH] s390: speedup strn{cpy,len}_from_user.
> 
> From: Martin Schwidefsky <schwidefsky@de.ibm.com>
> 
> Speedup strncpy_from_user and strnlen_from_user by using
> the search string instruction in the secondary space mode.

There were a few conflicts with Arnd's sparse annotation, which I fixed up.
Please check that next the -mm has it all right.

>  static inline long
>  strncpy_from_user(char *dst, const char *src, long count)
>  {
>          long res = -EFAULT;
>          might_sleep();
> -        if (access_ok(VERIFY_READ, src, 1))
> -                res = __strncpy_from_user_asm(dst, src, count);
> +        if (access_ok(VERIFY_READ, src, 1)) {
> +                res = __strncpy_from_user_asm(count, dst, src);
> +	}
>          return res;
>  }

Shouldn't the access_ok() check be passed `count', rather than `1'?
