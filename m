Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262637AbTJNRog (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 13:44:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262676AbTJNRof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 13:44:35 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:35594 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S262637AbTJNRod (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 13:44:33 -0400
Date: Tue, 14 Oct 2003 19:44:31 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Mark Hounschell <markh@compro.net>
Cc: linux-kernel@vger.kernel.org, dmarkh@cfl.rr.com
Subject: Re: Can't build external module against 2.6.0-test6 kernel
Message-ID: <20031014174431.GA922@mars.ravnborg.org>
Mail-Followup-To: Mark Hounschell <markh@compro.net>,
	linux-kernel@vger.kernel.org, dmarkh@cfl.rr.com
References: <3F8544DF.85E7CA81@compro.net> <20031009152350.GA897@mars.ravnborg.org> <3F8BDDE5.84074872@compro.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F8BDDE5.84074872@compro.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 14, 2003 at 07:28:37AM -0400, Mark Hounschell wrote:
> Ok, I can now build it but I have to hardcode _my_ include directories in the
> Makefile like:
> 
> /home/markh/work2/pcirtom_tst/driver/Makefile:
> 
> EXTRA_CFLAGS = -I/home/markh/work2/pcirtom_tst/include/linux/sys
> -I/home/markh/work2/pcirtom_tst/include/linux
> -I/home/markh/work2/pcirtom_tst/include
Use:
EXTRA_CFLAGS := -I$(src)/include/linux/sys
EXTRA_CFLAGS += -I$(src)/include/linux
EXTRA_CFLAGS += -I$(src)/include

[Sidenote - you should only need the second line. Files in include/sys
should be included as:
#include <sys/file.h>

And there should be no .h files in the linux directory].

> ifneq   ($(KERNELRELEASE),)
>         obj-m   += rtom.o
> else
>         KDIR    := /lib/modules/$(shell uname -r)/build
>         PWD     := $(shell pwd)
> default:
>         $(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules
> endif
> 
> My driver tree looks like
> 
> driver/
> include/
> diags/
> samples/
> library/
> 
> I've also tried setting the EXTRA_CFLAGS var in the top makefile but it
> doesn't seem to get passed down when the driver is compiled??
EXTRA_CFLAGS are only relevant for the current kbuild Makefile - so
it does not make sense to add it to the top-level Makefile.

	Sam
