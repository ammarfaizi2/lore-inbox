Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262191AbVGGAXD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262191AbVGGAXD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 20:23:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262413AbVGFUFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 16:05:15 -0400
Received: from alog0294.analogic.com ([208.224.222.70]:23773 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262416AbVGFSKN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 14:10:13 -0400
Date: Wed, 6 Jul 2005 14:08:56 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Alexey Dobriyan <adobriyan@gmail.com>
cc: Rob Prowel <tempest766@yahoo.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: please remove reserved word "new" from kernel headers
In-Reply-To: <200507061706.29843.adobriyan@gmail.com>
Message-ID: <Pine.LNX.4.61.0507061407030.5558@chaos.analogic.com>
References: <20050706092657.95280.qmail@web60012.mail.yahoo.com>
 <200507061706.29843.adobriyan@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jul 2005, Alexey Dobriyan wrote:

> On Wednesday 06 July 2005 13:26, Rob Prowel wrote:
>> When kernel headers are included in compilation of c++
>> programs the compile fails because some header files
>> use "new" in a way that is illegal for c++.  This
>> shows up when compiling mySQL under linux 2.6.  It
>> uses $KERNELSOURCE/include/asm-i386/system.h.
>
> Please read http://marc.theaimsgroup.com/?t=111637777000001&r=2&w=2
> where people discuss this brokeness of MySQL.
>

Just for kicks, see if this 'fixes' it. Then contact the MySQL
people and complain.


--- /usr/src/linux-2.6.12/include/asm-i386/system.h.orig	2005-07-06 14:01:25.000000000 -0400
+++ /usr/src/linux-2.6.12/include/asm-i386/system.h	2005-07-06 14:03:42.000000000 -0400
@@ -235,7 +235,7 @@

  /*
   * Atomic compare and exchange.  Compare OLD with MEM, if identical,
- * store NEW in MEM.  Return the initial value in MEM.  Success is
+ * store New in MEM.  Return the initial value in MEM.  Success is
   * indicated by comparing RETURN with OLD.
   */

@@ -244,26 +244,26 @@
  #endif

  static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
-				      unsigned long new, int size)
+				      unsigned long New, int size)
  {
  	unsigned long prev;
  	switch (size) {
  	case 1:
  		__asm__ __volatile__(LOCK_PREFIX "cmpxchgb %b1,%2"
  				     : "=a"(prev)
-				     : "q"(new), "m"(*__xg(ptr)), "0"(old)
+				     : "q"(New), "m"(*__xg(ptr)), "0"(old)
  				     : "memory");
  		return prev;
  	case 2:
  		__asm__ __volatile__(LOCK_PREFIX "cmpxchgw %w1,%2"
  				     : "=a"(prev)
-				     : "q"(new), "m"(*__xg(ptr)), "0"(old)
+				     : "q"(New), "m"(*__xg(ptr)), "0"(old)
  				     : "memory");
  		return prev;
  	case 4:
  		__asm__ __volatile__(LOCK_PREFIX "cmpxchgl %1,%2"
  				     : "=a"(prev)
-				     : "q"(new), "m"(*__xg(ptr)), "0"(old)
+				     : "q"(New), "m"(*__xg(ptr)), "0"(old)
  				     : "memory");
  		return prev;
  	}




Cheers,
Dick Johnson
Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
