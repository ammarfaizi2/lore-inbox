Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265115AbUAGTdv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 14:33:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264604AbUAGTdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 14:33:25 -0500
Received: from fw.osdl.org ([65.172.181.6]:644 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266263AbUAGTa5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 14:30:57 -0500
Date: Wed, 7 Jan 2004 11:32:07 -0800
From: Andrew Morton <akpm@osdl.org>
To: Joe Korty <joe.korty@ccur.com>
Cc: linux-kernel@vger.kernel.org, Paul Jackson <pj@sgi.com>
Subject: Re: seperator error in __mask_snprintf_len
Message-Id: <20040107113207.3aab64f5.akpm@osdl.org>
In-Reply-To: <20040107165607.GA11483@rudolph.ccur.com>
References: <20040107165607.GA11483@rudolph.ccur.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Korty <joe.korty@ccur.com> wrote:
>
> Against 2.6.1-rc1.
> 
> --- base/lib/mask.c	2004-01-07 11:40:07.000000000 -0500
> +++ new/lib/mask.c	2004-01-07 11:51:26.000000000 -0500
> @@ -96,7 +96,7 @@
>  	while (i >= 1 && wordp[i] == 0)
>  		i--;
>  	while (i >= 0) {
> -		len += snprintf(buf+len, buflen-len, "%s%x", sep, wordp[i]);
> +		len += snprintf(buf+len, buflen-len, "%x%s", wordp[i], sep);
>  		sep = ",";
>  		i--;
>  	}

What does the patch do?

Just looking at this function, it seems to walking an array of longs using
a u32*.  Could someone please convince me that this is correct on both
little-endian and big-endian 64-bit hardware?  
