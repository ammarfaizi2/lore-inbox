Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264161AbUDRLcu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 07:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264162AbUDRLcu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 07:32:50 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:24069 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264161AbUDRLcr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 07:32:47 -0400
Date: Sun, 18 Apr 2004 12:32:41 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Herbert Xu <herbert@gondor.apana.org.au>, Rolf Kutz <kutz@netcologne.de>,
       244207@bugs.debian.org, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: Bug#244207: kernel-source-2.6.5: mwave gives warning on suspend
Message-ID: <20040418123241.A625@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Rolf Kutz <kutz@netcologne.de>, 244207@bugs.debian.org,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Russell King <rmk+lkml@arm.linux.org.uk>
References: <20040417104311.9C13A1D802@jamaika.kutz.dyndns.org> <20040417113918.GA4846@gondor.apana.org.au> <20040417124850.C14786@flint.arm.linux.org.uk> <20040417122322.GA15052@gondor.apana.org.au> <20040417122954.GA7533@gondor.apana.org.au> <20040418103109.GA13756@gondor.apana.org.au> <20040418121755.A493@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040418121755.A493@infradead.org>; from hch@infradead.org on Sun, Apr 18, 2004 at 12:17:55PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 18, 2004 at 12:17:55PM +0100, Christoph Hellwig wrote:
> It's still bogus.  The driver gets the sysfs support completely wrong
> and the right thing would be to find that change in the BK history and
> back it out.

Here's a patch to #if 0 out all the crap:

--- 1.12/drivers/char/mwave/mwavedd.c	Wed Sep 10 08:41:45 2003
+++ edited/drivers/char/mwave/mwavedd.c	Sun Apr 18 13:31:22 2004
@@ -466,6 +466,7 @@
 
 static struct miscdevice mwave_misc_dev = { MWAVE_MINOR, "mwave", &mwave_fops };
 
+#if 0 /* totally b0rked */
 /*
  * sysfs support <paulsch@us.ibm.com>
  */
@@ -499,6 +500,7 @@
 	&dev_attr_uart_irq,
 	&dev_attr_uart_io,
 };
+#endif
 
 /*
 * mwave_init is called on module load
@@ -508,11 +510,11 @@
 */
 static void mwave_exit(void)
 {
-	int i;
 	pMWAVE_DEVICE_DATA pDrvData = &mwave_s_mdd;
 
 	PRINTK_1(TRACE_MWAVE, "mwavedd::mwave_exit entry\n");
 
+#if 0
 	for (i = 0; i < pDrvData->nr_registered_attrs; i++)
 		device_remove_file(&mwave_device, mwave_dev_attrs[i]);
 	pDrvData->nr_registered_attrs = 0;
@@ -521,6 +523,7 @@
 		device_unregister(&mwave_device);
 		pDrvData->device_registered = FALSE;
 	}
+#endif
 
 	if ( pDrvData->sLine >= 0 ) {
 		unregister_serial(pDrvData->sLine);
@@ -638,6 +641,7 @@
 	}
 	/* uart is registered */
 
+#if 0
 	/* sysfs */
 	memset(&mwave_device, 0, sizeof (struct device));
 	snprintf(mwave_device.bus_id, BUS_ID_SIZE, "mwave");
@@ -655,6 +659,7 @@
 		}
 		pDrvData->nr_registered_attrs++;
 	}
+#endif
 
 	/* SUCCESS! */
 	return 0;
