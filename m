Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261689AbSKMMzP>; Wed, 13 Nov 2002 07:55:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261859AbSKMMzP>; Wed, 13 Nov 2002 07:55:15 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:54945 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S261689AbSKMMzO>;
	Wed, 13 Nov 2002 07:55:14 -0500
Date: Wed, 13 Nov 2002 13:00:36 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Bill Davidsen <davidsen@tmr.com>
Cc: alan@redhat.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] 2.5.47-ac1 fails linking
Message-ID: <20021113130036.GA5488@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Bill Davidsen <davidsen@tmr.com>, alan@redhat.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0211130726380.16139-101000@oddball.prodigy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211130726380.16139-101000@oddball.prodigy.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2002 at 07:32:04AM -0500, Bill Davidsen wrote:
 > arch/i386/kernel/built-in.o: In function `identify_cpu':
 > arch/i386/kernel/built-in.o(.init.text+0x25f4): undefined reference to `mcheck_init'
 > arch/i386/kernel/built-in.o: In function `gdt_48':
 > arch/i386/kernel/built-in.o(.data+0x15b5): undefined reference to `boot_gdt_table'

Easy one. Alan, there's some detritus left hanging around in
arch/i386/kernel/cpu/common.c 

The hunk at 319 needs to go..

Back out this bit..

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.47/arch/i386/kernel/cpu/common.c linux.2.5.47-ac2/arch/i386/kernel/cpu/common.c
--- linux.2.5.47/arch/i386/kernel/cpu/common.c  2002-11-11 16:39:08.000000000 +0000
+++ linux.2.5.47-ac2/arch/i386/kernel/cpu/common.c  2002-11-05 15:57:59.000000000 +0000
@@ -319,6 +315,9 @@
        clear_bit(X86_FEATURE_XMM, c->x86_capability);
    }
 
+   /* Init Machine Check Exception if available. */
+   mcheck_init(c);
+
    /* If the model name is still unset, do table lookup. */
    if ( !c->x86_model_id[0] ) {
        char *p;


(Hand-pasted, so may not apply)

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
