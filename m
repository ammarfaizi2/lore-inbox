Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262365AbTJNL2l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 07:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262374AbTJNL2l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 07:28:41 -0400
Received: from ip5.searssiding.com ([216.54.166.5]:39640 "EHLO
	texas.encore.com") by vger.kernel.org with ESMTP id S262365AbTJNL2j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 07:28:39 -0400
Message-ID: <3F8BDDE5.84074872@compro.net>
Date: Tue, 14 Oct 2003 07:28:37 -0400
From: Mark Hounschell <markh@compro.net>
Reply-To: markh@compro.net
Organization: Compro Computer Svcs.
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.20-ert i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: dmarkh@cfl.rr.com
Subject: Re: Can't build external module against 2.6.0-test6 kernel
References: <3F8544DF.85E7CA81@compro.net> <20031009152350.GA897@mars.ravnborg.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> 
> On Thu, Oct 09, 2003 at 07:22:07AM -0400, Mark Hounschell wrote:
> > I'm trying to build a driver external to the kernel. I'm running 2.6.0-test6
> > kernel.
> > It appears to me (I'm probably wrong) that there is a kernel include file issue.
> Please follow Documentation/kbuild/modules.txt when building
> external modules.
> 
> Please come back if you continue to have problems.
> 
>         Sam
Ok, I can now build it but I have to hardcode _my_ include directories in the
Makefile like:

/home/markh/work2/pcirtom_tst/driver/Makefile:

EXTRA_CFLAGS = -I/home/markh/work2/pcirtom_tst/include/linux/sys
-I/home/markh/work2/pcirtom_tst/include/linux
-I/home/markh/work2/pcirtom_tst/include

ifneq   ($(KERNELRELEASE),)
        obj-m   += rtom.o
else
        KDIR    := /lib/modules/$(shell uname -r)/build
        PWD     := $(shell pwd)
default:
        $(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules
endif

My driver tree looks like

driver/
include/
diags/
samples/
library/

I've also tried setting the EXTRA_CFLAGS var in the top makefile but it doesn't
seem to get passed down when the driver is compiled?? I've also tried creating a
link in the driver directory pointing back to the include dir and adjusting the
paths in the EXTRA_CFLAGS to 
-Iinclude/linux/sys -Iinclude/linux -Iinclude to no avail.

Thanks
Mark
