Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261198AbUKWMy3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbUKWMy3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 07:54:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261218AbUKWMy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 07:54:29 -0500
Received: from eagle.ericsson.se ([193.180.251.53]:20374 "EHLO
	eagle.ericsson.se") by vger.kernel.org with ESMTP id S261208AbUKWMyX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 07:54:23 -0500
Message-ID: <D6A41B94D27EA643BAE9319F5348603F17D6B3@ESEALNT895.al.sw.ericsson.se>
From: "Joakim Bentholm XQ (AS/EAB)" <joakim.xq.bentholm@ericsson.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: PROBLEM: Compatibility problem with C++, i386 & ia64 platform
Date: Tue, 23 Nov 2004 13:54:12 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="ISO-8859-1"
X-OriginalArrivalTime: 23 Nov 2004 12:54:21.0526 (UTC) FILETIME=[8D407F60:01C4D15B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. Compatibility errors when including <asm/system.h> with g++ compiler on i386 and ia64 platforms.


If you want to use the memory barrier macros mb(), rmb() and wmb(), as defined in <asm/system.h>.

On i386 platform:
This will work if you use gcc, but not in g++, since the name of the parameter in the __cmpxchg(...) is new, which the C++ compiler will not accept. (new_val might have been a better choice ;-)

Function header
---
static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
				      unsigned long new, int size)
---


On Itanium 2 platform:
Compiling on Itanium 2 works if you add som typedefs and a define, which is normally defined when __KERNEL__ is enabled. 

Prepended rows to the include of system.h
---
#define __pa(x) x
typedef long s64;
typedef int s32;
typedef unsigned long u64;
typedef unsigned int u32;
#include <asm/system.h>
---


Maybe the system.h is not supposed to be included outside the kernel?
Is there a less crude way of getting hold of the macros?

Best Regards/JB

--
Joakim Bentholm
joakim.xq.bentholm@ericsson.com
