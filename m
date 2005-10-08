Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750823AbVJHJe5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbVJHJe5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Oct 2005 05:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbVJHJe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Oct 2005 05:34:57 -0400
Received: from liaag2ad.mx.compuserve.com ([149.174.40.155]:51648 "EHLO
	liaag2ad.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1750823AbVJHJe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Oct 2005 05:34:56 -0400
Date: Sat, 8 Oct 2005 05:31:50 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: SMP syncronization on AMD processors (broken?)
To: Kirill Korotaev <dev@sw.ru>
Cc: Andrew Morton <akpm@osdl.org>, Andrey Savochkin <saw@sawoct.com>,
       Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200510080534_MC3-1-AC2C-C212@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <434520FF.8050100@sw.ru>

On Thu, 06 Oct 2005 at 17:05:03 +0400, Kirill Korotaev wrote:

> The question is whether concurrent spin_lock()'s should 
> acquire it in more or less "fair" fashinon or one of CPUs can starve any 
> arbitrary time while others do reacquire it in a loop.

 You neglected to say what CPU type you compiled the kernel for.

 If it wasn't Pentium Pro maybe you could patch include/asm-i386/spinlock.h
line 82 (or the same place in x86-64) like this:

___
  * (PPro errata 66, 92)
  */
 
-#if !defined(CONFIG_X86_OOSTORE) && !defined(CONFIG_X86_PPRO_FENCE)
+#if 0
 
 #define __raw_spin_unlock_string \
         "movb $1,%0" \
___

The data might not make it out of the CPU write buffer without a locking
instruction doing the update.
__
Chuck
