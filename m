Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964886AbWGPEEr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964886AbWGPEEr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 00:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964887AbWGPEEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 00:04:47 -0400
Received: from liaag1ag.mx.compuserve.com ([149.174.40.33]:48574 "EHLO
	liaag1ag.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S964886AbWGPEEq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 00:04:46 -0400
Date: Sat, 15 Jul 2006 23:58:10 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH] x86: Don't randomize stack unless
  current->personality permits it
To: Al Boldi <a1426z@gawab.com>
Cc: Frank van Maarseveen <frankvm@frankvm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>, Andi Kleen <ak@suse.de>
Message-ID: <200607160000_MC3-1-C51D-6B44@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <200607151709.45870.a1426z@gawab.com>

On Sat, 15 Jul 2006 17:09:45 +0300, Al Boldi wrote:

> Randomization on.  Executable runs with 8x blips/hits.
> Randomization off.  Executable runs without blips/hits.
> With randomization off, a mere rename causes an 8x-slowdown to occur.  Run 
> this renamed executable through sh -c ./tstExec, and the slowdown 
> disappears.  Really weired :)

Does this help at all?  I don't have a space heater^W^WPentium IV
to test on.

--- 2.6.18-rc1-nb.orig/arch/i386/kernel/process.c
+++ 2.6.18-rc1-nb/arch/i386/kernel/process.c
@@ -890,5 +890,5 @@ unsigned long arch_align_stack(unsigned 
 {
 	if (randomize_va_space)
 		sp -= get_random_int() % 8192;
-	return sp & ~0xf;
+	return sp & ~0x7f;
 }
-- 
Chuck
 "You can't read a newspaper if you can't read."  --George W. Bush
