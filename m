Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129053AbRBGRg0>; Wed, 7 Feb 2001 12:36:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129729AbRBGRgQ>; Wed, 7 Feb 2001 12:36:16 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:7349 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S129053AbRBGRgE>;
	Wed, 7 Feb 2001 12:36:04 -0500
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14977.34686.377279.606313@harpo.it.uu.se>
Date: Wed, 7 Feb 2001 18:35:58 +0100
To: "H. Peter Anvin" <hpa@transmeta.com>
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>, mingo@redhat.com,
        linux-kernel@vger.kernel.org, mikpe@csd.uu.se
Subject: Re: UP APIC reenabling vs. cpu type detection ordering
In-Reply-To: <3A817F68.1A5C4EC1@transmeta.com>
In-Reply-To: <20010207135824.A24476@vana.vc.cvut.cz>
	<3A817F68.1A5C4EC1@transmeta.com>
X-Mailer: VM 6.76 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin writes:
 > >         if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL) {
 > >                 printk("No APIC support for non-Intel processors.\n");
 > >                 return -1;
 > >         }
 > 
 > Why is the test there in the first place?  If the machine has an APIC, it
 > should be able to use it.  Presumably no other CPU uses the same MSR
 > address (am I wrong?) for anything else -- if so, it should be able to
 > poke it as long as the kernel intercepts the #GP(0) that may come if it
 > is not enabled.  The Linux kernel has pretty sophisticated support for
 > trapping faults.

The reason is that AMD so far has put relevant documentation about (a) what
the local APIC itself looks like, and (b) how to enable it, under NDA.

Having "apic" in your feature bits doesn't imply that the APIC_BASE MSR
is supported, or is at the same MSR index, or hasn't changed subtly.
So the test there is saying "unless we KNOW how to do it, don't try".

(Now thanks to tests done by Petr and others, it does appear that the
K7 local APIC is pretty much compatible with the P6 one. But we didn't
know this until very recently.)

 > In other words, I'd like to see a reason for making any vendor-specific
 > determinations, and if so, they should ideally be centralized to the CPU
 > feature-determination code.

The Pentium 4 has a local APIC. It's not 100% compatible with the P6, and
you sometimes have to know which one you're poking. CPUID returns the
APIC feature bit. Should we mask its APIC capability? Of course not.

/Mikael
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
