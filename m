Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261742AbTARAnh>; Fri, 17 Jan 2003 19:43:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261854AbTARAnh>; Fri, 17 Jan 2003 19:43:37 -0500
Received: from franka.aracnet.com ([216.99.193.44]:26026 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S261742AbTARAng>; Fri, 17 Jan 2003 19:43:36 -0500
Date: Fri, 17 Jan 2003 16:52:28 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: William Lee Irwin III <wli@holomorphy.com>
cc: akpm@zip.com.au, linux-kernel@vger.kernel.org
Subject: Re: MAX_IO_APICS #ifdef'd wrongly
Message-ID: <332970000.1042851147@titus>
In-Reply-To: <20030117231417.GT919@holomorphy.com>
References: <20030117090031.GD940@holomorphy.com> <224570000.1042818820@titus> <20030117231417.GT919@holomorphy.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I shot for the one liner that fixed the case I could test. Shoving it
> into subarch is cleaner, but needs more code movement and changes the
> prior semantics. The prior semantics were broken for larger Summit
> configurations, hmm. Maybe _all_ the array sizes should go into some
> kind of subarch analogue of param.h, e.g. mach_param.h

That sounds like the right thing to do longer-term ... let's change it 
to the defn below for now, so people's trees work, then have a proper 
think about to organise subarch to make this stuff work easily 
(no doubt there's other gremlins there to be fixed at the same time).

M.

diff -urpN -X /home/fletch/.diff.exclude virgin/include/asm-i386/apicdef.h max_io_apics/include/asm-i386/apicdef.h
--- virgin/include/asm-i386/apicdef.h	Fri Jan 17 09:18:31 2003
+++ max_io_apics/include/asm-i386/apicdef.h	Fri Jan 17 16:49:41 2003
@@ -115,7 +115,7 @@
 
 #define APIC_BASE (fix_to_virt(FIX_APIC_BASE))
 
-#ifdef CONFIG_X86_NUMA
+#ifdef CONFIG_NUMA
  #define MAX_IO_APICS 32
 #else
  #define MAX_IO_APICS 8

