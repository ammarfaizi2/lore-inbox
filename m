Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbTFJUFu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 16:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262299AbTFJUEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 16:04:43 -0400
Received: from amalthea.dnx.de ([193.108.181.146]:63908 "EHLO amalthea.dnx.de")
	by vger.kernel.org with ESMTP id S262262AbTFJUCp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 16:02:45 -0400
Date: Tue, 10 Jun 2003 22:16:24 +0200
From: Robert Schwebel <robert@schwebel.de>
To: linux-kernel@vger.kernel.org
Subject: init does not run on 405GP system
Message-ID: <20030610201624.GB16103@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Spam-Score: -2.5 (--)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19PpXX-00017h-00*QwHCy2G3hCg*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm currently porting u-boot and Linux to an IBM 405GP based board. The
problem is now that init seems not to be running and does not give any
output. Up to that point where init should make some noise the kernel
boots smoothly (serial console), I see all output and NFS-Root is
mounted via an Intel 82559 network chip. The kernel threads are also
running, I see kupdated & friends being put into the run queue from time
to time.

I have replaced /sbin/init by a statically linked "hello world" (which
also does not give any output). My impression is that the binary code of
the init ELF binary is never run. When I switch on the SHOW_SYSCALLs
macro in arch/ppc/kernel/entry.S I see the system calls for open(),
dup(), dup() and execve() which come from init/main.c. Opening the
console works, execve() to /sbin/init as well. When I follow the path of
execution up to load_elf_binary() in fs/binfmt_elf.c I can even see the
correct code being load and pointed to by elf_entry in that file. But
there is never any output from init, nor does something happen when I
replace init by a piece of code which should immediately make a zero
pointer exception.

Nevertheless, the kernel runs smoothly. I can ping the machine, I can
even floodping it with 0% packet loss. Only that there is no userspace
running.

Has anybody seen something like this before?

- Kernel is 2.4.21-rc2 with bitkeeper from 20030515 plus board port
- userland was tested with Debian bootdisks, Denx 4xx boot image and
  others
- toolchain is the Debian powerpc-linux cross toolchain.

Robert
--
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Braunschweiger Str. 79,  31134 Hildesheim, Germany
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
    Phone: +49-5121-28619-0 |  Fax: +49-5121-28619-4
