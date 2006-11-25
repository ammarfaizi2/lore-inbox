Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966680AbWKYQvH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966680AbWKYQvH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 11:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966691AbWKYQvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 11:51:06 -0500
Received: from dslb-088-064-004-040.pools.arcor-ip.net ([88.64.4.40]:56705
	"EHLO alatau.radix50.net") by vger.kernel.org with ESMTP
	id S966680AbWKYQvF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 11:51:05 -0500
Date: Sat, 25 Nov 2006 17:50:54 +0100
From: Baurzhan Ismagulov <ibr@radix50.net>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: tty line discipline driver advice sought, to do a 1-byte header and 2-byte CRC checksum on GSM data
Message-ID: <20061125165054.GA23585@radix50.net>
Mail-Followup-To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
	linux-kernel@vger.kernel.org
References: <20061125040614.GI16214@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061125040614.GI16214@lkcl.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Luke,

On Sat, Nov 25, 2006 at 04:06:14AM +0000, Luke Kenneth Casson Leighton wrote:
> i've never encountered tty line discipline's before.  which one is the
> best example that i should start with to cut/paste?

The second link by Guennadi is very good.

You can think of ldiscs as a layer between the serial driver and the
application. You fill struct tty_ldisc and call tty_register_ldisc. The
app opens a tty device and calls the TIOCSETD ioctl on it. The app (the
"above") sees the usual driver API -- read, write, etc. Your routines
manipulate the data as you like; you call tty->driver.write to write to
the serial driver (the "below"). The serial driver can call your
routines to tell you that, e.g., it has data for you, etc. You may
convert the data, buffer it till the app calls your read, etc.

You can find many examples if you search for tty_register_ldisc in the
kernel tree. However, understanding how this works and reading
include/linux/tty_ldisc.h should be enough.

With kind regards,
Baurzhan.

P.S. I'm subscribed only to linux-arm-kernel.
