Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270890AbTGPKaM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 06:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270897AbTGPKaM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 06:30:12 -0400
Received: from fed1mtao02.cox.net ([68.6.19.243]:22503 "EHLO
	fed1mtao02.cox.net") by vger.kernel.org with ESMTP id S270890AbTGPK36
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 06:29:58 -0400
Date: Wed, 16 Jul 2003 03:44:49 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.0-test1-mm1
Message-ID: <20030716104448.GC25869@ip68-4-255-84.oc.oc.cox.net>
References: <20030715225608.0d3bff77.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030715225608.0d3bff77.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 15, 2003 at 10:56:08PM -0700, Andrew Morton wrote:
> +ppc-build-fix.patch
> 
>  Make ppc build

Really? ;)

More seriously, that patch is good and necessary, but I think something
else in -mm is breaking the compile (this is gcc 2.95.3):

  CC      arch/ppc/kernel/irq.o
In file included from include/linux/fs.h:14,
                 from include/linux/mm.h:14,
                 from include/asm/pci.h:8,
                 from include/linux/pci.h:672,
                 from arch/ppc/kernel/irq.c:41:
include/linux/kdev_t.h: In function `to_kdev_t':
include/linux/kdev_t.h:101: warning: right shift count >= width of type
arch/ppc/kernel/irq.c: At top level:  
arch/ppc/kernel/irq.c:575: braced-group within expression allowed only
inside a function
arch/ppc/kernel/irq.c:575: initializer element is not constant
arch/ppc/kernel/irq.c:575: (near initialization for `irq_affinity[0]')
arch/ppc/kernel/irq.c:575: initializer element is not constant
arch/ppc/kernel/irq.c:575: (near initialization for `irq_affinity[1]')
arch/ppc/kernel/irq.c:575: initializer element is not constant
arch/ppc/kernel/irq.c:575: (near initialization for `irq_affinity[2]')
arch/ppc/kernel/irq.c:575: initializer element is not constant
arch/ppc/kernel/irq.c:575: (near initialization for `irq_affinity[3]')
arch/ppc/kernel/irq.c:575: initializer element is not constant
arch/ppc/kernel/irq.c:575: (near initialization for `irq_affinity[4]')

[sniiiiiiiiiiiip the boring, repetitive part of the longest gcc error
output I've seen in the last few years]

arch/ppc/kernel/irq.c:575: initializer element is not constant
arch/ppc/kernel/irq.c:575: (near initialization for `irq_affinity[254]')
arch/ppc/kernel/irq.c:575: initializer element is not constant
arch/ppc/kernel/irq.c:575: (near initialization for `irq_affinity[255]')
arch/ppc/kernel/irq.c:575: parse error before `)'
arch/ppc/kernel/irq.c: In function `prof_cpu_mask_write_proc':
arch/ppc/kernel/irq.c:691: invalid initializer
arch/ppc/kernel/irq.c:694: incompatible types in assignment
arch/ppc/kernel/irq.c:695: invalid operands to binary !=
arch/ppc/kernel/irq.c:696: incompatible types in return
arch/ppc/kernel/irq.c:699: incompatible types in return
arch/ppc/kernel/irq.c:700: warning: control reaches end of non-void
function
make[1]: *** [arch/ppc/kernel/irq.o] Error 1
make: *** [arch/ppc/kernel] Error 2

There were many other "right shift count >= width of type" warnings
earlier in the compile, too. (I can provide more examples of these if
you wish.)

-Barry K. Nathan <barryn@pobox.com>
