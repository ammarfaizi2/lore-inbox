Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265300AbUFOFvV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265300AbUFOFvV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 01:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265305AbUFOFvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 01:51:21 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:62732 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S265300AbUFOFvS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 01:51:18 -0400
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Eric Gillespie <viking@flying-brick.caverock.net.nz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: gcc3.3.2, kernel-2.6.6, and Mandrake 10.0 compiling problem.
Date: Tue, 15 Jun 2004 08:43:17 +0300
X-Mailer: KMail [version 1.4]
References: <Pine.LNX.4.21.0406151623590.9232-100000@brick.flying-brick.vpn>
In-Reply-To: <Pine.LNX.4.21.0406151623590.9232-100000@brick.flying-brick.vpn>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200406150843.17378.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 June 2004 07:35, Eric Gillespie wrote:
> Got a small problem, folks.  I've got a Mandrake 10.0 system (upgraded in
> bits and bobs, but that's not really relevant), with gcc-3.3.2,
> binutils-2.14.90.0.7 and a plain (linux.org) kernel tree patched from 2.6.0
> to 2.6.6. No -mm, no -ac, nothing except base.
>
> The system's a K6-2 @533 MHz, 192Mb memory (and 308 Mb swap). Plenty of
> hard disk space available.
>
> I was trying to compile the tree (make V=1) and got the following output.
> ----- start output -----
> ... other make lines omitted ...
> make -f scripts/Makefile.build obj=fs/nls
>   gcc -Wp,-MD,fs/nls/.tmp_nls_base.o.d -nostdinc -iwithprefix include
>   -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs
>   -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
>   -fno-unit-at-a-time -march=k6 -Iinclude/asm-i386/mach-default -O2
>   -DKBUILD_BASENAME=nls_base -KBUILD_MODNAME=nls_base -c
>   -o fs/nls/.tmp_nls_base.o  fs/nls/nls_base.c
> fs/nls/nls_base.c: In function `char2uni':
> fs/nls/nls_base.c:465: internal compiler error: Segmentation fault
> Please submit a full bug report,
> with preprocessed source if appropriate.
> See <URL:https://qa.mandrakesoft.com/> for instructions.
>
> ----- end output -----

Does this happen randomly, not in the same place each time?
If yes, this usually happens with flakey hardware.
I had this problem just yesterday. My box survives memtest86
and cpuburn, yet gcc segfaults within minute or two.
Relaxing DDR timing (Trcd: 2->3) eliminated segvs.

OTOH, note that there exist K6's with nasty bug:
in some very rare circumstances (you have to have more than 32MB or RAM,
you must modify data lying exactly N*32MB away from your current
instruction pointer, etc...) CPU erroneously execute an instruction
twice. As you can imagine, that will make your computer very unhappy.

Google for this bug.

> Fine, I said. I eliminated all the obvious aspects, such as CPU
> overheating, bad memory, etc. This particular item happened consistently,
> and happened no matter what the load on the machine, nor what time of the
> day. Other programs seem to compile fine on it (i.e. ne2k-pci-diag.c, once
> I turned all the multi-line strings into one single string with embedded
> newlines).
-- 
vda
