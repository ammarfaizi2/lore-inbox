Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265040AbUGIK0D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265040AbUGIK0D (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 06:26:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265074AbUGIK0D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 06:26:03 -0400
Received: from zero.aec.at ([193.170.194.10]:55049 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S265040AbUGIKZ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 06:25:59 -0400
To: akpm@osdl.org
Subject: gcc 3.5 compile fixes
cc: linux-kernel@vger.kernel.org
From: Andi Kleen <ak@muc.de>
Date: Fri, 09 Jul 2004 12:25:56 +0200
Message-ID: <m3r7rlpjd7.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I tried to compile 2.6.7-bk9 with a recent gcc 3.5 snapshot on i386
and x86-64. It gave a lot of warnings and a lot of compile errors
for make allyesconfig.

On x86-64 it miscompiled the kernel (due to kernel bugs); I will send
fixes for that separately.

Most compile errors were about mixing extern and static declarations
of the same symbol. I fixed this all except for the au88x0 driver
in ALSA which had a too broken module setup (someone else will have 
to tackle that)

I got one gcc internal compiler error while compiling the sunrpc 
gss module. I filed an gcc bug for that. 

One problem was that it didn't always inline fix_to_virt() which
resulted in undefined symbols. (gcc 3.4 and up doesn't set always 
inline for normal inline). I fixed this by defining a new macro
__always_inline in compiler.h and using that for fix_to_virt

Another issue (I think already fixed in -mm) was that memmove()
needs to be moved out of line.

The result were a lot of patches for a lot of files. Instead
of spamming l-k with them all I put them in 
http://www.firstfloor.org/~andi/35/ 
Andrew, please consider adding them to your tree.

The resulting i386 kernel booted on one machine; but failed to find
the SCSI disks on another (didn't investigate what the problem 
was on the later, some more work needed on that)  

-Andi

