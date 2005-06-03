Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261374AbVFCQYc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261374AbVFCQYc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 12:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbVFCQYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 12:24:32 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:37786 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261374AbVFCQYG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 12:24:06 -0400
Subject: Re: TPM on IBM thinkcenter S51
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: Torsten Landschoff <tla@comsys.informatik.uni-kiel.de>
Cc: trusted linux <tcimpl2005@yahoo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1117810969.5407.11.camel@localhost.localdomain>
References: <20050602220028.3572.qmail@web61014.mail.yahoo.com>
	 <1117790588.6249.5.camel@localhost.localdomain>
	 <1117810969.5407.11.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 03 Jun 2005 11:23:12 -0500
Message-Id: <1117815792.5407.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok,

I think this patch will fix the driver to find your TPM.  It is just
adding some additional LPC buses to look for so it won't make things any
worse if it doesn't fix the problem.  Please let me know if it works.
If it finds the device it should print a version message in syslog.
Also there should be a tpm0 directory in /sys/classs/misc.  Once you
have that you can try to cat /sys/class/misc/tpm0/device/pcrs.  If that
returns an error please try the next patch I send you and let me know
the results.

Thanks,
Kylie

Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
--- linux-2.6.12-rc5/drivers/char/tpm/tpm_nsc.c.orig	2005-06-03 11:14:07.000000000 -0500
+++ linux-2.6.12-rc5/drivers/char/tpm/tpm_nsc.c	2005-06-03 11:14:53.000000000 -0500
@@ -340,6 +340,9 @@ static struct pci_device_id tpm_pci_tbl[
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_12)},
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801EB_0)},
 	{PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_8111_LPC)},
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH6_0)},
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH6_1)},
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH7_0)},
 	{0,}
 };
 


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

