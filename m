Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267577AbTACQ16>; Fri, 3 Jan 2003 11:27:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267575AbTACQ16>; Fri, 3 Jan 2003 11:27:58 -0500
Received: from blackbird.intercode.com.au ([203.32.101.10]:21517 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id <S267571AbTACQ1z>; Fri, 3 Jan 2003 11:27:55 -0500
Date: Sat, 4 Jan 2003 03:36:05 +1100 (EST)
From: James Morris <jmorris@intercode.com.au>
To: "BODA Karoly jr." <woockie@expressz.com>
cc: sparclinux@vger.kernel.org, <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.54-sparc64 compile errors
In-Reply-To: <Pine.LNX.3.96.1030103155904.5497A-200000@ligur.expressz.com>
Message-ID: <Mutt.LNX.4.44.0301040331530.18132-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Jan 2003, BODA Karoly jr. wrote:

> arch/sparc64/solaris/built-in.o(.text+0xb4): In function `entry64_personality_patch':
> : undefined reference to `TI_FLAGS'

See the patch below for a fix for this.

> kernel/built-in.o(.data+0x1708): undefined reference to `hugetlb_sysctl_handler'

Looks like the sparc hugetlb code needs updating, you will need to disable 
it until it's done.

> drivers/built-in.o(.text+0x1af90): In function `kd_nosound':

You need to set CONFIG_INPUT=y to fix this at the moment (even if you 
don't have any input devices configured).


- James
-- 
James Morris
<jmorris@intercode.com.au>

diff -urN -X dontdiff linux-2.5.54.orig/arch/sparc64/solaris/entry64.S linux-2.5.54.w2/arch/sparc64/solaris/entry64.S
--- linux-2.5.54.orig/arch/sparc64/solaris/entry64.S	Fri Aug  2 07:16:02 2002
+++ linux-2.5.54.w2/arch/sparc64/solaris/entry64.S	Sat Jan  4 03:22:12 2003
@@ -16,6 +16,7 @@
 #include <asm/signal.h>
 #include <asm/pgtable.h>
 #include <asm/processor.h>
+#include <asm/thread_info.h>
 
 #include "conv.h"
 

