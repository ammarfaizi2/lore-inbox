Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945977AbWBCVWg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945977AbWBCVWg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 16:22:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945979AbWBCVWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 16:22:36 -0500
Received: from hera.kernel.org ([140.211.167.34]:3974 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1945977AbWBCVWf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 16:22:35 -0500
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: small etherdevice.h fix
Date: Fri, 3 Feb 2006 13:22:31 -0800
Organization: OSDL
Message-ID: <20060203132231.48612ff0@dxpl.pdx.osdl.net>
References: <Pine.LNX.4.62.0602032105180.31368@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1139001751 3531 10.8.0.74 (3 Feb 2006 21:22:31 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Fri, 3 Feb 2006 21:22:31 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 1.9.100 (GTK+ 2.6.10; x86_64-redhat-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Feb 2006 21:08:23 +0100 (CET)
Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz> wrote:

> Hi
> 
> This fixes a small bug in is_valid_ether_addr --- for address in the form 
> FF:xx:xx:xx:xx:xx it returns true. The comment is about FF:FF:FF:FF:FF:FF 
> is not true, is_multicast_ether_addr doesn't accept FF:FF:FF:FF:FF:FF as 
> multicast (as you can see few lines above).
> 
> Mikulas
> 
> --- include/linux/etherdevice.h_	2006-02-03 21:05:23.000000000 +0100
> +++ include/linux/etherdevice.h	2006-02-03 21:05:59.000000000 +0100
> @@ -91,9 +91,7 @@
>    */
>   static inline int is_valid_ether_addr(const u8 *addr)
>   {
> -	/* FF:FF:FF:FF:FF:FF is a multicast address so we don't need to
> -	 * explicitly check for it here. */
> -	return !is_multicast_ether_addr(addr) && !is_zero_ether_addr(addr);
> +	return !(addr[0] & 1) && !is_zero_ether_addr(addr);
>   }
> 
>   /**

It has already been fixed in 2.6.16 is_multicast_addr is now:

static inline int is_multicast_ether_addr(const u8 *addr)
{
	return (0x01 & addr[0]);
}


-- 
Stephen Hemminger <shemminger@osdl.org>
OSDL http://developer.osdl.org/~shemminger
