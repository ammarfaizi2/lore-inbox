Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263462AbTGOGbt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 02:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263542AbTGOGbt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 02:31:49 -0400
Received: from 12-240-128-156.client.attbi.com ([12.240.128.156]:52693 "EHLO
	carlthompson.net") by vger.kernel.org with ESMTP id S263462AbTGOGbs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 02:31:48 -0400
Message-ID: <1058251587.eec14da73ec3b@carlthompson.net>
X-Priority: 3 (Normal)
Date: Mon, 14 Jul 2003 23:46:27 -0700
From: Carl Thompson <cet@carlthompson.net>
To: linux-kernel@vger.kernel.org
Subject: Problems compiling modules outside of tree in 2.6.0test1
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) 4.0-cvs
X-Originating-IP: 192.168.0.163
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[This problem still exists in Linux 2.6.0test1]

I am not on the kernel mailing list so please CC with any responses.  I am
new to this kernel / module stuff so if I am doing something obviously
wrong please correct me gently!

Hello,

     I have noticed a problem when compiling kernel modules outside of the
kernel tree for 2.5(.75).  I am compiling a 3rd party network module for
2.5 and it needs to include "linux/netdevice.h" .  This file includes a
bunch of other kernel headers which in turn include more kernel headers.
This eventually gets to "asm/irq.h" and on my architechture (i386) this
file has the line

   #include "irq_vectors.h"

     The problem is that this "irq_vectors.h" file is not found in the same
directory as "irq.h" but in a different directory that is explicitly added
to the include path for the kernel in "arch/i386/Makefile" .   This is just
fine for kernel compiles using the kernel makefiles, but for stuff outside
of the tree it means that "irq_vectors.h" won't be found.  A solution would
be to to duplicate the relevant sections of the kernel's architecture
specific makefile stuff to calculate and add the include path myself, but
this seems unclean and would require me to add more architecture specific
voodoo for each architecture to be supported.

     I believe the proper solution would be for the kernel build system to
create a symbolic link to "irq_vectors.h" in "asm-i386/" just as "asm/"
itself is a symbolic link to "asm-i386/" instead of adding an include path
in the architecture specific makefile that breaks out-of-tree compiles.

Thank you,
Carl Thompson


