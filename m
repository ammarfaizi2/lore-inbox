Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291793AbSBNRHG>; Thu, 14 Feb 2002 12:07:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291794AbSBNRG5>; Thu, 14 Feb 2002 12:06:57 -0500
Received: from tstac.esa.lanl.gov ([128.165.46.3]:61664 "EHLO
	tstac.esa.lanl.gov") by vger.kernel.org with ESMTP
	id <S291793AbSBNRGn>; Thu, 14 Feb 2002 12:06:43 -0500
Message-Id: <200202141618.JAA04629@tstac.esa.lanl.gov>
Content-Type: text/plain; charset=US-ASCII
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
To: Gerd Knorr <kraxel@strusel007.de>, Steven Cole <elenstev@mesatop.com>
Subject: Re: [PATCH] 2.5.5-pre1 fix build error in drivers/video/vesafb.c
Date: Thu, 14 Feb 2002 10:02:59 -0700
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <200202141501.IAA04461@tstac.esa.lanl.gov> <20020214163705.GA2185@goldbach.in-berlin.de>
In-Reply-To: <20020214163705.GA2185@goldbach.in-berlin.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 14 February 2002 09:37 am, Gerd Knorr wrote:
> > -               pmi_base  = (unsigned short*)bus_to_virt(((unsigned
> > long)screen_info.vesapm_seg << 4) + screen_info.vesapm_off); +           
> >    pmi_base  = (unsigned short*)phys_to_virt(((unsigned
> > long)screen_info.vesapm_seg << 4) + screen_info.vesapm_off);
>
> Looks fine to me.  While s/bus/phys/ isn't the approximate fix for many
> drivers, at this place it is correct.  The address is a segment:offset
> pointer to a physical memory address somewhere in the VESA BIOS.
>
>   Gerd

Thanks.  Do to some cut-and-paste haste, my original patch converted tabs
to spaces, so that patch won't apply.  Here is a correct version for anyone
wanting to use it.  Also, my net connnection was down this morning, so I failed
to see the other recent thread about this subject, [PATCH} 2.5.5-pre1 VESA fb.
Adding those correspondents to the cc list.

Steven

--- linux-2.5.5-pre1/drivers/video/vesafb.c.orig	Thu Feb 14 08:16:25 2002
+++ linux-2.5.5-pre1/drivers/video/vesafb.c	Thu Feb 14 08:17:24 2002
@@ -550,7 +550,7 @@
 		ypan = pmi_setpal = 0; /* not available or some DOS TSR ... */
 
 	if (ypan || pmi_setpal) {
-		pmi_base  = (unsigned short*)bus_to_virt(((unsigned long)screen_info.vesapm_seg << 4) + screen_info.vesapm_off);
+		pmi_base  = (unsigned short*)phys_to_virt(((unsigned long)screen_info.vesapm_seg << 4) + screen_info.vesapm_off);
 		pmi_start = (void*)((char*)pmi_base + pmi_base[1]);
 		pmi_pal   = (void*)((char*)pmi_base + pmi_base[2]);
 		printk(KERN_INFO "vesafb: pmi: set display start = %p, set palette = %p\n",pmi_start,pmi_pal);
