Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277821AbRJMLdu>; Sat, 13 Oct 2001 07:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277720AbRJMLdk>; Sat, 13 Oct 2001 07:33:40 -0400
Received: from cobae1.consultronics.on.ca ([205.210.130.26]:18822 "EHLO
	cobae1.consultronics.on.ca") by vger.kernel.org with ESMTP
	id <S278236AbRJMLdf>; Sat, 13 Oct 2001 07:33:35 -0400
Date: Sat, 13 Oct 2001 07:34:06 -0400
From: Greg Louis <glouis@dynamicro.on.ca>
To: LKML <linux-kernel@vger.kernel.org>
Subject: gcc 3.0.1 fails to compile 8139too.c in 2.4.12ac1
Message-ID: <20011013073406.A5374@athame.dynamicro.on.ca>
Reply-To: Greg Louis <glouis@dynamicro.on.ca>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Organization: Dynamicro Consulting Limited
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In linux-2.4.1-ac12, drivers/net/8139too.c makes gcc 3.0.1 fail; gcc 2.95.3
compiles the same code correctly.  This, of course, is something the gcc
folks need to address, but I post it here fyi.

# gcc --version
3.0.1
...

gcc -D__KERNEL__ -I/usr/kernel/linux-2.4.12ac1/include -Wall \
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer \
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 \
-march=i686    -c -o 8139too.o 8139too.c
8139too.c: In function `netdev_ethtool_ioctl':
8139too.c:2419: Unrecognizable insn:
(insn/i 612 1054 1051 (parallel[ 
            (set (reg:SI 6 ebp)
                (asm_operands:SI ("addl %3,%1 ; sbbl %0,%0; cmpl %1,%4; \
sbbl $0,%0") ("=&r") 0[ 
                        (reg/v:SI 1 edx [166])
                        (mem:SI (plus:SI (reg/f:SI 6 ebp)
                                (const_int -352 [0xfffffea0])) 0)
                        (mem/s:SI (plus:SI (reg:SI 0 eax [174])
                                (const_int 12 [0xc])) 0)
                    ] 
                    [ 
                        (asm_input:SI ("1"))
                        (asm_input:SI ("g"))
                        (asm_input:SI ("g"))
                    ] \
("/usr/kernel/linux-2.4.12ac1/include/asm/uaccess.h") 558))
            (set (reg/v:SI 1 edx [166])
                (asm_operands:SI ("addl %3,%1 ; sbbl %0,%0; cmpl %1,%4; \
sbbl $0,%0") ("=r") 1[ 
                        (reg/v:SI 1 edx [166])
                        (mem:SI (plus:SI (reg/f:SI 6 ebp)
                                (const_int -352 [0xfffffea0])) 0)
                        (mem/s:SI (plus:SI (reg:SI 0 eax [174])
                                (const_int 12 [0xc])) 0)
                    ] 
                    [ 
                        (asm_input:SI ("1"))
                        (asm_input:SI ("g"))
                        (asm_input:SI ("g"))
                    ] \
("/usr/kernel/linux-2.4.12ac1/include/asm/uaccess.h") 558))
            (clobber (reg:QI 19 dirflag))
            (clobber (reg:QI 18 fpsr))
            (clobber (reg:QI 17 flags))
        ] ) -1 (insn_list 598 (insn_list 605 (nil)))
    (nil))
8139too.c:2419: Internal compiler error in \
reload_cse_simplify_operands, at reload1.c:8355

-- 
| G r e g  L o u i s          | gpg public key:      |
|   http://www.bgl.nu/~glouis |   finger greg@bgl.nu |
