Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316799AbSE1B3b>; Mon, 27 May 2002 21:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316800AbSE1B3a>; Mon, 27 May 2002 21:29:30 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:49165 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S316799AbSE1B31>; Mon, 27 May 2002 21:29:27 -0400
Date: Mon, 27 May 2002 22:29:25 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Lista Linux-Kernel <linux-kernel@vger.kernel.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH][RFC] PentiumPro/II split in x86 config
Message-ID: <20020528012925.GB20729@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"J.A. Magallon" <jamagallon@able.es>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Lista Linux-Kernel <linux-kernel@vger.kernel.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>
In-Reply-To: <20020527145420.GA6738@werewolf.able.es> <1022520676.11859.294.camel@irongate.swansea.linux.org.uk> <20020527215911.GC1848@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, May 27, 2002 at 11:59:11PM +0200, J.A. Magallon escreveu:
> Opps... typo.
> Yes:
> 
>     { X86_VENDOR_INTEL, 6,
>       { "Pentium Pro A-step", "Pentium Pro", NULL, "Pentium II (Klamath)",
>         NULL, "Pentium II (Deschutes)", "Mobile Pentium II",
>         "Pentium III (Katmai)", "Pentium III (Coppermine)", NULL,
>         "Pentium III (Cascades)", NULL, NULL, NULL, NULL }},
> 
> Corrected patch on the way...

Hi,

	Since you're working on this could I suggest that you use labeled
elements, this gccism make the initialization above way more cleaner, safer and
easy to read :-) This is being used in the kernel in places like the FSes, the
TCP/IP stack and lots of other places.

	We don't need all the NULLs, as uninitialized entries will be zeroed
out by the compiler.

	Here is how it would look like:

--- 1.50/arch/i386/kernel/setup.c	Sat Apr 27 14:47:46 2002
+++ edited/arch/i386/kernel/setup.c	Mon May 27 22:03:35 2002
@@ -2245,15 +2245,34 @@
 /* This table only is used unless init_<vendor>() below doesn't set it; */
 /* in particular, if CPUID levels 0x80000002..4 are supported, this isn't used */
 static struct cpu_model_info cpu_models[] __initdata = {
-	{ X86_VENDOR_INTEL,	4,
-	  { "486 DX-25/33", "486 DX-50", "486 SX", "486 DX/2", "486 SL", 
-	    "486 SX/2", NULL, "486 DX/2-WB", "486 DX/4", "486 DX/4-WB", NULL, 
-	    NULL, NULL, NULL, NULL, NULL }},
-	{ X86_VENDOR_INTEL,	5,
-	  { "Pentium 60/66 A-step", "Pentium 60/66", "Pentium 75 - 200",
-	    "OverDrive PODP5V83", "Pentium MMX", NULL, NULL,
-	    "Mobile Pentium 75 - 200", "Mobile Pentium MMX", NULL, NULL, NULL,
-	    NULL, NULL, NULL, NULL }},
+	{
+		vendor:	     X86_VENDOR_INTEL,
+		family:	     4,
+		model_names: {
+				[0] = "486 DX-25/33",
+				[1] = "486 DX-50",
+				[2] = "486 SX",
+				[3] = "486 DX/2",
+				[4] = "486 SL", 
+				[5] = "486 SX/2",
+				[7] = "486 DX/2-WB",
+				[8] = "486 DX/4",
+				[9] = "486 DX/4-WB",
+		},
+	},
+	{
+		vendor:	     X86_VENDOR_INTEL,
+		family:	     5,
+		model_names: {
+				[0] = "Pentium 60/66 A-step",
+				[1] = "Pentium 60/66",
+				[2] = "Pentium 75 - 200",
+				[3] = "OverDrive PODP5V83",
+				[4] = "Pentium MMX",
+				[7] = "Mobile Pentium 75 - 200",
+				[8] = "Mobile Pentium MMX",
+		}
+	},
 	{ X86_VENDOR_INTEL,	6,
 	  { "Pentium Pro A-step", "Pentium Pro", NULL, "Pentium II (Klamath)", 
 	    NULL, "Pentium II (Deschutes)", "Mobile Pentium II",

Best Regards,

- Arnaldo, with the janitor hat on for the time being 8)
