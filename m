Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265151AbTFEVEF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 17:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265136AbTFEVDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 17:03:46 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:40402 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265121AbTFEVB3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 17:01:29 -0400
Date: Thu, 5 Jun 2003 14:16:04 -0700
From: Greg KH <greg@kroah.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: remove usage of pci_for_each_dev() in sound/oss/via82cxxx_audio.c
Message-ID: <20030605211604.GA7029@kroah.com>
References: <200306050328.h553SlEL011941@hera.kernel.org> <3EDEC4AA.3050008@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EDEC4AA.3050008@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 05, 2003 at 12:18:50AM -0400, Jeff Garzik wrote:
> Linux Kernel Mailing List wrote:
> >ChangeSet 1.1254.4.15, 2003/06/04 12:30:25-07:00, greg@kroah.com
> >
> >	[PATCH] PCI: remove usage of pci_for_each_dev() in 
> >	sound/oss/via82cxxx_audio.c
> >
> >
> ># This patch includes the following deltas:
> >#	           ChangeSet	1.1254.4.14 -> 1.1254.4.15
> >#	sound/oss/via82cxxx_audio.c	1.27    -> 1.28   
> >#
> >
> > via82cxxx_audio.c |   11 +++++------
> > 1 files changed, 5 insertions(+), 6 deletions(-)
> >
> >
> >diff -Nru a/sound/oss/via82cxxx_audio.c b/sound/oss/via82cxxx_audio.c
> >--- a/sound/oss/via82cxxx_audio.c	Wed Jun  4 20:28:51 2003
> >+++ b/sound/oss/via82cxxx_audio.c	Wed Jun  4 20:28:51 2003
> >@@ -1357,12 +1357,12 @@
> > {
> > 	int minor = minor(inode->i_rdev);
> > 	struct via_info *card;
> >-	struct pci_dev *pdev;
> >+	struct pci_dev *pdev = NULL;
> > 	struct pci_driver *drvr;
> > 
> > 	DPRINTK ("ENTER\n");
> > 
> >-	pci_for_each_dev(pdev) {
> >+	while ((pdev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, pdev)) != 
> >NULL) {
> > 		drvr = pci_dev_driver (pdev);
> > 		if (drvr == &via_driver) {
> > 			assert (pci_get_drvdata (pdev) != NULL);
> 
> 
> Looking at your various commits in this vein, it really looks like there 
> needs to be a function that returns the PCI device, given the struct 
> pci_driver pointer.  pci_find_driver() perhaps?

Hm, only about 3 places really use that, and they would want something
that would iterate over all pci devices that were bound to that driver.
As the three places are in OSS drivers, I don't know if it's really
worth adding a pci core function for them :)

thanks,

greg k-h
