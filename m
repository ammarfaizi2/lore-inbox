Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267336AbUHSUEG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267336AbUHSUEG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 16:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267345AbUHSUEG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 16:04:06 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:20836 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S267336AbUHSUEA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 16:04:00 -0400
Date: Fri, 20 Aug 2004 00:04:20 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Jon Anderson <jon-anderson@rogers.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: vmlinuz no symtab? while cross compiling...
Message-ID: <20040819220420.GB7440@mars.ravnborg.org>
Mail-Followup-To: Jon Anderson <jon-anderson@rogers.com>,
	linux-kernel@vger.kernel.org
References: <41244A9F.70109@rogers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41244A9F.70109@rogers.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2004 at 02:37:19AM -0400, Jon Anderson wrote:
> I'm attempting to cross compile linux-2.6.8.1, along with a few external 
> modules (madwifi, hostap-driver, aodv-uu). The kernel and (built-in) 
> modules compile fine, but compiling every one of those external modules 
> fails around MODPOST. For example, aodv-uu:

Took a look at aodv-uu.
Author should learn to create a real Kbuild Makefile...
But that does not seem to be your problem.

> <snip userspace stuff>
> make -C /home/janderson/var/autobuild/i386/root/usr/src/linux 
> SUBDIRS=/home/janderson/var/tmp/autobuild/aodv-uu-0.8.1 modules
> i486-linux-uclibc-gcc -Wall -O2 -DCONFIG_GATEWAY  -o aodvd main.o list.o 
> debug.o timer_queue.o aodv_socket.o aodv_hello.o aodv_neighbor.o 
> aodv_timeout.o routing_table.o seek_list.o k_route.o aodv_rreq.o 
> aodv_rrep.o aodv_rerr.o packet_input.o packet_queue.o libipq.o icmp.o 
> min_ipenc.o locality.o
> make[1]: Entering directory 
> `/home/janderson/var/autobuild/i386/root/usr/src/linux-2.6.8.1'
>  CC [M]  /home/janderson/var/tmp/autobuild/aodv-uu-0.8.1/kaodv.o
>  Building modules, stage 2.
>  MODPOST
> modpost: vmlinux no symtab?
modpost complains that it cannot locate the symbol table in vmlinux.
That can be caused by the following reasons:

o vmlinux were build with different settings than scripts/mod
  - If you cleaned out scripts/mod/ and run make scripts with wrong ARCH options
o vmlinux has been stripped for some reason

> /bin/sh: line 1:   798 Aborted                 scripts/mod/modpost -i 
> /home/janderson/var/autobuild/i386/root/usr/src/linux-2.6.8.1/Module.symvers 
> vmlinux /home/janderson/var/tmp/autobuild/aodv-uu-0.8.1/kaodv.o
> make[2]: *** [__modpost] Error 134
> 
> madwifi and hostap-driver do the same thing: "vmlinux no symtab?".
> 
> I've messed around with cleaning out the scripts/mod directory, then 
> running a make prepare (which seems to rebuild modpost), but that makes 
> no difference.
> 
> For the moment, I can work around this (because I'm "cross compiling" 
> for i486 on an i686 system) by just running make again in the kernel 
> directory, but I would assume that wouldn't work when I have to do it 
> for ppc. :-)
Did not understand what you said here.


Please make sure that:
- Kernel is build with same ARCH=, CROSS_COMPILE option as modules
- That kernel is fully build, with same options

Please let me know if this info helped you fixing the problem.

	Sam
