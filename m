Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261241AbUKHV1z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261241AbUKHV1z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 16:27:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261247AbUKHV1z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 16:27:55 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:45578 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261241AbUKHV1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 16:27:44 -0500
Date: Mon, 8 Nov 2004 22:27:13 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-os@analogic.com
Cc: Pawe?? Sikora <pluto@pld-linux.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] kill IN_STRING_C
Message-ID: <20041108212713.GH15077@stusta.de>
References: <20041107142445.GH14308@stusta.de> <20041108161935.GC2456@wotan.suse.de> <20041108163101.GA13234@stusta.de> <200411081904.13969.pluto@pld-linux.org> <20041108183120.GB15077@stusta.de> <Pine.LNX.4.61.0411081410560.6407@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0411081410560.6407@chaos.analogic.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2004 at 02:12:18PM -0500, linux-os wrote:
> 
> On this compiler 3.3.3, -O2 will cause it to use strcpy().

Not for me:

        .file   "test.c"
        .section        .rodata.str1.1,"aMS",@progbits,1
.LC0:
        .string "%s"
        .text
        .p2align 4,,15
.globl test
        .type   test, @function
test:
        pushl   %ebp
        movl    %esp, %ebp
        subl    $12, %esp
        movl    %eax, 8(%esp)
        movl    $.LC0, %eax
        movl    %eax, 4(%esp)
        movl    $buf, (%esp)
        call    sprintf
        movl    %ebp, %esp
        popl    %ebp
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
        .ident  "GCC: (GNU) 3.3.5 (Debian 1:3.3.5-2)"



Are you using exactly my example file?
Are you using the complete gcc command line as shown by "make V=1"?
Which gcc 3.3.3 are you using?


> Cheers,
> Dick Johnson

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

