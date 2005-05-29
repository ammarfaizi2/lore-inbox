Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261400AbVE2X1q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261400AbVE2X1q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 19:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261401AbVE2X1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 19:27:45 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:61198 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S261400AbVE2X1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 19:27:44 -0400
Message-ID: <429A4FD7.5040600@shadowen.org>
Date: Mon, 30 May 2005 00:27:19 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc5-mm1 - missing #define SECTIONS_SHIFT in sparsemem
References: <200505282238.j4SMcYdN014990@turing-police.cc.vt.edu>
In-Reply-To: <200505282238.j4SMcYdN014990@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
> sparsemem-memory-model.patch references SECTIONS_SHIFT without defining it.
> 
> Caught this while compiling with -Wundef, causes lots of warnings
> when it gets used in include/linux/mm.h.  The appended patch Works For Me,
> although I wonder if the *real* problem isn't a missing '#ifdef CONFIG_SPARSEMEM'
> around the code that uses it in mm.h.  
>  
> Signed-Off-By: valdis.kletnieks@vt.edu
> 
> --- linux-2.6.12-rc5-mm1/include/linux/mmzone.h.ifdef	2005-05-27 15:12:26.000000000 -0400
> +++ linux-2.6.12-rc5-mm1/include/linux/mmzone.h	2005-05-27 16:26:40.000000000 -0400
> @@ -568,6 +568,7 @@ static inline int pfn_valid(unsigned lon
>  void sparse_init(void);
>  #else
>  #define sparse_init()	do {} while (0)
> +#define SECTIONS_SHIFT	0
>  #endif /* CONFIG_SPARSEMEM */
>  
>  #ifdef CONFIG_NODES_SPAN_OTHER_NODES

Odd.  I guess there must be a reference from an unused function to this
define when SPARSEMEM is off.  Can you send me your .config please and
I'll have a look.

-apw
