Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264066AbTDOU2v (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 16:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264069AbTDOU2v 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 16:28:51 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:55761 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264066AbTDOU2t (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 16:28:49 -0400
Date: Tue, 15 Apr 2003 22:40:35 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: [2.4 patch] Re: 2.4.21-pre7: error compiling aic7(censored)/aicasm/aicasm.c
Message-ID: <20030415204034.GT9640@fs.tum.de>
References: <20030406125804.GW20044@fs.tum.de> <539290000.1049994210@aslan.btc.adaptec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <539290000.1049994210@aslan.btc.adaptec.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 10, 2003 at 11:03:30AM -0600, Justin T. Gibbs wrote:
> > <--  snip  -->
> > 
> > gcc-2.95 -D__KERNEL__ 
> > -I/home/bunk/linux/kernel-2.4/linux-2.4.21-pre7-full-nohotplug/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 
> > -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6  -D__KERNEL__ 
> > -I/home/bunk/linux/kernel-2.4/linux-2.4.21-pre7-full-nohotplug/include -e stext  
> > aicasm/aicasm.c   -o aicasm/aicasm
> > /usr/bin/ld: warning: cannot find entry symbol stext; defaulting to 08048760
> 
> This is probably due to the misplaced endif in the currently committed
> drivers/scsi/aic7xxx/Makefile.  Updated versions of the Makefile/driver
> can be found here:
> 
> http://people.FreeBSD.org/~gibbs/linux/SRC/

Yes, thanks, this fixed it.

Marcelo:
Below is the fix by Justin, please apply.

> Justin

cu
Adrian

--- linux-2.4.21-pre7-full/drivers/scsi/aic7xxx/Makefile.old	2003-04-15 22:31:43.000000000 +0200
+++ linux-2.4.21-pre7-full/drivers/scsi/aic7xxx/Makefile	2003-04-15 22:31:47.000000000 +0200
@@ -83,7 +83,7 @@
 endif
 $(aic79xx_gen): aic79xx.seq aic79xx.reg aicasm/aicasm
 	$(aic79xx_asm_cmd)
+endif
 
 aicasm/aicasm: aicasm/*.[chyl]
 	$(MAKE) -C aicasm
-endif
