Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267241AbTA0Q4q>; Mon, 27 Jan 2003 11:56:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267242AbTA0Q4q>; Mon, 27 Jan 2003 11:56:46 -0500
Received: from [213.86.99.237] ([213.86.99.237]:49898 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S267241AbTA0Q4p>; Mon, 27 Jan 2003 11:56:45 -0500
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.3.96.1030127113639.26552A-100000@gatekeeper.tmr.com> 
References: <Pine.LNX.3.96.1030127113639.26552A-100000@gatekeeper.tmr.com> 
To: Bill Davidsen <davidsen@tmr.com>
Cc: Hal Duston <hald@sound.net>, linux-kernel@vger.kernel.org,
       Olaf Titz <olaf@bigred.inka.de>
Subject: Re: several messages 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 27 Jan 2003 16:59:35 +0000
Message-ID: <17490.1043686775@passion.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


davidsen@tmr.com said:
>  You make my point for me, there is no magic, and when building a
> module it should require that the directory be specified by either a
> command line option (as noted below) or by being built as part of a
> source tree. There *is* no good default in that particular case.

/lib/modules/`uname -r`/build _is_ a good default for a module to build 
again. It is correct in more cases than a simple failure to do anything.

For _installing_, the correct place to install the built objects is surely
/lib/modules/$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION) where the 
variables are obtained from the top-level Makefile in the kernel sources 
you built against.

You _default_ to building and installing for the current kernel, if it's
installed properly. But of course you should be permitted to override that 
on the command line.


> Related for sure, the point I was making was that there is no good
> default place to put modules built outside a kernel source tree (and
> probably also when built for multiple kernels).

I disagree. Modutils will look in only one place -- the /lib/modules/... 
directory corresponding to the kernel version for which you built each 
module. Each module, therefore, should go into the directory corresponding 
to the version of the kernel against which it was built.

Finding the appropriate _installation_ directory is trivial, surely? You 
can even find it from the 'kernel_version' stamp _inside_ the object file, 
without any other information?

--
dwmw2


