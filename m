Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261430AbUCAU1i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 15:27:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261423AbUCAU0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 15:26:48 -0500
Received: from fw.osdl.org ([65.172.181.6]:9409 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261430AbUCAUZI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 15:25:08 -0500
Date: Mon, 1 Mar 2004 12:24:28 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "Igor Yu. Zhbanov" <bsg@uniyar.ac.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: __buggy_fxsr_alignment() not found.
Message-Id: <20040301122428.7dc96b00.rddunlap@osdl.org>
In-Reply-To: <Pine.GSO.3.96.SK.1040229200132.17294A-100000@univ.uniyar.ac.ru>
References: <Pine.GSO.3.96.SK.1040229200132.17294A-100000@univ.uniyar.ac.ru>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Feb 2004 20:02:12 +0300 (MSK) Igor Yu. Zhbanov wrote:

| Hello!
| My system is:
| AMD K6-II 450
| Linux-2.4.24
| glibc-2.2.5
| 
| I cannot compile 2.4.24 kernel because linker says:
| init/main.o: In function `check_fpu':
| init/main.o(.text.init+0x53): undefined reference to `__buggy_fxsr_alignment'
| 
| It's prototype is in inculude/asm-i386/bugs.h:
| -----
| /* Enable FXSR and company _before_ testing for FP problems. */
|         /*
|          * Verify that the FXSAVE/FXRSTOR data will be 16-byte aligned.
|          */
|         if (offsetof(struct task_struct, thread.i387.fxsave) & 15) {
|               extern void __buggy_fxsr_alignment(void);
|               __buggy_fxsr_alignment();
| -----
| But there is no realisation of this function in source files.
| When I comment the lines above, everything works.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
This function is not supposed to be defined anywhere.
It is there to indicate a build error and to keep the kernel
build from completing successfully.

For some reason, with your config (and CPU arch.) and compiler,
the 'fxsave' field is not on a 16-byte alignment.  Have you applied
any patches to 2.4.24?  What version of gcc are you using (gcc -v)?

--
~Randy
