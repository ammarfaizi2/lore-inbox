Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266379AbSLDKpY>; Wed, 4 Dec 2002 05:45:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266387AbSLDKpY>; Wed, 4 Dec 2002 05:45:24 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:62113 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S266379AbSLDKpX>;
	Wed, 4 Dec 2002 05:45:23 -0500
Date: Wed, 4 Dec 2002 11:52:46 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Paul <set@pobox.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Rusty Trivial Russell <trivial@rustcorp.com.au>
Subject: Re: [uPATCH] NCR5380.c compile fix Re: Linux v2.5.50
In-Reply-To: <20021128024354.GK1432@squish.home.loc>
Message-ID: <Pine.GSO.4.21.0212041151000.4748-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Nov 2002, Paul wrote:
> Linus Torvalds <torvalds@transmeta.com>, on Wed Nov 27, 2002 [03:07:38 PM] said:
> > 
> > Taking a small thanksgiving break, but before that here's 2.5.50.
> > 
> 
> 	Hi;
> 
> 	Needed this so NCR5380.c would compile. (via pas16)
> 
> Paul
> set@pobox.com
> 
> --- 2.5.50.virgin/drivers/scsi/NCR5380.c	2002-11-12 21:18:00.000000000 -0500
> +++ 2.5.50/drivers/scsi/NCR5380.c	2002-11-27 21:20:26.000000000 -0500
> @@ -1477,8 +1477,8 @@
>  	int len;
>  	unsigned long timeout;
>  	unsigned char value;
> -	NCR5380_setup(instance);
>  	int err;
> +	NCR5380_setup(instance);
>  
>  	if (hostdata->selecting) {
>  		if(instance->irq != IRQ_NONE)

And you need one more to compile the Mac/m68k SCSI driver:

Compile fixes for the NCR5380 core support:
  - All variable declarations must come first in C
  - Fix curly braces

--- linux-2.5.50/drivers/scsi/NCR5380.c	Sun Dec  1 21:45:41 2002
+++ linux-m68k-2.5.x/drivers/scsi/NCR5380.c	Mon Nov 11 20:54:18 2002
@@ -1477,8 +1477,8 @@
 	int len;
 	unsigned long timeout;
 	unsigned char value;
-	int err;
 	NCR5380_setup(instance);
+	int err;
 
 	if (hostdata->selecting) {
 		if(instance->irq != IRQ_NONE)
@@ -2489,9 +2489,8 @@
 						    hostdata->issue_queue;
 						hostdata->issue_queue = (Scsi_Cmnd *) cmd;
 						dprintk(NDEBUG_QUEUES, ("scsi%d : REQUEST SENSE added to head of issue queue\n", instance->host_no));
-					} else
+					} else {
 #endif				/* def AUTOSENSE */
-					{
 						collect_stats(hostdata, cmd);
 						cmd->scsi_done(cmd);
 					}

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

