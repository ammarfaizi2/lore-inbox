Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266339AbUGAWWl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266339AbUGAWWl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 18:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266348AbUGAWWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 18:22:23 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:40466 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S266339AbUGAWWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 18:22:11 -0400
Date: Thu, 1 Jul 2004 23:22:07 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: azarah@nosferatu.za.org, trini@kernel.crashing.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: binutils woes
Message-ID: <20040701232207.H8389@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, azarah@nosferatu.za.org,
	trini@kernel.crashing.org, linux-kernel@vger.kernel.org,
	torvalds@osdl.org
References: <20040701175231.B8389@flint.arm.linux.org.uk> <20040701174731.GD15960@smtp.west.cox.net> <20040701190720.C8389@flint.arm.linux.org.uk> <1088711048.8875.5.camel@nosferatu.lan> <20040701205255.F8389@flint.arm.linux.org.uk> <20040701231256.G8389@flint.arm.linux.org.uk> <20040701152134.7fd0fd1b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040701152134.7fd0fd1b.akpm@osdl.org>; from akpm@osdl.org on Thu, Jul 01, 2004 at 03:21:34PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 01, 2004 at 03:21:34PM -0700, Andrew Morton wrote:
> Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> >
> > Essentially, we run 'nm' against the object, and look for any line
> > which matches the pattern '^ *U '.  With this, a failing output looks
> > like:
> > 
> >   LD      init/built-in.o
> >   LD      .tmp_vmlinux1
> > ldchk: .tmp_vmlinux1: final image has undefined symbols:
> >   SIZEOF_MACHINE_DESC
> 
> What is the user supposed to do when this happens?

Report it as an error to the most appropriate forum.  Then it becomes
a hunt for why the symbol is undefined.

Sorry, afaics it's not possible to do this any better.

To illustrate the severity of the problem better, the following
program:

        .globl  _start
_start:
        add     r0, r0, #UNDEFINED_SYMBOL
        mov     pc, lr

will successfully assemble and link on ARM, and is in fact runnable
despite having a symbol table of the following:

$ arm-linux-nm t
00008074 t $a
0001007c A __bss_end__
0001007c A _bss_end__
0001007c A __bss_start
0001007c A __bss_start__
0001007c D __data_start
0001007c A _edata
0001007c A _end
0001007c A __end__
00008074 T _start
         U UNDEFINED_SYMBOL


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
