Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263027AbUDERd3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 13:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263021AbUDERd2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 13:33:28 -0400
Received: from asteroids.scarlet-internet.nl ([213.204.195.163]:37857 "EHLO
	asteroids.scarlet-internet.nl") by vger.kernel.org with ESMTP
	id S262931AbUDERdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 13:33:24 -0400
Message-ID: <1081186402.407198620a28b@webmail.dds.nl>
Date: Mon,  5 Apr 2004 19:33:22 +0200
From: wdebruij@dds.nl
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Subject: [ANNOUNCE] various linux kernel devtools : device handling/memory mapping/profiling/etc.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

  During development of a linux kernel network monitoring package (FFPF) I 
created a few kernelspace and cross-userspace/kernelspace tools that I hope 
others can benefit from too.

I haven't packages everything I wrote, just those elements that reduce
kernelsize and development time when multiple people use it. In its current 
state everything is functionally OK, but the code cannot as yet be merged 
into the kernel directly as I developed it outside of the main tree. Instead, 
I hope you will take a look at it and tell me what could be direct kernel 
material, and what should be changed or removed. After that I will supply 
individual patches against the latest version.

very briefly, the toolbox contains the following:

KERNEL specific:

- a generic device file interface, which abstracts away kernelversion 
differences, devfs/mknod/udev differences and memory addressing differences. 
The device API implements most of the standard device file handling code, 
including various memory mapping syscall handlers. With this interface driver 
developers will only have to override small pieces of code, instead of 
building everything from the ground up. I'm using it in 3 different modules, 
already. This is the 'jewel' of the package, and grepping the kernel sources 
I think many drivers could benefit from it (reduced size/complexity). 
Especially for beginner kernel hackers this could reduce the learning curve 
(and for those of you who've been going at it for a long time and forgot: 
it's quite steep :).

- a generic pci initialization interface. Could perhaps be merged with the 
existing PCI subsytem. I needed it for implementing a PCI driver (more below)
- a module API that abstracts away kernel version differences. 

CROSS kernel/userspace (ie, works in both) :
- verbosity level-based debugging, with optional timing/clockcycle and 
location information
- clockcycle profiling: the profiler outputs aggregated stats, such as the 
median to /proc and optionally through the debugging interface above.
- a multi-policy circular buffer. A buffer where the handling code responds to
policy decisions, such as whether writers should be aware of readers and if 
so, how they should respond. I use it for network packet queueing to 
userspace.
- some simpler stuff: hashes, stacks (should probably go).

also included in the distribution are demonstrator modules and userspace 
programs. The pci module, for example, implements a mmapped interface to any 
PCI device's resources. Just supply a vendor id/device id pair on insmod. 
Could in itself perhaps be useful for userspace drivers. I've been using it 
to initialize a network processor board over the PCI bus.

  since most of my software has to be able to run both in kernel- and in 
userspace I cannot simply supply a patch at the moment, I'm sorry. Instead, 
I've packaged the sourcecode (all GPL'ed, naturally) and uploaded it to our 
project's site at sourceforge:

URL: http://osdn.dl.sourceforge.net/sourceforge/ffpf/lkct-1.0.tgz

it's about 35kB. 

Please have a look and send me your remarks. I would find it a shame if I end 
up being the only one using this stuff. I would rather put some extra effort 
into changing it to get it accepted.

cheers,

  Willem

-- 
Willem de Bruijn
+31 6 2695 2446
+31 71 517 7174
wdebruij_at_dds.nl
http://www.wdebruij.dds.nl/

current project : 
Fairly Fast Packet Filter (FFPF)
http://ffpf.sourceforge.net/



