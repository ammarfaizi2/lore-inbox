Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264434AbTFEEFe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 00:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264447AbTFEEFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 00:05:33 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48093 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264434AbTFEEFc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 00:05:32 -0400
Message-ID: <3EDEC4AA.3050008@pobox.com>
Date: Thu, 05 Jun 2003 00:18:50 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: greg@kroah.com
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: remove usage of pci_for_each_dev() in sound/oss/via82cxxx_audio.c
References: <200306050328.h553SlEL011941@hera.kernel.org>
In-Reply-To: <200306050328.h553SlEL011941@hera.kernel.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mailing List wrote:
> ChangeSet 1.1254.4.15, 2003/06/04 12:30:25-07:00, greg@kroah.com
> 
> 	[PATCH] PCI: remove usage of pci_for_each_dev() in sound/oss/via82cxxx_audio.c
> 
> 
> # This patch includes the following deltas:
> #	           ChangeSet	1.1254.4.14 -> 1.1254.4.15
> #	sound/oss/via82cxxx_audio.c	1.27    -> 1.28   
> #
> 
>  via82cxxx_audio.c |   11 +++++------
>  1 files changed, 5 insertions(+), 6 deletions(-)
> 
> 
> diff -Nru a/sound/oss/via82cxxx_audio.c b/sound/oss/via82cxxx_audio.c
> --- a/sound/oss/via82cxxx_audio.c	Wed Jun  4 20:28:51 2003
> +++ b/sound/oss/via82cxxx_audio.c	Wed Jun  4 20:28:51 2003
> @@ -1357,12 +1357,12 @@
>  {
>  	int minor = minor(inode->i_rdev);
>  	struct via_info *card;
> -	struct pci_dev *pdev;
> +	struct pci_dev *pdev = NULL;
>  	struct pci_driver *drvr;
>  
>  	DPRINTK ("ENTER\n");
>  
> -	pci_for_each_dev(pdev) {
> +	while ((pdev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, pdev)) != NULL) {
>  		drvr = pci_dev_driver (pdev);
>  		if (drvr == &via_driver) {
>  			assert (pci_get_drvdata (pdev) != NULL);


Looking at your various commits in this vein, it really looks like there 
needs to be a function that returns the PCI device, given the struct 
pci_driver pointer.  pci_find_driver() perhaps?

	Jeff



