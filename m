Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273406AbRIWLaq>; Sun, 23 Sep 2001 07:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273413AbRIWLa0>; Sun, 23 Sep 2001 07:30:26 -0400
Received: from daleth.esc.cam.ac.uk ([131.111.64.59]:30479 "EHLO
	beth.esc.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S273406AbRIWLaT>; Sun, 23 Sep 2001 07:30:19 -0400
Date: Sun, 23 Sep 2001 12:30:42 +0100
From: James McKenzie <kernel@ostrich.dhs.org>
To: linux-kernel@vger.kernel.org
Subject: alpha 4K mmap offsets and em86
Message-ID: <20010923123042.B32649@hecate.esc.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
X-Mail-Author: fish
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

very sorry if this has been discussed before I couldn't
find any references in the archive. There is a program
on the alpha architecture which can (with a little help
from the kernel) execute ia32 linux binaries it's useful
if you need to run badly written 32 bit code.

The emulator needs to mmap elf binaries in, and 
offsets in ia32 elf files are 4k aligned for a 4k
pagesize. On 2.2 on an alpha you could do
mmap(NULL,3176, ... , fd, 0x1000);
but now in 2.4 but in 2.4 it returns EINVAL.

The code in mm/mmap.c and vm_area_struct seem to
now count the offset in pages rather than bytes, 
which would make fixing this ugly [maybe an element
in the structure to store 'slop' ?]

I can fix static binaries by patching an ia32 ld
to generate 8k alignments and running ld on the
binary  - but I suspect this problem will surface 
again once ia64 takes off.

Any ideas or pointers very welcome,

Thanks,

James.






