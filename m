Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316635AbSFJGdj>; Mon, 10 Jun 2002 02:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316681AbSFJGdi>; Mon, 10 Jun 2002 02:33:38 -0400
Received: from smtp-in.sc5.paypal.com ([216.136.155.8]:6841 "EHLO
	smtp-in.sc5.paypal.com") by vger.kernel.org with ESMTP
	id <S316635AbSFJGdh>; Mon, 10 Jun 2002 02:33:37 -0400
Date: Sun, 9 Jun 2002 23:33:27 -0700
From: Brad Heilbrun <heilb@megapathdsl.com>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] 2.5.21 pnpbios compile error.
Message-ID: <20020610063327.GA19217@paypal.com>
Mail-Followup-To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
In-Reply-To: <200206101347.07394.corporal_pisang@counter-strike.com.my>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2002 at 01:47:07PM +0800, Corporal Pisang wrote:
> I get this error compiling 2.5.21
> 
> make[2]: Entering directory `/usr/src/linux/drivers/pnp'
>   gcc -Wp,-MD,.pnpbios_proc.o.d -D__KERNEL__ -I/usr/src/linux/include -Wall 
> -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
> -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
> -march=athlon  -nostdinc -iwithprefix include    
> -DKBUILD_BASENAME=pnpbios_proc   -c -o pnpbios_proc.o pnpbios_proc.c
> pnpbios_proc.c:193: parse error before "pnpbios_proc_init"

Another casualty of the recent header cleanup. Trivial patch
below. The rest of the files in this directory look clean as far as
__init and __exit calls go.

diff -Nur linux-2.5/drivers/pnp/pnpbios_proc.c~ linux-2.5/drivers/pnp/pnpbios_proc.c
--- linux-2.5/drivers/pnp/pnpbios_proc.c~	Sun Jun  9 23:01:13 2002
+++ linux-2.5/drivers/pnp/pnpbios_proc.c	Sun Jun  9 23:01:24 2002
@@ -28,6 +28,7 @@
 #include <linux/types.h>
 #include <linux/proc_fs.h>
 #include <linux/pnpbios.h>
+#include <linux/init.h>
 
 static struct proc_dir_entry *proc_pnp = NULL;
 static struct proc_dir_entry *proc_pnp_boot = NULL;


-- 

Thank you,

Brad Heilbrun
Administrator, Network Operations
PayPal, Inc.
650.864.8200 - noc@paypal.com

