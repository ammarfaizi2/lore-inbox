Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290849AbSBLJII>; Tue, 12 Feb 2002 04:08:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290841AbSBLJH6>; Tue, 12 Feb 2002 04:07:58 -0500
Received: from smtp1.vol.cz ([195.250.128.73]:34569 "EHLO smtp1.vol.cz")
	by vger.kernel.org with ESMTP id <S290839AbSBLJHx>;
	Tue, 12 Feb 2002 04:07:53 -0500
Date: Mon, 11 Feb 2002 21:13:17 +0100
From: Pavel Machek <pavel@suse.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: Internal compiler error in 2.4.5 (gcc 2.95.4)
Message-ID: <20020211201316.GA9688@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasin\g
-fno-common -pipe -mpreferred-stack-boundary=2 -march=i386
-DKBUILD_BASENAME=blkpg  -DEXPORT_SYMTAB -c blkpg.c
blkpg.c: In function `blk_ioctl':
blkpg.c:326: Internal compiler error:
blkpg.c:326: internal error--unrecognizable insn:
(insn 1385 2051 1394 (set (reg/v:SI 3 %ebx)
        (asm_operands/v ("1:    movl %%eax,0(%2)
2:      movl %%edx,4(%2)
3:
.section .fixup,"ax"
4:      movl %3,%0
        jmp 3b
.previous
.section __ex_table,"a"
        .align 4
        .long 1b,4b
        .long 2b,4b
.previous") ("=r") 0[
                (reg:DI 1 %edx)
                (reg/v:SI 5 %edi)
                (const_int -14 [0xfffffff2])
                (reg/v:SI 3 %ebx)
            ]
            [
                (asm_input:DI ("A"))
                (asm_input:SI ("r"))
...

I'm sure someone saw this already. What's the solution? (Apart from
updating gcc, which I'd hate to do over my modem line just now.)
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
