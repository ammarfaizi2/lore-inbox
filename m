Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318256AbSGWUdg>; Tue, 23 Jul 2002 16:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318250AbSGWUdg>; Tue, 23 Jul 2002 16:33:36 -0400
Received: from air-2.osdl.org ([65.172.181.6]:32128 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S318256AbSGWUdG>;
	Tue, 23 Jul 2002 16:33:06 -0400
Date: Tue, 23 Jul 2002 13:34:37 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: Dave Jones <davej@suse.de>
cc: Markus Pfeiffer <profmakx@profmakx.org>, <linux-kernel@vger.kernel.org>
Subject: Re: CPU detection broken in 2.5.27?
In-Reply-To: <20020723223456.C16446@suse.de>
Message-ID: <Pine.LNX.4.44.0207231333330.954-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Which stepping do you have ?

2.

>  > Updated patch appended. This updated version hasn't been tested, as I
>  > don't have any of those processors at my disposal...
> 
> -ENOAPPENDAGE.

Sorry, it was in the invisible charset. 

	-pat

===== arch/i386/kernel/cpu/intel.c 1.3 vs edited =====
--- 1.3/arch/i386/kernel/cpu/intel.c	Wed Jul 10 03:46:31 2002
+++ edited/arch/i386/kernel/cpu/intel.c	Tue Jul 23 13:25:01 2002
@@ -232,15 +232,19 @@
 	if (c->x86 == 6) {
 		switch (c->x86_model) {
 		case 5:
-			if (l2 == 0)
-				p = "Celeron (Covington)";
-			if (l2 == 256)
-				p = "Mobile Pentium II (Dixon)";
+			if (c->x86_mask == 0) {
+				if (l2 == 0)
+					p = "Celeron (Covington)";
+				else if (l2 == 256)
+					p = "Mobile Pentium II (Dixon)";
+			}
 			break;
 			
 		case 6:
 			if (l2 == 128)
 				p = "Celeron (Mendocino)";
+			else if (c->x86_mask == 0 || c->x86_mask == 5)
+				p = "Celeron-A";
 			break;
 			
 		case 8:
@@ -348,6 +352,26 @@
 			  [4] "Pentium MMX",
 			  [7] "Mobile Pentium 75 - 200", 
 			  [8] "Mobile Pentium MMX"
+		  }
+		},
+		{ X86_VENDOR_INTEL,     6,
+		  { 
+			  [0] "Pentium Pro A-step",
+			  [1] "Pentium Pro", 
+			  [3] "Pentium II (Klamath)", 
+			  [4] "Pentium II (Deschutes)", 
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
+			  [1] "Pentium 4 (Foster)",
+			  [5] "Pentium 4 (Foster)",
 		  }
 		},
 	},

