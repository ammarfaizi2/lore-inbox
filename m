Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261569AbUK1TV0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261569AbUK1TV0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 14:21:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261574AbUK1TV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 14:21:26 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:43537 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261569AbUK1TVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 14:21:23 -0500
Date: Sun, 28 Nov 2004 20:21:21 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Manfred Schwarb <manfred99@gmx.ch>
Cc: chas@cmf.nrl.navy.mil, Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, linux-atm-general@lists.sourceforge.net
Subject: [2.6 patch] Build Error 2: build of pca200e.bin fails
Message-ID: <20041128192121.GE4390@stusta.de>
References: <20041119100327.32511.6195.54797@tp-meteodat6.cyberlink.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041119100327.32511.6195.54797@tp-meteodat6.cyberlink.ch>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2004 at 05:03:29AM -0500, Manfred Schwarb wrote:
> Hi,
> 
> OK, I know I'm stupid...
> I always forget to unset my GZIP options, as I have
> "export GZIP='-9 -N'" in my .bashrc.
> 
> This results in the following:
> 
> objcopy -Iihex pca200e.data -Obinary pca200e.bin.gz
> gzip -df pca200e.bin.gz
> ./fore200e_mkfirm -k -b _fore200e_pca_fw \
>   -i pca200e.bin -o fore200e_pca_fw.c
> ./fore200e_mkfirm: can't open pca200e.bin for reading
> make[2]: *** [fore200e_pca_fw.c] Error 254
> make[2]: Leaving directory `/usr/src/linux-2.4.28/drivers/atm'
> make[1]: *** [_modsubdir_atm] Error 2
> make[1]: Leaving directory `/usr/src/linux-2.4.28/drivers'
> make: *** [_mod_drivers] Error 2
> 
> 
> The following patch would correct this:
> 
> --- linux-2.4.28/drivers/atm/Makefile.orig	2004-11-19 09:33:21.000000000 +0000
> +++ linux-2.4.28/drivers/atm/Makefile	2004-11-19 09:38:07.000000000 +0000
> @@ -92,7 +92,7 @@
>  # deal with the various suffixes of the binary firmware images
>  %.bin %.bin1 %.bin2: %.data
>  	objcopy -Iihex $< -Obinary $@.gz
> -	gzip -df $@.gz
> +	gzip -n -df $@.gz
>  
>  fore_200e.o: $(fore_200e-objs)
>  	$(LD) -r -o $@ $(fore_200e-objs)


I have no problems with this patch, but shouldn't the same be done
in 2.6?


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm3-full/drivers/atm/Makefile.old	2004-11-28 20:18:04.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/drivers/atm/Makefile	2004-11-28 20:18:15.000000000 +0100
@@ -68,4 +68,4 @@
 # deal with the various suffixes of the binary firmware images
 $(obj)/%.bin $(obj)/%.bin1 $(obj)/%.bin2: $(src)/%.data
 	objcopy -Iihex $< -Obinary $@.gz
-	gzip -df $@.gz
+	gzip -n -df $@.gz

