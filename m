Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262198AbVEEToz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262198AbVEEToz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 15:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262214AbVEETnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 15:43:07 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:40671 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262198AbVEETLZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 15:11:25 -0400
Date: Thu, 5 May 2005 14:11:13 -0500 (CDT)
From: Kylene Hall <kjhall@us.ibm.com>
X-X-Sender: kjhall@localhost.localdomain
To: akpm@osdl.org
cc: jgarzik@pobox.com, greg@kroah.com, linux-kernel@vger.kernel.org
Subject: [PATCH 7 of 12] Fix TPM driver -- use to_pci_dev
Message-ID: <Pine.LNX.4.62.0505051337060.5303@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please apply these fixes to the Tpm driver.  I am resubmitting the entire
patch set that was orginally sent to LKML on April 27 with the changes
that were requested fixed.

Thanks,
Kylie

On Wed, 9 Mar 2005, Jeff Garzik wrote:
> Greg KH wrote:

<snip>

> > +static ssize_t show_pcrs(struct device *dev, char *buf)
> > +{
> > +	u8 data[READ_PCR_RESULT_SIZE];
> > +	ssize_t len;
> > +	int i, j, index, num_pcrs;
> > +	char *str = buf;
> > +
> > +	struct tpm_chp *chip =
> > +	    pci_get_drvdata(container_of(dev, struct pci_dev, dev));
> 
> use to_pci_dev()

<snip>

> > +	ssize_t len;
> > +	__be32 *native_val;
> > +	int i;
> > +	char *str = buf;
> > +
> > +	struct tpm_chip *chip =
> > +	    pci_get_drvdata(container_of(dev, struct pci_dev, dev));
> 
> to_pci_dev()

<snip>

> > +	ssize_t len;
> > +	char *str = buf;
> > +
> > +	struct tpm_chip *chip =
> > +	    pci_get_drvdata(container_of(dev, struct pci_dev, dev));
> 
> to_pci_dev()

<snip>

The following patch changes these container_of calls to 'to_pci_dev' as 
suggested above.

Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
---
--- linux-2.6.12-rc2/drivers/char/tpm/tpm.c	2005-04-26 16:45:51.000000000 -0500
+++ linux-2.6.12-rc2-tpmdd/drivers/char/tpm/tpm.c	2005-04-26 16:48:12.000000000 -0500
@@ -230,7 +230,7 @@ ssize_t tpm_show_pcrs(struct device *dev
 	char *str = buf;
 
 	struct tpm_chip *chip =
-	    pci_get_drvdata(container_of(dev, struct pci_dev, dev));
+	    pci_get_drvdata(to_pci_dev(dev));
 	if (chip == NULL)
 		return -ENODEV;
 
@@ -273,7 +273,7 @@ ssize_t tpm_show_pubek(struct device *de
 	char *str = buf;
 
 	struct tpm_chip *chip =
-	    pci_get_drvdata(container_of(dev, struct pci_dev, dev));
+	    pci_get_drvdata(to_pci_dev(dev));
 	if (chip == NULL)
 		return -ENODEV;
 
@@ -352,7 +352,7 @@ ssize_t tpm_show_caps(struct device *dev
 	char *str = buf;
 
 	struct tpm_chip *chip =
-	    pci_get_drvdata(container_of(dev, struct pci_dev, dev));
+	    pci_get_drvdata(to_pci_dev(dev));
 	if (chip == NULL)
 		return -ENODEV;
 
\
