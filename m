Return-Path: <linux-kernel-owner@vger.kernel.org>
thread-index: AcQVpCCMrx8WLUWMRnqDTDVy+G3RoQ==
Envelope-to: paul@sumlocktest.fsnet.co.uk
Delivery-date: Sat, 03 Jan 2004 15:19:13 +0000
Message-ID: <00f301c415a4$208c9340$d100000a@sbs2003.local>
Content-Transfer-Encoding: 7bit
Date: Mon, 29 Mar 2004 16:40:13 +0100
X-Mailer: Microsoft CDO for Exchange 2000
From: "Pavel Machek" <pavel@ucw.cz>
To: <Administrator@mangalore.zipworld.com.au>
Cc: <linux-kernel@vger.kernel.org>,
        "Rusty trivial patch monkey Russell" <trivial@rustcorp.com.au>,
        "Andrew Morton" <akpm@zip.com.au>
Subject: Re: 2.5isms
Content-Class: urn:content-classes:message
Importance: normal
References: <20030703200134.GA18459@andromeda> <20031230213050.GA3301@andromeda>
Priority: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20031230213050.GA3301@andromeda>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: <linux-kernel-owner@vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 29 Mar 2004 15:40:14.0671 (UTC) FILETIME=[210FA5F0:01C415A4]

Hi!

> It seems I've found another 2.5ism.  2.6.0, arch/i386/kernel/dmi_scan.c
> has
> 
> #ifdef CONFIG_SIMNOW
>         /*
>          *      Skip on x86/64 with simnow. Will eventually go away
>          *      If you see this ifdef in 2.6pre mail me !
>          */
>         return -1;
> #endif
> 
> I don't know whose file this is ..
> 
> Also, 2.6.0 still has the previously mentioned problem in
> include/asm/io.h.
> 
> Not subscribed, CC me.

This is obsolete x86-64 code... Please apply,
								Pavel

--- tmp/linux/arch/i386/kernel/dmi_scan.c	2004-01-03 16:12:43.000000000 +0100
+++ linux/arch/i386/kernel/dmi_scan.c	2004-01-03 16:12:17.000000000 +0100
@@ -108,15 +108,7 @@
 	u8 buf[15];
 	u32 fp=0xF0000;
 
-#ifdef CONFIG_SIMNOW
-	/*
- 	 *	Skip on x86/64 with simnow. Will eventually go away
- 	 *	If you see this ifdef in 2.6pre mail me !
- 	 */
-	return -1;
-#endif
- 	
-	while( fp < 0xFFFFF)
+	while (fp < 0xFFFFF)
 	{
 		isa_memcpy_fromio(buf, fp, 15);
 		if(memcmp(buf, "_DMI_", 5)==0 && dmi_checksum(buf))


-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
