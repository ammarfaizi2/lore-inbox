Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270345AbUJUM4P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270345AbUJUM4P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 08:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268655AbUJUMmx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 08:42:53 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:5455 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S268902AbUJUMmA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 08:42:00 -0400
Subject: Re: belkin usb serial converter (mct_u232), break not working
From: Paul Fulghum <paulkf@microgate.com>
To: Thomas Stewart <thomas@stewarts.org.uk>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20041021100637.GA7003@diamond>
References: <200410201946.35514.thomas@stewarts.org.uk>
	 <200410202308.02624.thomas@stewarts.org.uk>
	 <1098311228.6006.3.camel@at2.pipehead.org>
	 <200410210004.13214.thomas@stewarts.org.uk>
	 <1098326278.6017.19.camel@at2.pipehead.org> <20041021100637.GA7003@diamond>
Content-Type: text/plain
Message-Id: <1098362487.2815.9.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 21 Oct 2004 07:41:27 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-10-21 at 05:06, Thomas Stewart wrote:
> I tryed again with your patch applyed, with both minicom and porttest
> 
> porttest.c:
> #include <sys/fcntl.h>
> #include <sys/ioctl.h>
> main(int argc, char ** argv) {
>         int r, fd = open(argv[1], O_RDWR|O_NOCTTY);
>         r=ioctl(fd, TCSBRKP, 20);
>         printf("%d\n", r);
>         close(fd);
> }
> 
> $ time ./porttest /dev/ttyS0
> 0
> 
> real    0m2.001s
> user    0m0.000s
> sys     0m0.001s
> $ time ./porttest /dev/ttyUSB0
> 0
> 
> real    0m2.003s
> user    0m0.000s
> sys     0m0.001s
> 
> As you can see, this time there is the correct pause. However
> it still does not send the break.
> 
> To add the mix, I dug about and found a differnt type of USB serial
> converter, a no-brand one that uses the pl2303 module. Both minicom
> and porttest with either stock 2.6.8.1 or 2.6.8.1 with your patch
> send the break fine with this different converter.
> 
> This makes me think it is a problem with the mct_u232 driver?

OK. This problem has multiple parts.

The change to tty_io.c is necessary to get the proper delay
between setting and clearing break. I will submit that
patch for inclusion.

Now it is a matter of figuring why the device is not
sending the break. The device break_ctl() gets called,
and the URB to set the line control is sent successfully.

Maybe the comments are wrong on the line control bits
or possibly the Belkin device requires some other setup
to send breaks.

I'll see if I can figure anything out.

-- 
Paul Fulghum
paulkf@microgate.com

