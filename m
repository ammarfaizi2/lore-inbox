Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271118AbRHXLGP>; Fri, 24 Aug 2001 07:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271129AbRHXLGG>; Fri, 24 Aug 2001 07:06:06 -0400
Received: from ns.suse.de ([213.95.15.193]:38148 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S271118AbRHXLF7>;
	Fri, 24 Aug 2001 07:05:59 -0400
Date: Fri, 24 Aug 2001 13:06:14 +0200
From: Olaf Hering <olh@suse.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
        Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Hollis Blanchard <hollis@austin.ibm.com>
Subject: Re: scr_*() audit
Message-ID: <20010824130614.F13094@suse.de>
In-Reply-To: <Pine.LNX.4.05.10108221846140.6842-100000@callisto.of.borg> <20010823231143.A22014@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <20010823231143.A22014@suse.de>; from olh@suse.de on Thu, Aug 23, 2001 at 11:11:43PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, Olaf Hering wrote:

> On Wed, Aug 22, Geert Uytterhoeven wrote:
> 
> > +				q++
> 
> typo :)
> 
> > diff -ur linux-2.4.8-ac9/drivers/video/hgafb.c scr-audit-2.4.8-ac9/drivers/video/hgafb.c
> > --- linux-2.4.8-ac9/drivers/video/hgafb.c	Mon May 28 11:07:02 2001
> > +++ scr-audit-2.4.8-ac9/drivers/video/hgafb.c	Wed Aug 22 18:48:32 2001
> > @@ -203,7 +203,7 @@
> >  		fillchar = 0x00;
> >  	spin_unlock_irqrestore(&hga_reg_lock, flags);
> >  	if (fillchar != 0xbf)
> > -		memset((char *)hga_vram_base, fillchar, hga_vram_len);
> > +		isa_memset_io((char *)hga_vram_base, fillchar, hga_vram_len);
> >  }
> >  
> >  
> > @@ -279,7 +279,8 @@
> >  	char *logo = linux_logo_bw;
> >  	for (y = 134; y < 134 + 80 ; y++) /* this needs some cleanup */
> >  		for (x = 0; x < 10 ; x++)
> > -			*(dest + (y%4)*8192 + (y>>2)*90 + x + 40) = ~*(logo++);
> > +			isa_writeb(~*(logo++),
> > +				   (dest + (y%4)*8192 + (y>>2)*90 + x + 40));
> >  }

--- hgafb.c     Thu Aug 23 23:19:58 2001
+++ drivers/video/hgafb.c       Fri Aug 24 13:02:57 2001
@@ -203,7 +203,7 @@
                fillchar = 0x00;
        spin_unlock_irqrestore(&hga_reg_lock, flags);
        if (fillchar != 0xbf)
-               isa_memset_io((char *)hga_vram_base, fillchar, hga_vram_len);
+               isa_memset_io(hga_vram_base, fillchar, hga_vram_len);
 }


@@ -280,7 +280,7 @@
        for (y = 134; y < 134 + 80 ; y++) /* this needs some cleanup */
                for (x = 0; x < 10 ; x++)
                        isa_writeb(~*(logo++),
-                                  (dest + (y%4)*8192 + (y>>2)*90 + x + 40));
+                                  *(dest + (y%4)*8192 + (y>>2)*90 + x + 40));
 }
 #endif /* MODULE */



Anyone with a hercules card around? Do they still work?



Gruss Olaf

-- 
 $ man clone

BUGS
       Main feature not yet implemented...
