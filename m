Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262787AbTJNSbS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 14:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262870AbTJNSbS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 14:31:18 -0400
Received: from ip5.searssiding.com ([216.54.166.5]:25316 "EHLO
	texas.encore.com") by vger.kernel.org with ESMTP id S262787AbTJNSbM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 14:31:12 -0400
Message-ID: <3F8C40EC.FBA11955@compro.net>
Date: Tue, 14 Oct 2003 14:31:08 -0400
From: Mark Hounschell <markh@compro.net>
Reply-To: markh@compro.net
Organization: Compro Computer Svcs.
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.20-ert i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org, dmarkh@cfl.rr.com
Subject: Re: Can't build external module against 2.6.0-test6 kernel
References: <3F8544DF.85E7CA81@compro.net> <20031009152350.GA897@mars.ravnborg.org> <3F8BDDE5.84074872@compro.net> <20031014174431.GA922@mars.ravnborg.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> 
> On Tue, Oct 14, 2003 at 07:28:37AM -0400, Mark Hounschell wrote:
> > Ok, I can now build it but I have to hardcode _my_ include directories in the
> > Makefile like:
> >
> > /home/markh/work2/pcirtom_tst/driver/Makefile:
> >
> > EXTRA_CFLAGS = -I/home/markh/work2/pcirtom_tst/include/linux/sys
> > -I/home/markh/work2/pcirtom_tst/include/linux
> > -I/home/markh/work2/pcirtom_tst/include
> Use:
> EXTRA_CFLAGS := -I$(src)/include/linux/sys
> EXTRA_CFLAGS += -I$(src)/include/linux
> EXTRA_CFLAGS += -I$(src)/include
>
> [Sidenote - you should only need the second line. Files in include/sys
> should be included as:
> #include <sys/file.h>
> 
> And there should be no .h files in the linux directory].
>
> > ifneq   ($(KERNELRELEASE),)
> >         obj-m   += rtom.o
> > else
> >         KDIR    := /lib/modules/$(shell uname -r)/build
> >         PWD     := $(shell pwd)
> > default:
> >         $(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules
> > endif
> >
> > My driver tree looks like
> >
> > driver/
> > include/
> > diags/
> > samples/
> > library/
> >
> > I've also tried setting the EXTRA_CFLAGS var in the top makefile but it
> > doesn't seem to get passed down when the driver is compiled??
> EXTRA_CFLAGS are only relevant for the current kbuild Makefile - so
> it does not make sense to add it to the top-level Makefile.
> 
>         Sam

Thanks, defining the EXTRA-CFLAGS how and where you indicated did the trick.
Is there also now special tricks for getting a library that goes with the driver
to work? None of my IOCTLS are making it into the driver.

Ragards
Mark
