Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262425AbVBXR0b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262425AbVBXR0b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 12:26:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262434AbVBXR0b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 12:26:31 -0500
Received: from ns1.coraid.com ([65.14.39.133]:2953 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S262425AbVBXR02 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 12:26:28 -0500
To: Alexey Dobriyan <adobriyan@mail.ru>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] aoe: fix abuse of arrays and sparse warnings
References: <200502240318.23155.adobriyan@mail.ru>
From: Ed L Cashin <ecashin@coraid.com>
Date: Thu, 24 Feb 2005 12:23:37 -0500
Message-ID: <87k6oxan3a.fsf@coraid.com>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Dobriyan <adobriyan@mail.ru> writes:

> Signed-off-by: Alexey Dobriyan <adobriyan@mail.ru>

Hi.  Thanks for the patch.  Have you tested it?  If you don't have any
ATA over Ethernet hardware, you can using the alpha vblade program for
testing.  (Run it on a system in the broadcast domain of the host
running your patched aoe driver, and vblade will export any file,
e.g., /dev/loop0, as block storage.)  It's at

  http://sf.net/projects/aoetools

I was trying to determine what sparse warnings you see, so I got
sparse from bk://sparse.bkbits.net/sparse and ran it.  Your patch cuts
down significantly on the complaints, but there are some that persist.
Maybe you're using an older version of sparse?


  ecashin@kokone linux-2.6.11-rc4-bk9$ make C=1
    CHK     include/linux/version.h
  make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
    CHK     include/asm-i386/asm_offsets.h
    CHK     include/linux/compile.h
    CHK     usr/initramfs_list
    CHECK   drivers/block/aoe/aoeblk.c
    CC [M]  drivers/block/aoe/aoeblk.o
    CHECK   drivers/block/aoe/aoechr.c
  drivers/block/aoe/aoechr.c:236:24: warning: symbol 'aoe_fops' was not declared. Should it be static?

This change has been made already, so I'll check whether I've pushed
the change up.  I have a couple of things I haven't submitted yet.

    CC [M]  drivers/block/aoe/aoechr.o
    CHECK   drivers/block/aoe/aoecmd.c
  drivers/block/aoe/aoecmd.c:27:17: warning: incorrect type in assignment (different base types)
  drivers/block/aoe/aoecmd.c:27:17:    expected unsigned short [unsigned] protocol
  drivers/block/aoe/aoecmd.c:27:17:    got restricted unsigned short [usertype] [force] <noident>
    CC [M]  drivers/block/aoe/aoecmd.o
    CHECK   drivers/block/aoe/aoedev.c
    CC [M]  drivers/block/aoe/aoedev.o
    CHECK   drivers/block/aoe/aoemain.c
    CC [M]  drivers/block/aoe/aoemain.o
    CHECK   drivers/block/aoe/aoenet.c
  drivers/block/aoe/aoenet.c:156:10: warning: incorrect type in initializer (different base types)
  drivers/block/aoe/aoenet.c:156:10:    expected unsigned short [unsigned] type
  drivers/block/aoe/aoenet.c:156:10:    got restricted unsigned short [usertype] [force] <noident>
    CC [M]  drivers/block/aoe/aoenet.o
    LD [M]  drivers/block/aoe/aoe.o
  Kernel: arch/i386/boot/bzImage is ready
    Building modules, stage 2.
    MODPOST
    CC      drivers/block/aoe/aoe.mod.o
    LD [M]  drivers/block/aoe/aoe.ko
  ecashin@kokone linux-2.6.11-rc4-bk9$ 
  
The "array abuse" is something that I'm not all that enthusiastic
about changing, since it's mostly a style issue, and last time I
changed it the way your patch does, the original author of the patch
changed it back.  But you've figured out how to make sparse happy, and
for that I'm grateful!  :)

-- 
  Ed L Cashin <ecashin@coraid.com>

