Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262061AbVD0WWk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262061AbVD0WWk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 18:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262054AbVD0WUo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 18:20:44 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:16348 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262061AbVD0WSo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 18:18:44 -0400
Date: Wed, 27 Apr 2005 17:18:29 -0500 (CDT)
From: Kylene Hall <kjhall@us.ibm.com>
X-X-Sender: kjhall@jo.austin.ibm.com
To: Jeff Garzik <jgarzik@pobox.com>
cc: Greg K-H <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 7 of 12] Fix TPM driver -- use to_pci_dev
In-Reply-To: <422FC42B.7@pobox.com>
Message-ID: <Pine.LNX.4.61.0504271454570.3929@jo.austin.ibm.com>
References: <1110415321526@kroah.com> <422FC42B.7@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
