Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261888AbUBWLej (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 06:34:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261914AbUBWLej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 06:34:39 -0500
Received: from mta9.srv.hcvlny.cv.net ([167.206.5.42]:55213 "EHLO
	mta9.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S261888AbUBWLeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 06:34:37 -0500
Date: Mon, 23 Feb 2004 06:34:23 -0500
From: Jeff Sipek <jeffpc@optonline.net>
Subject: Re: [NET] 64 bit byte counter for 2.6.3
In-reply-to: <20040222173622.GB1371@elf.ucw.cz>
To: Pavel Machek <pavel@ucw.cz>,
       Markus =?iso-8859-1?q?H=E4stbacka?= <midian@ihme.org>
Cc: Kernel Mailinglist <linux-kernel@vger.kernel.org>
Message-id: <200402230634.33531.jeffpc@optonline.net>
MIME-version: 1.0
Content-type: Text/Plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
Content-description: clearsigned data
User-Agent: KMail/1.5.4
References: <1077123078.9223.7.camel@midux> <20040222173622.GB1371@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sunday 22 February 2004 12:36, Pavel Machek wrote:
> Hi!
>
> > --- linux-2.6.3-rc1/net/core/dev.c	2004-02-08 01:07:55.000000000 +0200
> > +++ linux-2.6.3-rc1-b/net/core/dev.c	2004-02-07 15:29:32.000000000 +0200
> > @@ -2042,8 +2042,8 @@
> >  	if (dev->get_stats) {
> >  		struct net_device_stats *stats = dev->get_stats(dev);
> >
> > -		seq_printf(seq, "%6s:%8lu %7lu %4lu %4lu %4lu %5lu %10lu %9lu "
> > -				"%8lu %7lu %4lu %4lu %4lu %5lu %7lu %10lu\n",
> > +		seq_printf(seq, "%6s:%14llu %7lu %4lu %4lu %4lu %5lu %10lu %9lu "
> > +				"%14llu %7lu %4lu %4lu %4lu %5lu %7lu %10lu\n",
> >  			   dev->name, stats->rx_bytes, stats->rx_packets,
> >  			   stats->rx_errors,
> >  			   stats->rx_dropped + stats->rx_missed_errors,
> > --- linux-2.6.3-rc1/include/linux/netdevice.h	2004-02-08
> > 01:05:47.000000000 +0200 +++
> > linux-2.6.3-rc1-b/include/linux/netdevice.h	2004-02-07 15:21:26.000000000
> > +0200 @@ -103,8 +103,8 @@
> >  {
> >  	unsigned long	rx_packets;		/* total packets received	*/
> >  	unsigned long	tx_packets;		/* total packets transmitted	*/
> > -	unsigned long	rx_bytes;		/* total bytes received 	*/
> > -	unsigned long	tx_bytes;		/* total bytes transmitted	*/
> > +	unsigned long long rx_bytes;		/* total bytes received 	*/
> > +	unsigned long long tx_bytes;		/* total bytes transmitted	*/
>
> Perhaps this should be u64? I'm not sure if long long is not 128-bits
> on x86-64.

Hmm...I've been told that u_int64_t is the C99 (IIRC) standard, and that it 
should be used in favor of u64. Is that so?

I'll announce my version of 64-bit net stats fairly soon.

Jeff.

- -- 
We have joy, we have fun, we have Linux on a Sun...
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAOeVHwFP0+seVj/4RAv1gAKCFZZEHOi78wcrX2dWquQ4Qcth4AQCgicO0
L+vkeXdghp0YPWzgLInBpU8=
=F5rS
-----END PGP SIGNATURE-----

