Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265095AbTAUGUx>; Tue, 21 Jan 2003 01:20:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265187AbTAUGUx>; Tue, 21 Jan 2003 01:20:53 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:17335 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id <S265095AbTAUGUw>;
	Tue, 21 Jan 2003 01:20:52 -0500
Date: Tue, 21 Jan 2003 06:29:54 +0000 (GMT)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: linux-kernel@vger.kernel.org
Subject: elf loader and differing inode mappings..
Message-ID: <Pine.LNX.4.44.0301210620310.8917-100000@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
	first off I'm running a stock 2.4.19 and have the RH8.0 glibc and
linker and toolchain..

I have modified my kernel to do some CRC'ing of text segments and it seems
to be working fine.. except when I load a program which hasn't been
stripped and I can't understand this..

I've locked all pages in memory by setting def_flags to VM_LOCKED in
fork.c, and I'm using the inode of the file (gotten from do_mmap_pgoff) to
give me the physical pages of where the file is actually mapped,
(i_mapping->clean_pages), and CRCing the pages mapped with
PROT_READ|PROT_EXEC. This was fine until I realised kernel loaded objects
(executable, dynamic linker) don't work quite so well with this due to
relocations and things.. so I then put some hooks in to load_elf_binary
and load_elf_interpreter along with some ELF header reading code to store
the start and end of the text segment within the inode,

This works for all cases except where the executable has not been
stripped, for some reason the clean_pages list changes between the kernel
loading the binary and my CRC thread coming along later and checking it ..
but *only* for unstripped binaries.. which as far as I can see should make
no difference whatsoever...

Any ideas?
Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied@skynet.ie
pam_smb / Linux DecStation / Linux VAX / ILUG person


