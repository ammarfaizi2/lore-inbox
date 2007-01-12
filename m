Return-Path: <linux-kernel-owner+w=401wt.eu-S1161149AbXALXu7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161149AbXALXu7 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 18:50:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161175AbXALXu7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 18:50:59 -0500
Received: from colo.lackof.org ([198.49.126.79]:59338 "EHLO colo.lackof.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161149AbXALXu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 18:50:58 -0500
Date: Fri, 12 Jan 2007 16:50:54 -0700
From: Grant Grundler <grundler@parisc-linux.org>
To: Dmitriy Monakhov <dmonakhov@openvz.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       devel@openvz.org, linux-pci@atrey.karlin.mff.cuni.cz,
       netdev@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 2/5] fixing errors handling during pci_driver resume stage [ata]
Message-ID: <20070112235054.GA5074@colo.lackof.org>
References: <87tzz0mv4n.fsf@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tzz0mv4n.fsf@sw.ru>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09, 2007 at 12:01:28PM +0300, Dmitriy Monakhov wrote:
> ata pci drivers have to return correct error code during resume stage in
> case of errors.
...
> @@ -6246,8 +6253,10 @@ int ata_pci_device_suspend(struct pci_de
>  int ata_pci_device_resume(struct pci_dev *pdev)
>  {
>  	struct ata_host *host = dev_get_drvdata(&pdev->dev);
> +	int err;
>  
> -	ata_pci_device_do_resume(pdev);
> +	if ((err = ata_pci_device_do_resume(pdev)))
> +		return err;

nit: in every other case I looked at you did:
   err = foo()
   if (err) ...

Can you make that consistent here too?

thanks,
grant
