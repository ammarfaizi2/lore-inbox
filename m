Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132765AbRDIPC6>; Mon, 9 Apr 2001 11:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132767AbRDIPCs>; Mon, 9 Apr 2001 11:02:48 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:40970 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S132765AbRDIPCg>;
	Mon, 9 Apr 2001 11:02:36 -0400
Date: Mon, 9 Apr 2001 17:02:27 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Miquel van Smoorenburg <miquels@cistron-office.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: build -->/usr/src/linux
Message-ID: <20010409170227.B17914@pcep-jamie.cern.ch>
In-Reply-To: <3AD079EA.50DA97F3@rcn.com> <3AD0A029.C17C3EFC@rcn.com> <9aqmci$gn2$1@ncc1701.cistron.net> <20010409010103.A16562@pcep-jamie.cern.ch> <9as6fl$gmq$1@ncc1701.cistron.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <9as6fl$gmq$1@ncc1701.cistron.net>; from miquels@cistron-office.nl on Mon, Apr 09, 2001 at 11:29:57AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miquel van Smoorenburg wrote:
> >There is a way though I'd not call it clean.  Here is an extract from
> 
> Do you think something like this is the correct approach? If it
> was part of the official kernel you could write a Makefile like this:
>
> [code to creake /lib/modules/`uname -r`/config.mak

I agree with that idea in principle, although for quite a while
something else is required, to deal with older kernels.  You'll notice
that my fragment greps for SMP from the kernel's Makefile: that is to
deal with 2.2 kernels and isn't required for 2.4 kernels.  This is not
an issue if you only care about future-compatibility.

Fortunately, the file $(KERNEL_SOURCE)/arc/$(ARCH)/Makefile provides
most of the variables like CFLAGS et al.

Unfortunately, determining ARCH is rather ugly.  I copied the expression
from the kernel's top level Makefile.

One more thing: some systems do not have a /lib/modules directory.  On
those systems it's good to hunt in /usr/src/linux.

> -modules: include/config/MARKER $(patsubst %, _mod_%, $(SUBDIRS))  
> +modules: include/config/MARKER $(patsubst %, _mod_%, $(SUBDIRS))  \
> +		include/linux/config.mak

The file needs to be created even if you don't do `make modules'.  Some
kernels will support third party modules, but don't actually have any
modules of their own.

> +include/linux/config.mak: ./Makefile

This must depend on the configuration somehow.  If the kernel's
reconfigured, a new file needs to be created.  For 2.2 kernels it must
depend on whether SMP is defined too.

-- Jamie
