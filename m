Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263637AbTEWFzO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 01:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263638AbTEWFzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 01:55:13 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:60176 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263637AbTEWFzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 01:55:12 -0400
Date: Fri, 23 May 2003 07:07:15 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI changes for 2.5.69
Message-ID: <20030523070715.A5038@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <10536411604060@kroah.com> <10536411602454@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <10536411602454@kroah.com>; from greg@kroah.com on Thu, May 22, 2003 at 03:06:01PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 22, 2003 at 03:06:01PM -0700, Greg KH wrote:
> ChangeSet 1.1210, 2003/05/22 10:30:35-07:00, greg@kroah.com
> 
> PCI: add pci_get_dev() and pci_put_dev()
> 
> Move the PCI core to start using these, enabling proper reference counting
> on struct pci_dev.
> 
> 
>  drivers/pci/bus.c        |    2 +-
>  drivers/pci/hotplug.c    |    2 +-
>  drivers/pci/pci-driver.c |   41 +++++++++++++++++++++++++++++++++++++++++
>  drivers/pci/probe.c      |   18 ++++++++++++++++++
>  include/linux/pci.h      |    2 ++
>  5 files changed, 63 insertions(+), 2 deletions(-)
> 
> 
> diff -Nru a/drivers/pci/bus.c b/drivers/pci/bus.c
> --- a/drivers/pci/bus.c	Thu May 22 14:50:44 2003
> +++ b/drivers/pci/bus.c	Thu May 22 14:50:44 2003
> @@ -92,7 +92,7 @@
>  		if (!list_empty(&dev->global_list))
>  			continue;
>  
> -		device_register(&dev->dev);
> +		device_add(&dev->dev);

This doesn't match the patch description..

> +struct pci_dev *pci_get_dev (struct pci_dev *dev)

Please fix up to adhere Documentation/CodingStyle (hint: placement
of the opening brace is wrong).

> +{
> +	struct device *tmp;
> +
> +	if (!dev)
> +		return NULL;

Does it make sense to allow NULL argument here?

