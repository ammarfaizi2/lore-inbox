Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932616AbVJCTBK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932616AbVJCTBK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 15:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932620AbVJCTBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 15:01:10 -0400
Received: from qproxy.gmail.com ([72.14.204.194]:23096 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932616AbVJCTBJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 15:01:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Qmhi4+gWZsG58ls+jOuIwkolGXH/l4z6DxR3pIiUQP4aPTU/2yXLa0UOkvdqXQ2Ys4tYSpJNDgWimYAYMfz5kgL9Qv7KEaOLonmfbKxUoC5RVlQMMYicSdoz1OPDzW6tUv7EQuonyKjAcuJAA/NdftUz0bKLuXvUGGfgj3hdeWE=
Message-ID: <12c511ca0510031201x1f66300bucaff6410e7b675bb@mail.gmail.com>
Date: Mon, 3 Oct 2005 12:01:08 -0700
From: Tony Luck <tony.luck@gmail.com>
Reply-To: Tony Luck <tony.luck@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6 patch] kill include/linux/platform.h
Cc: Patrick Mochel <mochel@digitalimplant.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051001233414.GG4212@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050902205204.GU3657@stusta.de>
	 <Pine.LNX.4.50.0509291106520.29808-100000@monsoon.he.net>
	 <20051001233414.GG4212@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> --- linux-2.6.14-rc2-mm2-full/arch/ia64/kernel/setup.c.old      2005-10-02 01:09:11.000000000 +0200
> +++ linux-2.6.14-rc2-mm2-full/arch/ia64/kernel/setup.c  2005-10-02 01:09:15.000000000 +0200
> @@ -41,7 +41,6 @@
>  #include <linux/serial_core.h>
>  #include <linux/efi.h>
>  #include <linux/initrd.h>
> -#include <linux/platform.h>
>  #include <linux/pm.h>
>
>  #include <asm/ia32.h>

NAK.  Without <linux/platform.h> ia64 doesn't compile:

  CC      arch/ia64/kernel/setup.o
arch/ia64/kernel/setup.c: In function `cpu_init':
arch/ia64/kernel/setup.c:855: error: `default_idle' undeclared (first
use in this function)
arch/ia64/kernel/setup.c:855: error: (Each undeclared identifier is
reported only once
arch/ia64/kernel/setup.c:855: error: for each function it appears in.)
make[1]: *** [arch/ia64/kernel/setup.o] Error 1
make: *** [arch/ia64/kernel] Error 2

So you will need to add a:

extern void default_idle(void );

some place in setup.c to fix this.

-Tony
