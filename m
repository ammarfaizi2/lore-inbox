Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261193AbULAAfX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbULAAfX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 19:35:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261186AbULAAet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 19:34:49 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32435 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261227AbULAA1h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 19:27:37 -0500
Date: Tue, 30 Nov 2004 15:00:31 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Manfred Schwarb <manfred99@gmx.ch>, chas@cmf.nrl.navy.mil,
       linux-kernel@vger.kernel.org, linux-atm-general@lists.sourceforge.net
Subject: Re: [2.6 patch] Build Error 2: build of pca200e.bin fails
Message-ID: <20041130170031.GD5009@dmt.cyclades>
References: <20041119100327.32511.6195.54797@tp-meteodat6.cyberlink.ch> <20041128192121.GE4390@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041128192121.GE4390@stusta.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 28, 2004 at 08:21:21PM +0100, Adrian Bunk wrote:
> On Fri, Nov 19, 2004 at 05:03:29AM -0500, Manfred Schwarb wrote:
> > Hi,
> > 
> > OK, I know I'm stupid...
> > I always forget to unset my GZIP options, as I have
> > "export GZIP='-9 -N'" in my .bashrc.
> > 
> > This results in the following:
> > 
> > objcopy -Iihex pca200e.data -Obinary pca200e.bin.gz
> > gzip -df pca200e.bin.gz
> > ./fore200e_mkfirm -k -b _fore200e_pca_fw \
> >   -i pca200e.bin -o fore200e_pca_fw.c
> > ./fore200e_mkfirm: can't open pca200e.bin for reading
> > make[2]: *** [fore200e_pca_fw.c] Error 254
> > make[2]: Leaving directory `/usr/src/linux-2.4.28/drivers/atm'
> > make[1]: *** [_modsubdir_atm] Error 2
> > make[1]: Leaving directory `/usr/src/linux-2.4.28/drivers'
> > make: *** [_mod_drivers] Error 2
> > 
> > 
> > The following patch would correct this:
> > 
> > --- linux-2.4.28/drivers/atm/Makefile.orig	2004-11-19 09:33:21.000000000 +0000
> > +++ linux-2.4.28/drivers/atm/Makefile	2004-11-19 09:38:07.000000000 +0000
> > @@ -92,7 +92,7 @@
> >  # deal with the various suffixes of the binary firmware images
> >  %.bin %.bin1 %.bin2: %.data
> >  	objcopy -Iihex $< -Obinary $@.gz
> > -	gzip -df $@.gz
> > +	gzip -n -df $@.gz
> >  
> >  fore_200e.o: $(fore_200e-objs)
> >  	$(LD) -r -o $@ $(fore_200e-objs)
> 
> 
> I have no problems with this patch, but shouldn't the same be done
> in 2.6?
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6.10-rc2-mm3-full/drivers/atm/Makefile.old	2004-11-28 20:18:04.000000000 +0100
> +++ linux-2.6.10-rc2-mm3-full/drivers/atm/Makefile	2004-11-28 20:18:15.000000000 +0100
> @@ -68,4 +68,4 @@
>  # deal with the various suffixes of the binary firmware images
>  $(obj)/%.bin $(obj)/%.bin1 $(obj)/%.bin2: $(src)/%.data
>  	objcopy -Iihex $< -Obinary $@.gz
> -	gzip -df $@.gz
> +	gzip -n -df $@.gz

Isnt it exactly the same of what has been merged in v2.4?

I can't see any difference.

[marcelo@dmt atm]$ bk diffs -u -r1.8 -r1.9 Makefile 
===== Makefile 1.8 vs 1.9 =====
--- 1.8/drivers/atm/Makefile    Mon Jul 28 11:35:31 2003
+++ 1.9/drivers/atm/Makefile    Mon Nov 22 21:54:09 2004
@@ -92,7 +92,7 @@
 # deal with the various suffixes of the binary firmware images
 %.bin %.bin1 %.bin2: %.data
        objcopy -Iihex $< -Obinary $@.gz
-       gzip -df $@.gz
+       gzip -n -df $@.gz
 
 fore_200e.o: $(fore_200e-objs)
        $(LD) -r -o $@ $(fore_200e-objs)
