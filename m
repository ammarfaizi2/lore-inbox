Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263636AbUCYW0p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 17:26:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263676AbUCYW0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 17:26:45 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:48111 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263636AbUCYW0h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 17:26:37 -0500
Date: Thu, 25 Mar 2004 23:26:29 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: -mm: md-merging-fix causes ICE with gcc 2.95
Message-ID: <20040325222628.GB16746@fs.tum.de>
References: <20040323232511.1346842a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040323232511.1346842a.akpm@osdl.org>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2004 at 11:25:11PM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.5-rc2-mm1:
>...
> +md-merging-fix.patch
> 
>  Fix RAID merging problem.
>...

I got the following compile error in 2.6.5-rc2-mm3 using the gcc 2.95 
from Debian unstable on i386:

<--  snip  -->

...
  CC      drivers/md/linear.o
drivers/md/linear.c: In function `linear_mergeable_bvec':
drivers/md/linear.c:84: Internal compiler error:
drivers/md/linear.c:84: internal error--unrecognizable insn:
(insn/i 49 47 210 (parallel[ 
            (set (reg:SI 0 %eax)
                (asm_operands ("") ("=a") 0[ 
                        (reg:DI 1 %edx)
                    ] 
                    [ 
                        (asm_input:DI ("A"))
                    ]  ("drivers/md/linear.c") 41))
            (set (reg:SI 1 %edx)
                (asm_operands ("") ("=d") 1[ 
                        (reg:DI 1 %edx)
                    ] 
                    [ 
                        (asm_input:DI ("A"))
                    ]  ("drivers/md/linear.c") 41))
        ] ) -1 (insn_list 44 (nil))
    (nil))
cpp0: output pipe has been closed
make[2]: *** [drivers/md/linear.o] Error 1

<--  snip  -->


I know that this is on the first hand a compiler bug, but gcc 2.95 is 
although no longer supported by the gcc developers still the recommended 
compiler for the kernel.


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

