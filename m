Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283438AbRLRB1v>; Mon, 17 Dec 2001 20:27:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283489AbRLRB1m>; Mon, 17 Dec 2001 20:27:42 -0500
Received: from codepoet.org ([166.70.14.212]:3594 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S283438AbRLRB1Y>;
	Mon, 17 Dec 2001 20:27:24 -0500
Date: Mon, 17 Dec 2001 18:27:25 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Linux 2.4.17-rc1
Message-ID: <20011217182724.A17312@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	lkml <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <Pine.LNX.4.21.0112131841080.28446-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0112131841080.28446-100000@freak.distro.conectiva>
User-Agent: Mutt/1.3.23i
X-Operating-System: 2.4.13-ac8-rmk1, Rebel NetWinder (Intel StrongARM-110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Dec 13, 2001 at 06:44:16PM -0200, Marcelo Tosatti wrote:
> 
> Hi, 
> 
> I've just copied 2.4.17-rc1 to ftp.kernel.org... Its mirroring yet,
> probably.
> 
> Well, I want people with the "unfreeable" buffer/cache problem to confirm
> with me that 2.4.17-rc1 is working ok.
> 
> The same change which should fix that problem also should make 2.4 a bit
> less "swap happy".
> 
[---------snip-----------]
> 
> pre6:
> 
[---------snip-----------]
> - Fix lots of core NCR5380 bugs			(Alan Cox)

This fix from -pre6 broke NCR5380 so that it does not compile
when linked into the kernel (i.e.  not as a module).  This patch
fixes it.  Please apply for 2.4.17-rc2, 

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--


--- drivers/scsi.orig/g_NCR5380.c	Mon Dec 17 18:08:08 2001
+++ drivers/scsi/g_NCR5380.c	Mon Dec 17 18:22:34 2001
@@ -911,41 +911,7 @@
 MODULE_DEVICE_TABLE(isapnp, id_table);
 
 
-#ifndef MODULE
-
-static int __init do_NCR53C400_setup(char *str)
-{
-	int ints[10];
-
-	get_options(str, sizeof(ints) / sizeof(int), ints);
-	generic_NCR53C400_setup(str, ints);
-
-	return 1;
-}
-
-static int __init do_NCR53C400A_setup(char *str)
-{
-	int ints[10];
-
-	get_options(str, sizeof(ints) / sizeof(int), ints);
-	generic_NCR53C400A_setup(str, ints);
-
-	return 1;
-}
-
-static int __init do_DTC3181E_setup(char *str)
-{
-	int ints[10];
-
-	get_options(str, sizeof(ints) / sizeof(int), ints);
-	generic_DTC3181E_setup(str, ints);
-
-	return 1;
-}
-
 __setup("ncr5380=", do_NCR5380_setup);
 __setup("ncr53c400=", do_NCR53C400_setup);
 __setup("ncr53c400a=", do_NCR53C400A_setup);
 __setup("dtc3181e=", do_DTC3181E_setup);
-
-#endif
