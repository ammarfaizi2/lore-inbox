Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266570AbUGKLc0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266570AbUGKLc0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 07:32:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266573AbUGKLcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 07:32:25 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:17672 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S266570AbUGKLcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 07:32:23 -0400
Date: Sun, 11 Jul 2004 12:32:17 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: binutils woes
Message-ID: <20040711123217.C13616@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
References: <20040701175231.B8389@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040701175231.B8389@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Thu, Jul 01, 2004 at 05:52:31PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 01, 2004 at 05:52:31PM +0100, Russell King wrote:
> I think the only way we can ensure kernel correctness is to add a
> subsequent stage to kbuild such that whenever we generate a final
> program, we grep the 'nm' output for undefined symbols.
...

BTW, binutils 2.15 on ARM has other issues, which I've reported to
Nick Clifton/binutils-bug.  The assembler seems to produce extra
symbolic information in the form of symbols starting with '$', eg:

c0067860 T __fput
c0067860 t $a
c0067954 t $d
c0067958 T fget
c0067958 t $a

Not only do these symbols interfere with ld's error reporting, but
they also interfere with kallsyms - the backtrace information from
such a kernel is not very useful when it reports function names of
'$a':

drivers/built-in.o(.text+0x6042c): In function `$a':
: relocation truncated to fit: R_ARM_PC24 .exit.text

Obviously not useful to anyone.

This seems to only affect binutils 2.15, so I think we should hang
fire on any work-arounds until the binutils folk have commented.

-- 
Russell King
 ... who dearly wishes that the kernel build was still compatible
  with the good old stable binutils 2.11 versions.
