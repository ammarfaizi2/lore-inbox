Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261707AbUBVRgf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 12:36:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261708AbUBVRgf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 12:36:35 -0500
Received: from gprs144-14.eurotel.cz ([160.218.144.14]:26242 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261707AbUBVRgd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 12:36:33 -0500
Date: Sun, 22 Feb 2004 18:36:22 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Markus =?iso-8859-1?Q?H=E4stbacka?= <midian@ihme.org>
Cc: Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [NET] 64 bit byte counter for 2.6.3
Message-ID: <20040222173622.GB1371@elf.ucw.cz>
References: <1077123078.9223.7.camel@midux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1077123078.9223.7.camel@midux>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> --- linux-2.6.3-rc1/net/core/dev.c	2004-02-08 01:07:55.000000000 +0200
> +++ linux-2.6.3-rc1-b/net/core/dev.c	2004-02-07 15:29:32.000000000 +0200
> @@ -2042,8 +2042,8 @@
>  	if (dev->get_stats) {
>  		struct net_device_stats *stats = dev->get_stats(dev);
>  
> -		seq_printf(seq, "%6s:%8lu %7lu %4lu %4lu %4lu %5lu %10lu %9lu "
> -				"%8lu %7lu %4lu %4lu %4lu %5lu %7lu %10lu\n",
> +		seq_printf(seq, "%6s:%14llu %7lu %4lu %4lu %4lu %5lu %10lu %9lu "
> +				"%14llu %7lu %4lu %4lu %4lu %5lu %7lu %10lu\n",
>  			   dev->name, stats->rx_bytes, stats->rx_packets,
>  			   stats->rx_errors,
>  			   stats->rx_dropped + stats->rx_missed_errors,
> --- linux-2.6.3-rc1/include/linux/netdevice.h	2004-02-08 01:05:47.000000000 +0200
> +++ linux-2.6.3-rc1-b/include/linux/netdevice.h	2004-02-07 15:21:26.000000000 +0200
> @@ -103,8 +103,8 @@
>  {
>  	unsigned long	rx_packets;		/* total packets received	*/
>  	unsigned long	tx_packets;		/* total packets transmitted	*/
> -	unsigned long	rx_bytes;		/* total bytes received 	*/
> -	unsigned long	tx_bytes;		/* total bytes transmitted	*/
> +	unsigned long long rx_bytes;		/* total bytes received 	*/
> +	unsigned long long tx_bytes;		/* total bytes transmitted	*/

Perhaps this should be u64? I'm not sure if long long is not 128-bits
on x86-64.
									Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
