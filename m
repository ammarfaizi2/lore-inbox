Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265973AbUHSGhV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265973AbUHSGhV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 02:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265996AbUHSGhV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 02:37:21 -0400
Received: from [69.196.211.153] ([69.196.211.153]:62942 "EHLO
	mail.janderson.ca") by vger.kernel.org with ESMTP id S265973AbUHSGhS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 02:37:18 -0400
Message-ID: <41244A9F.70109@rogers.com>
Date: Thu, 19 Aug 2004 02:37:19 -0400
From: Jon Anderson <jon-anderson@rogers.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040812)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: vmlinuz no symtab? while cross compiling...
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm attempting to cross compile linux-2.6.8.1, along with a few external 
modules (madwifi, hostap-driver, aodv-uu). The kernel and (built-in) 
modules compile fine, but compiling every one of those external modules 
fails around MODPOST. For example, aodv-uu:

<snip userspace stuff>
make -C /home/janderson/var/autobuild/i386/root/usr/src/linux 
SUBDIRS=/home/janderson/var/tmp/autobuild/aodv-uu-0.8.1 modules
i486-linux-uclibc-gcc -Wall -O2 -DCONFIG_GATEWAY  -o aodvd main.o list.o 
debug.o timer_queue.o aodv_socket.o aodv_hello.o aodv_neighbor.o 
aodv_timeout.o routing_table.o seek_list.o k_route.o aodv_rreq.o 
aodv_rrep.o aodv_rerr.o packet_input.o packet_queue.o libipq.o icmp.o 
min_ipenc.o locality.o
make[1]: Entering directory 
`/home/janderson/var/autobuild/i386/root/usr/src/linux-2.6.8.1'
  CC [M]  /home/janderson/var/tmp/autobuild/aodv-uu-0.8.1/kaodv.o
  Building modules, stage 2.
  MODPOST
modpost: vmlinux no symtab?
/bin/sh: line 1:   798 Aborted                 scripts/mod/modpost -i 
/home/janderson/var/autobuild/i386/root/usr/src/linux-2.6.8.1/Module.symvers 
vmlinux /home/janderson/var/tmp/autobuild/aodv-uu-0.8.1/kaodv.o
make[2]: *** [__modpost] Error 134

madwifi and hostap-driver do the same thing: "vmlinux no symtab?".

I've messed around with cleaning out the scripts/mod directory, then 
running a make prepare (which seems to rebuild modpost), but that makes 
no difference.

For the moment, I can work around this (because I'm "cross compiling" 
for i486 on an i686 system) by just running make again in the kernel 
directory, but I would assume that wouldn't work when I have to do it 
for ppc. :-)

I guess I'm just looking for any information that might help me get rid 
of this error. Any pointers would be most welcome.

(Hopefully this is the right place to be posting such questions - if 
it's not, then I appologize.)

Cheers,

jon

