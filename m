Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932581AbVITGiT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932581AbVITGiT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 02:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932745AbVITGiT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 02:38:19 -0400
Received: from relay.rost.ru ([80.254.111.11]:51130 "EHLO smtp.rost.ru")
	by vger.kernel.org with ESMTP id S932581AbVITGiS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 02:38:18 -0400
Date: Tue, 20 Sep 2005 10:38:05 +0400
To: colin <colin@realtek.com.tw>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CONFIG_PRINTK doesn't makes size smaller
Message-ID: <20050920063805.GB20363@pazke>
Mail-Followup-To: colin <colin@realtek.com.tw>,
	linux-kernel@vger.kernel.org
References: <01bf01c5bdaa$9e8b81c0$106215ac@realtek.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01bf01c5bdaa$9e8b81c0$106215ac@realtek.com.tw>
X-Uname: Linux 2.6.11-pazke i686
User-Agent: Mutt/1.5.9i
From: Andrey Panin <pazke@donpac.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 263, 09 20, 2005 at 02:14:55PM +0800, colin wrote:
> 
> Hi there,
> I tried to make kernel with CONFIG_PRINTK off. I considered it should become
> smaller, but it didn't because it actually isn't an empty function, and
> there are many copies of it in vmlinux, not just one. Here is its
> definition:
>     static inline int printk(const char *s, ...) { return 0; }
> 
> I change the definition to this and it can greatly reduce the size by about
> 5%:
>     #define printk(...) do {} while (0)
> However, this definition would lead to error in some situations. For
> example:
>     1. (printk)
>     2. ret = printk
> 
> I hope someone could suggest a better definition of printk that can both
> make printk smaller and eliminate errors.

What about the macro below ?

#define printk(...) ({ do { } while(0); 0; })

-- 
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net
