Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313577AbSDJTLL>; Wed, 10 Apr 2002 15:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313570AbSDJTLJ>; Wed, 10 Apr 2002 15:11:09 -0400
Received: from rtlab.med.cornell.edu ([140.251.145.175]:27310 "HELO
	openlab.rtlab.org") by vger.kernel.org with SMTP id <S313553AbSDJTKw>;
	Wed, 10 Apr 2002 15:10:52 -0400
Date: Wed, 10 Apr 2002 15:10:52 -0400 (EDT)
From: "Calin A. Culianu" <calin@ajvar.org>
X-X-Sender: <calin@rtlab.med.cornell.edu>
To: <linux-kernel@vger.kernel.org>
Subject: Cannot compile mandrake 8.2 Kernel
Message-ID: <Pine.LNX.4.33L2.0204101505220.5649-100000@rtlab.med.cornell.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The stupid mandrake 8.2 kernel (2.4.18-mdk6) won't compile.  I know,
mandrake is kind of a newbie distro, but I needed to mess with that kernel
for some reason (don't ask).

Anyway it gets errors like the following then you do make modules.  I
notices someone else also had the exact same problem.. also below is
preprocessor output from that compile... I think the problem is due to
some of the exported kernel symbols containing parens...:


gcc -D__KERNEL__ -I/usr/src/linux-2.4.18-6mdk-rtl/include  -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-common -fomit-frame-pointer
-pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS
-include /usr/src/linux-2.4.18-6mdk-rtl/include/linux/modversions.h
-DKBUILD_BASENAME=loop  -DEXPORT_SYMTAB -c loop.c
In file included from
/usr/src/linux-2.4.18-6mdk-rtl/include/linux/prefetch.h:13,
                 from
/usr/src/linux-2.4.18-6mdk-rtl/include/linux/list.h:6,
                 from
/usr/src/linux-2.4.18-6mdk-rtl/include/linux/module.h:12,
from loop.c:64:
/usr/src/linux-2.4.18-6mdk-rtl/include/asm/processor.h:51: warning:
parameter names (without types) in function declaration
/usr/src/linux-2.4.18-6mdk-rtl/include/asm/processor.h:51: field
`loops_per_jiffy_R_ver_str' declared as a function
In file included from loop.c:64:
/usr/src/linux-2.4.18-6mdk-rtl/include/linux/module.h:183: nondigits in
number and not hexadecimal
/usr/src/linux-2.4.18-6mdk-rtl/include/linux/module.h:183: nondigits in
number and not hexadecimal
/usr/src/linux-2.4.18-6mdk-rtl/include/linux/module.h:183: nondigits in
number and not hexadecimal
/usr/src/linux-2.4.18-6mdk-rtl/include/linux/module.h:183: nondigits in
number and not hexadecimal
/usr/src/linux-2.4.18-6mdk-rtl/include/linux/module.h:183: parse error
before `62dada05'
/usr/src/linux-2.4.18-6mdk-rtl/include/linux/module.h:183:
`inter_module_register_R_ver_str' declared as function returning a
function
/usr/src/linux-2.4.18-6mdk-rtl/include/linux/module.h:183: warning:
function declaration isn't a prototype
/usr/src/linux-2.4.18-6mdk-rtl/include/linux/module.h:184: nondigits in
number and not hexadecimal
/usr/src/linux-2.4.18-6mdk-rtl/include/linux/module.h:184: missing white
space after number `7a9e845'
/usr/src/linux-2.4.18-6mdk-rtl/include/linux/module.h:184: parse error
before `7a9e845'
/usr/src/linux-2.4.18-6mdk-rtl/include/linux/module.h:184:
`inter_module_unregister_R_ver_str' declared as function returning a
function
/usr/src/linux-2.4.18-6mdk-rtl/include/linux/module.h:184: warning:
function declaration isn't a prototype
/usr/src/linux-2.4.18-6mdk-rtl/include/linux/module.h:185:
`inter_module_get_R_ver_str' declared as function returning a function


Here is the cpp output.. this is an except of the first thing the above
barfed on:


# 33 "/usr/src/linux-2.4.18-6mdk-rtl/include/asm/processor.h"
struct cpuinfo_x86 {
        __u8 x86;
        __u8 x86_vendor;
        __u8 x86_model;
        __u8 x86_mask;
        char wp_works_ok;
        char hlt_works_ok;
        char hard_math;
        char rfu;
    int cpuid_level;
        __u32 x86_capability[4];
        char x86_vendor_id[16];
        char x86_model_id[64];
        int x86_cache_size;

        int fdiv_bug;
        int f00f_bug;
        int coma_bug;
        unsigned long loops_per_jiffy_R_ver_str(ba497f13);
        unsigned long *pgd_quick;
        unsigned long *pmd_quick;
        unsigned long *pte_quick;
        unsigned long pgtable_cache_sz;
} __attribute__((__aligned__((1 << ((5))))));

I think the problem is that unsigned long
loops_per_jiffy_R_ver_str(ba497f13); struct member .. I dunno why
loops_per_jiffy got renamed to that mangled kernel symbol name.. but I
suspect it has to do with buggy header files. (I noticed loops_per_jiffy
was #defined to something else).


At any rate.. has anyone else encountered this problem with that mandrake
kernel?  If so how did you fix this?


-Calin



