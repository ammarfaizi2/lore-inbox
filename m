Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750799AbWAJNkc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbWAJNkc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 08:40:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbWAJNkc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 08:40:32 -0500
Received: from mail1.kontent.de ([81.88.34.36]:31158 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S1750799AbWAJNkb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 08:40:31 -0500
From: Oliver Neukum <oliver@neukum.org>
To: "Thomas Dahlmann" <thomas.dahlmann@amd.com>
Subject: Re: [linux-usb-devel] [PATCH] UDC support for MIPS/AU1200 and Geode/CS5536
Date: Tue, 10 Jan 2006 14:40:38 +0100
User-Agent: KMail/1.8
Cc: linux-usb-devel@lists.sourceforge.net,
       "Jordan Crouse" <jordan.crouse@amd.com>, linux-mips@linux-mips.org,
       linux-kernel@vger.kernel.org, info-linux@ldcmail.amd.com
References: <20060109180356.GA8855@cosmic.amd.com> <200601092344.55988.oliver@neukum.org> <43C39431.6020308@amd.com>
In-Reply-To: <43C39431.6020308@amd.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601101440.38853.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 10. Januar 2006 12:02 schrieb Thomas Dahlmann:
> 
> Oliver Neukum wrote:
> 
> >Am Montag, 9. Januar 2006 19:03 schrieb Jordan Crouse:
> >  
> >
> >>>From the "two-birds-one-stone" department, I am pleased to present USB UDC
> >>support for both the MIPS Au1200 SoC and the Geode CS5535 south bridge.  
> >>Also, coming soon (in the next few days), OTG, which has been removed from
> >>the usb_host patch, and put into its own patch (as per David's comments).
> >>
> >>This patch is against current linux-mips git, but it should apply for Linus's
> >>tree as well.
> >>
> >>Regards,
> >>Jordan
> >>
> >>    
> >>
> >+        VDBG("udc_read_bytes(): %d bytes\n", bytes);
> >+
> >+        /* dwords first */
> >+        for (i = 0; i < bytes / UDC_DWORD_BYTES; i++) {
> >+               *((u32*) (buf + (i<<2))) = readl(dev->rxfifo); 
> >+        }
> >
> >Is there any reason you don't increment by 4?
> >
> >	Regards
> >		Oliver
> >
> >
> >
> >  
> >
> The loop is for reading dwords only, so "i < bytes / UDC_DWORD_BYTES" cuts
> off remaining 1,2 or 3 bytes which are handled by the next loop.
> But you are right, incrementing by 4 may look better,  as
> 
>         for (i = 0; i < bytes - bytes % UDC_DWORD_BYTES; i+=4) {
>                *((u32*) (buf + i)) = readl(dev->rxfifo); 
>         }

Not only will it look better, but it'll save you a shift operation.
You might even compute start and finish values before the loop and
save an addition in the body.

	Regards
		Oliver
