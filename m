Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261604AbUEDXoO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261604AbUEDXoO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 19:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbUEDXoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 19:44:14 -0400
Received: from CPE-139-168-157-129.nsw.bigpond.net.au ([139.168.157.129]:11003
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id S261604AbUEDXoK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 19:44:10 -0400
Message-ID: <40982AC6.5050208@eyal.emu.id.au>
Date: Wed, 05 May 2004 09:44:06 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.27-pre2: tg3: there's no WARN_ON in 2.4
References: <20040503230911.GE7068@logos.cnet> <20040504204633.GB8643@fs.tum.de> <200405042253.11133@WOLK>
In-Reply-To: <200405042253.11133@WOLK>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc-Christian Petersen wrote:
> On Tuesday 04 May 2004 22:46, Adrian Bunk wrote:
> 
> Hi Adrian,
> 
> 
>>drivers/net/net.o(.text+0x60293): In function `tg3_get_strings':
>>: undefined reference to `WARN_ON'
>>make: *** [vmlinux] Error 1
>>There's no WARN_ON in 2.4.
> 
> 
> yep. Either we backport WARN_ON ;) or simply do the attached.
> 
> --- old/drivers/net/tg3.c	2004-05-04 14:30:22.000000000 +0200
> +++ new/drivers/net/tg3.c	2004-05-04 14:49:58.000000000 +0200
> @@ -51,6 +51,10 @@
>  #define TG3_TSO_SUPPORT	0
>  #endif
>  
> +#ifndef WARN_ON
> +#define	WARN_ON(x)	do { } while (0)
> +#endif

Related but off topic. Do people find the ab#define	WARN_ON(x)
a macro acceptable? The fact is that not mentioning 'x' means any
side-effects are not executed, meaning the author must take special
care when using this macro.

Maybe something like
	#define	WARN_ON(x)	do {(void)(x);} while (0)
which may still attract a warning about "stmt has no effect" (not
sure).

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
