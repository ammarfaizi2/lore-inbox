Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263711AbUBKNfV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 08:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263787AbUBKNfV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 08:35:21 -0500
Received: from arkanoid.scarlet-internet.nl ([213.204.195.164]:19905 "EHLO
	arkanoid.scarlet-internet.nl") by vger.kernel.org with ESMTP
	id S263711AbUBKNfP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 08:35:15 -0500
Message-ID: <1076506513.402a2f9120fb8@webmail.dds.nl>
Date: Wed, 11 Feb 2004 14:35:13 +0100
From: wdebruij@dds.nl
To: sting sting <zstingx@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: printk and long long 
References: <Sea2-F7mFkwDjKqc3eQ0001c385@hotmail.com>
In-Reply-To: <Sea2-F7mFkwDjKqc3eQ0001c385@hotmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

how about simply using a shift to output two regular longs, i.e.

printk("%ld%ld",loff_t >> (sizeof(long) * 8), loff_t << sizeof(long) * 8 >>
sizeof(long) * 8);

perhaps you could even place this ghastly code in a macro if you have to access
it often (so that you don't have to look at it :)?

I know it's not pretty, but at least the %ld is considered standard printf
functionality. I don't think %lld (even if it is implemented in some printf
derivates) can be considered portable.

Willem
Citeren sting sting <zstingx@hotmail.com>:

> Hello,
> I am trying to perfrom printk with a variable of type long long.
> (loff_t is that type and it is long long , as can be seen in
> posix+types.h).
> what is the format string for such a type ?
> I had tried %lld" but it gace wrpng results.
> regards,
> sting
> 
> _________________________________________________________________
> Protect your PC - get McAfee.com VirusScan Online 
> http://clinic.mcafee.com/clinic/ibuy/campaign.asp?cid=3963
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



