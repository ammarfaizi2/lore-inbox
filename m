Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267497AbTAQNDb>; Fri, 17 Jan 2003 08:03:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267498AbTAQNDa>; Fri, 17 Jan 2003 08:03:30 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:22001 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S267497AbTAQNDa>; Fri, 17 Jan 2003 08:03:30 -0500
X-Mailer: exmh version 2.5 13/07/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.4.33L2.0301171425070.19816-100000@vipe.technion.ac.il> 
References: <Pine.LNX.4.33L2.0301171425070.19816-100000@vipe.technion.ac.il> 
To: Shlomi Fish <shlomif@vipe.technion.ac.il>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ANN: LKMB (Linux Kernel Module Builder) version 0.1.16 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 17 Jan 2003 13:12:24 +0000
Message-ID: <25160.1042809144@passion.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>   print MAKEFILE "CFLAGS = -I/usr/src/linux/include -O2 -Wall -DMODULE -D__KERNEL__ -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2\n\n";

That's broken. you need to get the proper kernel CFLAGS, and you shouldn't 
assume there's anything useful in /usr/src/linux.

Use "/lib/modules/`uname -r`/build" as a default kernel directory, but 
allow it to be overridden somehow from the command line. Then do something 
like...

	make -C $(LINUXDIR) SUBDIRS=`pwd` modules

... to build your module. That way, all the kernel build stuff will be 
correct; it'll be just as if you were in a normal subdirectory of the 
kernel tree during a 'make modules' run.

--
dwmw2


