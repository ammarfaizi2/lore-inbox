Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264274AbTCXRpA>; Mon, 24 Mar 2003 12:45:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264282AbTCXRo7>; Mon, 24 Mar 2003 12:44:59 -0500
Received: from havoc.daloft.com ([64.213.145.173]:5054 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S264274AbTCXRou>;
	Mon, 24 Mar 2003 12:44:50 -0500
Date: Mon, 24 Mar 2003 12:55:54 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: stray 2.4 tcp fix.
Message-ID: <20030324175554.GA5119@gtf.org>
References: <200303241642.h2OGgC35008344@deviant.impure.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303241642.h2OGgC35008344@deviant.impure.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 24, 2003 at 04:42:00PM +0000, davej@codemonkey.org.uk wrote:
> Sent to davem and netdev already, and was met with silence..
> 
> diff -urpN --exclude-from=/home/davej/.exclude bk-linus/net/ipv4/tcp.c linux-2.5/net/ipv4/tcp.c
> --- bk-linus/net/ipv4/tcp.c	2003-03-21 12:53:31.000000000 +0000
> +++ linux-2.5/net/ipv4/tcp.c	2003-03-21 13:45:21.000000000 +0000
> @@ -1189,7 +1189,8 @@ new_segment:
>  
>  			from += copy;
>  			copied += copy;
> -			seglen -= copy;
> +			if ((seglen -= copy) == 0 && iovlen == 0)
> +				goto out;

What's the purpose of combining a statement and a test?

Simply adding a test would be more clear.

	Jeff



