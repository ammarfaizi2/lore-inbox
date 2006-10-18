Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945899AbWJRWhT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945899AbWJRWhT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 18:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945900AbWJRWhS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 18:37:18 -0400
Received: from [195.171.73.133] ([195.171.73.133]:62110 "EHLO
	pelagius.h-e-r-e-s-y.com") by vger.kernel.org with ESMTP
	id S1945899AbWJRWhR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 18:37:17 -0400
Date: Wed, 18 Oct 2006 22:37:13 +0000
From: andrew@walrond.org
To: linux-kernel@vger.kernel.org
Cc: dwmw2@infradead.org
Subject: make headers_install headers problem on sparc64
Message-ID: <20061018223713.GD9350@pelagius.h-e-r-e-s-y.com>
Mail-Followup-To: linux-kernel@vger.kernel.org, dwmw2@infradead.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi david, lkml.

I found a message where you said

"If you have problems with the exported headers (other
than that some userspace abuses headers which it shouldn't), then
_shout_. Please don't just let them go unreported."

So,

Using headers exported from vanilla linux 2.6.18.1 and compiling the
elftoaout part of the debian sparc-utils package, I get some breakage
here:

In file included from /usr/include/asm/elf.h:5,
                 from /usr/include/linux/elf.h:7,
                 from elftoaout.c:24:

due to tlb_type, cheetah et al being undefined in this part of
asm-sparc64/elf.h:


bash-3.1# tail -n30 /pkg/linux/include/asm-sparc64/elf.h

/* This yields a mask that user programs can use to figure out what
   instruction set this cpu supports.  */

/* On Ultra, we support all of the v8 capabilities. */
static __inline__ unsigned int sparc64_elf_hwcap(void)
{
        unsigned int cap = (HWCAP_SPARC_FLUSH | HWCAP_SPARC_STBAR |
                            HWCAP_SPARC_SWAP | HWCAP_SPARC_MULDIV |
                            HWCAP_SPARC_V9);

        if (tlb_type == cheetah || tlb_type == cheetah_plus)
                cap |= HWCAP_SPARC_ULTRA3;
        else if (tlb_type == hypervisor)
                cap |= HWCAP_SPARC_BLKINIT;

        return cap;
}

#define ELF_HWCAP       sparc64_elf_hwcap();

/* This yields a string that ld.so will use to load implementation
   specific libraries for optimization.  This is more specific in
   intent than poking at uname or /proc/cpuinfo.  */

#define ELF_PLATFORM    (NULL)


#endif /* !(__ASM_SPARC64_ELF_H) */



Hope this is useful

Andrew Walrond
