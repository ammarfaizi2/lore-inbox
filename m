Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270436AbUJTW7z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270436AbUJTW7z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 18:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270367AbUJTWdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 18:33:21 -0400
Received: from wang.choosehosting.com ([212.42.1.230]:39045 "EHLO
	wang.choosehosting.com") by vger.kernel.org with ESMTP
	id S267619AbUJTWIm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 18:08:42 -0400
From: Thomas Stewart <thomas@stewarts.org.uk>
To: Paul Fulghum <paulkf@microgate.com>
Subject: Re: belkin usb serial converter (mct_u232), break not working
Date: Wed, 20 Oct 2004 23:08:02 +0100
User-Agent: KMail/1.6.2
References: <200410201946.35514.thomas@stewarts.org.uk> <1098307331.2818.15.camel@deimos.microgate.com>
In-Reply-To: <1098307331.2818.15.camel@deimos.microgate.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
X-PGP-Key: http://www.stewarts.org.uk/public-key.asc
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410202308.02624.thomas@stewarts.org.uk>
X-Scanner: Exiscan on wang.choosehosting.com at 2004-10-20 23:08:41
X-Spam-Score: 0.0
X-Spam-Bars: /
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 20 October 2004 22:22, you wrote:
> Try replacing ioctl(fd, TCSBRK, 0) with
> ioctl(fd, TCSBRKP, duration)
> duration is in 100ms units, so try 10 or 20.
>
> Or you can use tcsendbreak(fd, duration);
> I'm not sure of the units for this function on Linux
> manpage says 'implementation defined',
> a book I have says 250ms units in Linux.

I've tyred various combinations of ioctl(fd, TCSBRKP, x) and tcsendbreak(fd, 
x), where x is 2, 5, 10, 20 and 200.

One thing I did notice is that no mater what the value I use, it always 
finishes very quickly, there does not appear to be any duration.

take porttest.c:
#include <sys/fcntl.h>
#include <sys/ioctl.h>
main(int argc, char ** argv) {
        int fd = open(argv[1], O_RDWR|O_NOCTTY);
        ioctl(fd, TCSBRKP, 20);
        close(fd);
}

$ time ./porttest /dev/ttyS0
real    0m2.001s
user    0m0.001s
sys     0m0.000s

A standard serial port with a 2 second break (20*100ms), takes as expected 
just over 2 seconds.

$ time ./porttest /dev/ttyUSB1
real    0m0.004s
user    0m0.000s
sys     0m0.001s

However with the USB converter instead, it takes 5 ms to complete. Much 
shorter than expected.

Is it a driver issue?

Regards
-- 
Tom

PGP Fingerprint [DCCD 7DCB A74A 3E3B 60D5  DF4C FC1D 1ECA 68A7 0C48]
PGP Publickey   [http://www.stewarts.org.uk/public-key.asc]
PGP ID  [0x68A70C48]
