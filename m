Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262748AbSI1In6>; Sat, 28 Sep 2002 04:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262749AbSI1In6>; Sat, 28 Sep 2002 04:43:58 -0400
Received: from packet.digeo.com ([12.110.80.53]:23701 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262748AbSI1In4>;
	Sat, 28 Sep 2002 04:43:56 -0400
Message-ID: <3D956D06.D7370490@digeo.com>
Date: Sat, 28 Sep 2002 01:49:10 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.38 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Shawn Starr <spstarr@sh0n.net>
CC: linux-kernel@vger.kernel.org, Jeff Dike <jdike@karaya.com>
Subject: Re: [PROBLEM] 2.5.39 - might_sleep() exception - ACPI/APIC, UML compile 
 issues on MP 2000+
References: <200209280428.23572.spstarr@sh0n.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Sep 2002 08:49:11.0210 (UTC) FILETIME=[EA1F28A0:01C266CB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shawn Starr wrote:
> 
> ...
> 3) Compile errors with UML:
> 
> In file included from sched.c:19:
> /usr/src/linux-2.5.39/include/linux/mm.h:165: parse error before "pte_addr_t"
> /usr/src/linux-2.5.39/include/linux/mm.h:165: warning: no semicolon at end of struct or union
> /usr/src/linux-2.5.39/include/linux/mm.h:165: warning: no semicolon at end of struct or union
> /usr/src/linux-2.5.39/include/linux/mm.h:166: warning: type defaults to `int' in declaration of `pte'
> 

It's strange that this ever worked.  Does this fix?

--- linux-2.5.39/include/asm-um/pgtable.h	Sun Sep 15 20:53:43 2002
+++ 25/include/asm-um/pgtable.h	Sat Sep 28 01:47:43 2002
@@ -215,6 +215,8 @@ static inline void set_pte(pte_t *pteptr
 	if(pte_present(*pteptr)) *pteptr = pte_mknewprot(*pteptr);
 }
 
+typedef pte_t *pte_addr_t;
+
 /*
  * (pmds are folded into pgds so this doesnt get actually called,
  * but the define is needed for a generic inline function.)
