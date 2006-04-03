Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750833AbWDCMK7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750833AbWDCMK7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 08:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750933AbWDCMK7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 08:10:59 -0400
Received: from gaz.sfgoth.com ([69.36.241.230]:57561 "EHLO gaz.sfgoth.com")
	by vger.kernel.org with ESMTP id S1750833AbWDCMK6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 08:10:58 -0400
Date: Mon, 3 Apr 2006 05:15:04 -0700
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Silence a const vs non-const warning
Message-ID: <20060403121503.GF3157@gaz.sfgoth.com>
References: <20060403112107.GQ1259@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060403112107.GQ1259@lug-owl.de>
User-Agent: Mutt/1.4.2.1i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.2.2 (gaz.sfgoth.com [127.0.0.1]); Mon, 03 Apr 2006 05:15:04 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan-Benedict Glaw wrote:
> This patch silences a const vs. non-const warning issued by very
> recent GCC versions:
> 
> $ vax-linux-uclibc-gcc -v 2>&1 | grep version
[...]
>  void *memcpy(void *dest, const void *src, size_t count)
>  {
>  	char *tmp = dest;
> -	char *s = src;
> +	const char *s = src;

Actually the compiler version has nothing to do with it -- I'm pretty
sure even gcc 2.X would warn on that.  The actual reason that most people
don't see that is that an arch w/o __HAVE_ARCH_MEMCPY is pretty rare.

Still, no reason for the reference C version of that function to emit
a warning, so it's worth fixing.

-Mitch
