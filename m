Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263593AbUDSG62 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 02:58:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263606AbUDSG62
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 02:58:28 -0400
Received: from smtp011.mail.yahoo.com ([216.136.173.31]:5502 "HELO
	smtp011.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263593AbUDSG6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 02:58:25 -0400
Message-ID: <4083788E.30601@yahoo.com.au>
Date: Mon, 19 Apr 2004 16:58:22 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc1-mm1
References: <20040418230131.285aa8ae.akpm@osdl.org> <20040419062914.GE743@holomorphy.com>
In-Reply-To: <20040419062914.GE743@holomorphy.com>
Content-Type: multipart/mixed;
 boundary="------------010208030804080900020004"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010208030804080900020004
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

William Lee Irwin III wrote:
> On Sun, Apr 18, 2004 at 11:01:31PM -0700, Andrew Morton wrote:
> 
>>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.6-rc1/2.6.6-rc1-mm1/
>>- All of the anonmm rmap work is now merged up.  No pte chains.
>>- Various cleanups and fixups, as usual.
>>- The list of external bk trees is getting a little short, due to problems
>>  at bkbits.net.  The ones which are here are not necessarily very up-to-date
>>  with the various development trees.
> 
> 
> Okay, the cpumask_arith.h fixes aren't in here. What do I have to do to
> get the bare minimal correctness fixes in this area propagated to mainline?
> 

Speaking of which, the CPU_MASK_ALL, CPU_MASK_NONE fix for
cpumask_array.h still isn't there either.

It seems that in all the excitement a fix wasn't applied.
Here is Linus' version, which is obviously the best one.

--------------010208030804080900020004
Content-Type: text/x-patch;
 name="fix-big-cpumask.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-big-cpumask.patch"

 linux-2.6-npiggin/include/asm-generic/cpumask_array.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN include/asm-generic/cpumask.h~fix-big-cpumask include/asm-generic/cpumask.h
diff -puN include/asm-generic/cpumask_array.h~fix-big-cpumask include/asm-generic/cpumask_array.h
--- linux-2.6/include/asm-generic/cpumask_array.h~fix-big-cpumask	2004-04-19 16:51:55.000000000 +1000
+++ linux-2.6-npiggin/include/asm-generic/cpumask_array.h	2004-04-19 16:53:15.000000000 +1000
@@ -48,7 +48,7 @@
 /*
  * um, these need to be usable as static initializers
  */
-#define CPU_MASK_ALL	{ {[0 ... CPU_ARRAY_SIZE-1] = ~0UL} }
-#define CPU_MASK_NONE	{ {[0 ... CPU_ARRAY_SIZE-1] =  0UL} }
+#define CPU_MASK_ALL	((cpumask_t) { {[0 ... CPU_ARRAY_SIZE-1] = ~0UL} })
+#define CPU_MASK_NONE	((cpumask_t) { {[0 ... CPU_ARRAY_SIZE-1] =  0UL} })
 
 #endif /* __ASM_GENERIC_CPUMASK_ARRAY_H */

_

--------------010208030804080900020004--
