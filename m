Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318169AbSGWTMm>; Tue, 23 Jul 2002 15:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318176AbSGWTMm>; Tue, 23 Jul 2002 15:12:42 -0400
Received: from air-2.osdl.org ([65.172.181.6]:2944 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S318169AbSGWTMm>;
	Tue, 23 Jul 2002 15:12:42 -0400
Date: Tue, 23 Jul 2002 12:14:08 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: Dave Jones <davej@suse.de>
cc: Markus Pfeiffer <profmakx@profmakx.org>, <linux-kernel@vger.kernel.org>
Subject: Re: CPU detection broken in 2.5.27?
In-Reply-To: <20020721184151.A17463@suse.de>
Message-ID: <Pine.LNX.4.44.0207231211380.954-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 21 Jul 2002, Dave Jones wrote:

> On Sun, Jul 21, 2002 at 06:07:26PM +0200, Markus Pfeiffer wrote:
> 
>  > I just noticed that my /proc/cpuinfo states wrong or incomplete 
>  > information about my processor. My PIII-1000M Processor is reported as 
>  > 00/0B (Stepping?)
> 
> Yep, I told Patrick about this last week sometime. The problem is
> that only later Intels (from P4 onwards iirc) have the
> name string cpuid function. Without which we need a table to
> do the family/model/stepping translation to name strings.
> 
> It's not that much work (and most of it already exists in the
> kernels before the per-cpu split up).

Sorry about the delay in fixing this. The fix is really simple - just 
re-add the ID tables for PIIIs. I also added one for P4s, since mine 
wasn't getting automatically named. Though, I don't know what the code 
name for the model is, so it just shows up as "Pentium 4 (Unknown)"...

	-pat

===== arch/i386/kernel/cpu/intel.c 1.3 vs edited =====
--- 1.3/arch/i386/kernel/cpu/intel.c	Wed Jul 10 03:46:31 2002
+++ edited/arch/i386/kernel/cpu/intel.c	Tue Jul 23 12:04:48 2002
@@ -350,6 +350,24 @@
 			  [8] "Mobile Pentium MMX"
 		  }
 		},
+		{ X86_VENDOR_INTEL,     6,
+		  { 
+			  [0] "Pentium Pro A-step",
+			  [1] "Pentium Pro", 
+			  [3] "Pentium II (Klamath)", 
+			  [5] "Pentium II (Deschutes)", 
+			  [6] "Mobile Pentium II",
+			  [7] "Pentium III (Katmai)", 
+			  [8] "Pentium III (Coppermine)", 
+			  [10] "Pentium III (Cascades)",
+			  [11] "Pentium III (Tualatin)",
+		  }
+		},
+		{ X86_VENDOR_INTEL,     15,
+		  { 
+			  [1] "Pentium 4 (Unknown)",
+		  }
+		},
 	},
 	c_init:		init_intel,
 	c_identify:	generic_identify,

