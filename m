Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266116AbUFJFbu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266116AbUFJFbu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 01:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266115AbUFJFbt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 01:31:49 -0400
Received: from holomorphy.com ([207.189.100.168]:11145 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266116AbUFJFbj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 01:31:39 -0400
Date: Wed, 9 Jun 2004 22:31:34 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Clemens Schwaighofer <cs@tequila.co.jp>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc3-mm1
Message-ID: <20040610053134.GV1444@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Clemens Schwaighofer <cs@tequila.co.jp>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040609015001.31d249ca.akpm@osdl.org> <40C7EE96.4020206@tequila.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40C7EE96.4020206@tequila.co.jp>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2004 at 02:16:06PM +0900, Clemens Schwaighofer wrote:
> compile error in:
> drivers/perfctr/x86.c: In function `finalise_backpatching':
> drivers/perfctr/x86.c:1137: error: parse error before '{' token
> make[2]: *** [drivers/perfctr/x86.o] Error 1
> make[1]: *** [drivers/perfctr] Error 2
> make: *** [drivers] Error 2
> the kernel compiled fine with 2.6.7-rc2-mm2.
> config attached.

You will likely need other fixes, but...


Index: mm1-2.6.7-rc3/include/linux/cpumask.h
===================================================================
--- mm1-2.6.7-rc3.orig/include/linux/cpumask.h	2004-06-09 08:06:54.000000000 -0700
+++ mm1-2.6.7-rc3/include/linux/cpumask.h	2004-06-09 22:30:18.000000000 -0700
@@ -248,9 +248,9 @@
 #endif
 
 #define CPU_MASK_NONE							\
-{ {									\
+((cpumask_t) { {							\
 	[0 ... BITS_TO_LONGS(NR_CPUS)-1] =  0UL				\
-} }
+} })
 
 #define cpus_addr(src) ((src).bits)
 
