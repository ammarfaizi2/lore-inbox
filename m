Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262228AbTIZOFz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 10:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262234AbTIZOFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 10:05:55 -0400
Received: from gaia.cela.pl ([213.134.162.11]:63237 "EHLO gaia.cela.pl")
	by vger.kernel.org with ESMTP id S262228AbTIZOFx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 10:05:53 -0400
Date: Fri, 26 Sep 2003 16:05:50 +0200 (CEST)
From: Maciej Zenczykowski <maze@cela.pl>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Syscall security
Message-ID: <Pine.LNX.4.44.0309261553180.6080-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm wondering if there is any way to provide per process bitmasks of 
available/illegal syscalls.  Obviously this should most likely be 
inherited through exec/fork.

For example specyfying that pid N should return -ENOSYS on all syscalls 
except read/write/exit.

The reason I'm asking is because I want to run totally untrusted 
statically linked binary code (automatically compiled from user 
submitted untrusted sources) which only needs read/write access to stdio 
which means it only requires syscalls read/write/exit + a few more for
memory alloc/free (like brk) + a few more generated before main is called 
(execve and uname I believe).

Currently I'm running the code in a chroot'ed environment (to an empty 
dir) under a 'nobody' uid/gid with no open fd's except for std in/out/err 
with limits for mem, processor usage, open files, processes (to 1), etc.
Obviously this still allows calling code like 'time', 'getuid', etc and 
the like.
Modifying the compiler (or removing the headers) won't help since at worst 
I can code it in asm in the source or even in a plain byte table.

I have a working (very much a hack) patch which turns of all but 7 (or 
so) of the syscalls (via pseudo-bitmaps).

Basically my question is: has this been done before (if so where/when?), 
what would be considered 'the right' way to do this, would this be a 
feature to include in the main kernel source?

Thanks,

MaZe.

