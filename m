Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264853AbRGAAAY>; Sat, 30 Jun 2001 20:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264738AbRGAAAO>; Sat, 30 Jun 2001 20:00:14 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:51136 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S264733AbRGAAAA>;
	Sat, 30 Jun 2001 20:00:00 -0400
Message-ID: <3B3E681F.D96AA0A9@mandrakesoft.com>
Date: Sat, 30 Jun 2001 20:00:31 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: PALFFY Daniel <dpalffy@kkt.bme.hu>
Cc: Alan Cox <laughing@shared-source.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.5-acX, airo_cs
In-Reply-To: <Pine.LNX.4.21.0106302244420.18632-100000@iris.kkt.bme.hu>
Content-Type: multipart/mixed;
 boundary="------------1E781ABD88D71DCC759619AA"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------1E781ABD88D71DCC759619AA
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

PALFFY Daniel wrote:
> --- linux/drivers/net/wireless/airo.c~  Sat Jun 30 22:37:10 2001
> +++ linux/drivers/net/wireless/airo.c   Sat Jun 30 22:37:33 2001
> @@ -2988,9 +2988,7 @@
>          * fails with an error other than -ENODEV, instead of proceeding,
>          * if ISA devs are present.
>          */
> -       if (have_isa_dev)
> -               return 0;
> -       return rc;
> +       return 0;
>  }

Thanks, I applied this patch manually, with a comment as well.  Here is
what I have (attached).

-- 
Jeff Garzik      | Andre the Giant has a posse.
Building 1024    |
MandrakeSoft     |
--------------1E781ABD88D71DCC759619AA
Content-Type: text/plain; charset=us-ascii;
 name="airo.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="airo.patch"

Index: drivers/net/wireless/airo.c
===================================================================
RCS file: /cvsroot/gkernel/linux_2_4/drivers/net/wireless/Attic/airo.c,v
retrieving revision 1.1.1.9
diff -u -r1.1.1.9 airo.c
--- drivers/net/wireless/airo.c	2001/06/30 05:24:30	1.1.1.9
+++ drivers/net/wireless/airo.c	2001/06/30 23:59:28
@@ -2984,14 +2984,9 @@
 	printk( KERN_INFO "airo:  Finished probing for PCI adapters\n" );
 #endif
 
-	/* arguably, we should clean up and error exit if pci_module_init
-	 * fails with an error other than -ENODEV, instead of proceeding,
-	 * if ISA devs are present.
+	/* Always exit with success, as we are a library module
+	 * as well as a driver module
 	 */
-	if (have_isa_dev)
-		return 0;
-	if (rc && (rc != -ENODEV))
-		return rc;
 	return 0;
 }
 

--------------1E781ABD88D71DCC759619AA--

