Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261172AbUKHSuB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261172AbUKHSuB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 13:50:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261188AbUKHSsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 13:48:43 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:59917 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261172AbUKHSby (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 13:31:54 -0500
Date: Mon, 8 Nov 2004 19:31:20 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Pawe?? Sikora <pluto@pld-linux.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] kill IN_STRING_C
Message-ID: <20041108183120.GB15077@stusta.de>
References: <20041107142445.GH14308@stusta.de> <20041108161935.GC2456@wotan.suse.de> <20041108163101.GA13234@stusta.de> <200411081904.13969.pluto@pld-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411081904.13969.pluto@pld-linux.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2004 at 07:04:13PM +0100, Pawe?? Sikora wrote:
> On Monday 08 of November 2004 17:31, you wrote:
> > On Mon, Nov 08, 2004 at 05:19:35PM +0100, Andi Kleen wrote:
> > > > Rethinking it, I don't even understand the sprintf example in your
> > > > changelog entry - shouldn't an inclusion of kernel.h always get it
> > > > right?
> > >
> > > Newer gcc rewrites sprintf(buf,"%s",str) to strcpy(buf,str)
> > > transparently.
> >
> > Which gcc is "Newer"?
> >
> > My gcc 3.4.2 didn't show this problem.
> 
> #include <stdio.h>
> #include <string.h>
> char buf[128];
> void test(char *str)
> {
>     sprintf(buf, "%s", str);
> }
>...
>         jmp     strcpy
>...


This is the userspace example.

The kernel example is:

#include <linux/string.h>
#include <linux/kernel.h>

char buf[128];
void test(char *str)
{
  sprintf(buf, "%s", str);
}


This results with gcc-3.4 (GCC) 3.4.2 (Debian 3.4.2-3) in:

        .file   "test.c"
        .section        .rodata.str1.1,"aMS",@progbits,1
.LC0:
        .string "%s"
        .text
        .p2align 4,,15
.globl test
        .type   test, @function
test:
        pushl   %eax
        pushl   $.LC0
        pushl   $buf
        call    sprintf
        addl    $12, %esp
        ret
        .size   test, .-test
.globl buf
        .bss
        .align 32
        .type   buf, @object
        .size   buf, 128
buf:
        .zero   128
        .section        .note.GNU-stack,"",@progbits
        .ident  "GCC: (GNU) 3.4.2 (Debian 3.4.2-3)"



cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

