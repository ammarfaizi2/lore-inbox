Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S144874AbRA2Cn0>; Sun, 28 Jan 2001 21:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S144961AbRA2CnR>; Sun, 28 Jan 2001 21:43:17 -0500
Received: from obelix.hrz.tu-chemnitz.de ([134.109.132.55]:58002 "EHLO
	obelix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S144874AbRA2CnE>; Sun, 28 Jan 2001 21:43:04 -0500
Date: Mon, 29 Jan 2001 03:43:00 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Making Cyrix III boot
Message-ID: <20010129034300.I1173@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <Pine.LNX.4.10.10101281020540.3850-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.10.10101281020540.3850-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sun, Jan 28, 2001 at 10:31:52AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Jan 28, 2001 at 10:31:52AM -0800, Linus Torvalds wrote:
> I just uploaded it to kernel.org, and I expect that I'll do the final
> 2.4.1 tomorrow, before leaving for NY and LinuxWorld. Please test that the
> pre-kernel works for you..

The Cyrix III of my employer doesn't boot without this patch.
Reason: There are no MSRs in this range.

Since hpa didn't send a better fix, I attached the band-aid fix
for you, so that people can boot.

Linus, please apply.

Regards

Ingo Oeser

--- linux-2.4.1-pre11/arch/i386/kernel/setup.c.orig	Mon Jan 29 03:35:08 2001
+++ linux-2.4.1-pre11/arch/i386/kernel/setup.c	Mon Jan 29 03:36:41 2001
@@ -1401,10 +1401,11 @@
 					wrmsr (0x1107, lo, hi);
 
 					set_bit(X86_FEATURE_CX8, &c->x86_capability);
+					/* FIXME: This is only band-aid. Will be fixed properly -ioe
 					rdmsr (0x80000001, lo, hi);
 					if (hi & (1<<31))
 						set_bit(X86_FEATURE_3DNOW, &c->x86_capability);
-
+					*/
 					get_model_name(c);
 					display_cacheinfo(c);
 					break;

-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<       come and join the fun       >>>>>>>>>>>>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
