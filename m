Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261375AbVFCQZr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbVFCQZr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 12:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261376AbVFCQZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 12:25:47 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:6827 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261375AbVFCQZX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 12:25:23 -0400
Subject: Re: TPM on IBM thinkcenter S51
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: Torsten Landschoff <tla@comsys.informatik.uni-kiel.de>
Cc: trusted linux <tcimpl2005@yahoo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1117810969.5407.11.camel@localhost.localdomain>
References: <20050602220028.3572.qmail@web61014.mail.yahoo.com>
	 <1117790588.6249.5.camel@localhost.localdomain>
	 <1117810969.5407.11.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 03 Jun 2005 11:24:33 -0500
Message-Id: <1117815874.5407.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The second patch that may be necessary to fix the NSC TPM command path.
Please let me know your results.

Thanks,
Kylie

Signed-off-by: Kylene Hall
---
--- linux-2.6.12-rc4/drivers/char/tpm/tpm_nsc.orig	2005-06-03 10:50:45.000000000 -0500
+++ linux-2.6.12-rc4/drivers/char/tpm/tpm_nsc.c	2005-06-03 10:51:09.000000000 -0500
@@ -149,7 +149,7 @@ static int tpm_nsc_recv(struct tpm_chip 
 			break;
 		*p = inb(chip->vendor->base + NSC_DATA);
 	}
-
+/*
 	if ((data & NSC_STATUS_F0) == 0) {
 		dev_err(&chip->pci_dev->dev, "F0 not set\n");
 		return -EIO;
@@ -159,7 +159,7 @@ static int tpm_nsc_recv(struct tpm_chip 
 			"expected end of command(0x%x)\n", data);
 		return -EIO;
 	}
-
+*/
 	native_size = (__force __be32 *) (buf + 2);
 	size = be32_to_cpu(*native_size);
 



On Fri, 2005-06-03 at 10:02 -0500, Kylene Jo Hall wrote:
> Hi Torsten,
> 
> I maintain the driver and am interested in figuring out what this
> problem is.  Can you please tell me what the device major/minor are
> on /dev/tpm.  Any output produced by the driver in /var/log/messages.
> Also the output of /sbin/lspci.  Also I am assuming you are using the
> version in the default 2.6.12-rc5.  There are many changes are in the -
> mm2 patch so I will pull down the default tree and make sure the version
> there is working.
> 
> Thanks,
> Kylie
> 
> On Fri, 2005-06-03 at 11:23 +0200, Torsten Landschoff wrote:
> > On Thu, 2005-06-02 at 15:00 -0700, trusted linux wrote:
> > > thanks, here is my strace related to tpm:
> > > 
> > > open("/dev/tpm", O_RDWR)                = -1 ENODEV
> > > (No such device)
> > > write(2, "Can\'t open TPM Driver\n", 22Can't open TPM
> > > Driver
> > > ) = 22
> > 
> > Okay, so the driver is in fact not working. It could be that /dev/tpm
> > has the wrong device number assigned. If the driver is really installed
> > can be checked by
> > 
> > 	systool -c misc|grep tpm
> > 
> > I bet it does not show anything. OTOH if the module loads successfully
> > it really should be there. No idea what's going wrong then. 
> > 
> > Which version of the driver are you using?
> > 
> > Greetings
> > 
> > 	Torsten
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> > 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

