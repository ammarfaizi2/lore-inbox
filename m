Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289022AbSAFUMh>; Sun, 6 Jan 2002 15:12:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289023AbSAFUM1>; Sun, 6 Jan 2002 15:12:27 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:49315 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S289022AbSAFUMV>; Sun, 6 Jan 2002 15:12:21 -0500
Date: Sun, 6 Jan 2002 13:12:18 -0700
Message-Id: <200201062012.g06KCIu16158@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Andrew Morton <akpm@zip.com.au>
Cc: Ivan Passos <ivan@cyclades.com>, linux-kernel@vger.kernel.org
Subject: Re: Serial Driver Name Question (kernels 2.4.x)
In-Reply-To: <3C34024A.EDA31D24@zip.com.au>
In-Reply-To: <3C33E0D3.B6E932D6@zip.com.au>
	<3C33BCF3.20BE9E92@cyclades.com>
	<200201030637.g036bxe03425@vindaloo.ras.ucalgary.ca>
	<3C34024A.EDA31D24@zip.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:
> Richard Gooch wrote:
> > 
> > > Instead, it appears that someone broke tty_name().  Here's the
> > > 2.2 kernel's version:
> > 
> > That "someone" was me, and I changed it from broken to fixed.
> > 
> 
> Look at serial.c:
> 
> #if (LINUX_VERSION_CODE > 0x2032D && defined(CONFIG_DEVFS_FS))
>         serial_driver.name = "tts/%d";
> #else
>         serial_driver.name = "ttyS";
> #endif
> 
> tty_name will just print "ttyS".   So the transition for this case
> was fixed->broken.

Why exactly is just "ttyS" broken?

> > No, originally tty_name() did it, and then I shifted it to the
> > drivers. I don't recall the reason, but it was necessary. So I don't
> > want this changed.
> 
> Oh dear.  Why cannot devfs expand the minor part itself?

Do you mean why devfs can't do it, or do you mean why tty_name() can't
do it? As I said, tty_name() used to do it, but there was some problem
with that.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
