Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261801AbVCQUF1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261801AbVCQUF1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 15:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbVCQUF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 15:05:27 -0500
Received: from mini002.webpack.hosteurope.de ([80.237.130.131]:44499 "EHLO
	mini002.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S261801AbVCQUFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 15:05:10 -0500
Subject: Re: Call for help: list of machines with working S3
From: Maximilian Engelhardt <maxi@daemonizer.de>
Reply-To: maxi@daemonizer.de
To: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3xVNA-Qn-43@gated-at.bofh.it>
References: <3xVNA-Qn-43@gated-at.bofh.it>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 17 Mar 2005 21:05:12 +0100
Message-Id: <1111089912.9802.26.camel@mobile>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-02-14 at 22:20 +0100, Pavel Machek wrote:
> Hi!
> 
> Stefan provided me initial list of machines where S3 works (including
> video). If you have machine that is not on the list, please send me a
> diff. If you have eMachines... I'd like you to try playing with
> vbetool (it worked for me), and if it works for you supplying right
> model numbers.
> 
> 								Pavel
> 
> 
> 		Video issues with S3 resume
> 		~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 		  2003-2005, Pavel Machek
> 
> During S3 resume, hardware needs to be reinitialized. For most
> devices, this is easy, and kernel driver knows how to do
> it. Unfortunately there's one exception: video card. Those are usually
> initialized by BIOS, and kernel does not have enough information to
> boot video card. (Kernel usually does not even contain video card
> driver -- vesafb and vgacon are widely used).
> 
> This is not problem for swsusp, because during swsusp resume, BIOS is
> run normally so video card is normally initialized. S3 has absolutely
> no change to work with SMP/HT. Be sure it to turn it off before
> testing (swsusp should work ok, OTOH).
> 
> There are few types of systems where video works after S3 resume:
> 
> (1) systems where video state is preserved over S3.
> 
> (2) systems where it is possible to call video bios during S3
>   resume. Unfortunately, it is not correct to call video BIOS at that
>   point, but it happens to work on some machines. Use
>   acpi_sleep=s3_bios.
> 
> (3) systems that initialize video card into vga text mode and where BIOS
>   works well enough to be able to set video mode. Use
>   acpi_sleep=s3_mode on these.
> 
> (4) on some systems s3_bios kicks video into text mode, and
>   acpi_sleep=s3_bios,s3_mode is needed.
> 
> (5) radeon systems, where X can soft-boot your video card. You'll need
>   patched X, and plain text console (no vesafb or radeonfb), see
>   http://www.doesi.gmxhome.de/linux/tm800s3/s3.html.
> 
> (6) other radeon systems, where vbetool is enough to bring system back
>   to life. Do vbetool vbestate save > /tmp/delme; echo 3 > /proc/acpi/sleep;
>   vbetool post; vbetool vbestate restore < /tmp/delme; setfont
>   <whatever>, and your video should work.

Tried all this on my Laptop but nothing seems to work for me. 
I do "echo 3 > /proc/acpi/sleep" and the systems seems to go into S3.
When I press some key to wake it up again it powers up but I get nothing
than a black screen. It's not only the video card that's not working,
because the only thing it reacts to is Sysrq (without screen of course).
One additional thing I found is that in this state the HDD led keeps
lighting all the time untill I reboot my system. After rebooting I
couldn't find anything interesting in my logs.

Is there any way I could get S3 working on my laptop?

some data:
Acer Travel Mate 661lci
Gentoo Base System version 1.6.10
kernel 2.6.11

I did all this testing with a minimal kernel that only had the
absolutely necessary drivers.

Thanks for help,
Maxi
