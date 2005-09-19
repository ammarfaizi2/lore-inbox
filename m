Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932619AbVISTzO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932619AbVISTzO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 15:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932611AbVISTzO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 15:55:14 -0400
Received: from ns1.coraid.com ([65.14.39.133]:52970 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S932619AbVISTzM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 15:55:12 -0400
To: trivial@rustcorp.com.au
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>,
       Roland Dreier <rolandd@cisco.com>
Subject: [patch 2.6.13] document alignment and byteorder macros
From: Ed L Cashin <ecashin@coraid.com>
Date: Mon, 19 Sep 2005 15:22:01 -0400
Message-ID: <87ll1suali.fsf@coraid.com>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

"David S. Miller" <davem@davemloft.net> writes:

> From: Ed L Cashin <ecashin@coraid.com>
> Date: Mon, 19 Sep 2005 10:24:00 -0400
>
>>   1) Passing le64_to_cpup an unaligned pointer is "OK" and within the
>>      intended use of the function.  I'm having trouble finding whether
>>      this is documented somewhere.
>> 
>>   2) These new changes to the sparc64 unaligned access fault handling
>>      will make it OK to leave the aoe driver the way it is in the
>>      mainline kernel.
>
> Both #1 and #2 are true.
>
> Although it's very much discouraged to dereference unaligned pointers,
> especially in performance critical code (which this AOE case is not,
> thankfully), because performance will be really bad as the trap
> handler has to fix up the access on RISC platforms.

Roland Dreier <rolandd@cisco.com> writes:

>     David> Although it's very much discouraged to dereference
>     David> unaligned pointers, especially in performance critical code
>     David> (which this AOE case is not, thankfully), because
>     David> performance will be really bad as the trap handler has to
>     David> fix up the access on RISC platforms. 
>
> Also, ia64 has a tendency to print an ugly message in the kernel log
> for unaligned accesses.  Has anyone tried AoE on ia64?
>
> It might be better to change the AoE code to use get_unaligned(), just
> to document what's going on.  Although clearly the sparc64 patch is
> correct as well -- we should never silently return the wrong data.

This patch comments the fact that although passing le64_to_cpup et
al. is within the intended use of the byteorder macros, using
get_unaligned is the recommended way to go.

Please speak up if there's a better place for this documentation to go
or a better way to say it.


document alignment and byteorder macros

Signed-off-by: Ed L. Cashin <ecashin@coraid.com>


--=-=-=
Content-Disposition: inline; filename=diff

Index: linux-2.6.13/include/linux/byteorder/generic.h
===================================================================
--- linux-2.6.13.orig/include/linux/byteorder/generic.h	2005-08-31 17:00:15.000000000 -0400
+++ linux-2.6.13/include/linux/byteorder/generic.h	2005-09-19 15:15:37.000000000 -0400
@@ -5,6 +5,10 @@
  * linux/byteorder_generic.h
  * Generic Byte-reordering support
  *
+ * The "... p" macros, like le64_to_cpup, can be used with pointers
+ * to unaligned data, but there will be a performance penalty on 
+ * some architectures.  Use get_unaligned for unaligned data.
+ *
  * Francois-Rene Rideau <fare@tunes.org> 19970707
  *    gathered all the good ideas from all asm-foo/byteorder.h into one file,
  *    cleaned them up.

--=-=-=



-- 
  Ed L Cashin <ecashin@coraid.com>

--=-=-=--

