Return-Path: <linux-kernel-owner+w=401wt.eu-S937074AbWLKQ1b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937074AbWLKQ1b (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 11:27:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937072AbWLKQ1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 11:27:31 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:47331 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937052AbWLKQ1a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 11:27:30 -0500
Message-ID: <457D86F0.4020408@garzik.org>
Date: Mon, 11 Dec 2006 11:27:28 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Robert Hancock <hancockr@shaw.ca>
CC: linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH -mm] sata_nv: add suspend/resume support
References: <456E3ED5.3090201@shaw.ca>
In-Reply-To: <456E3ED5.3090201@shaw.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Hancock wrote:
> +static void nv_remove_one (struct pci_dev *pdev)
> +{
> +	struct ata_host *host = dev_get_drvdata(&pdev->dev);
> +	struct nv_host_priv *hpriv = host->private_data;
> +	
> +	kfree(hpriv);
> +	ata_pci_remove_one(pdev);
> +}	


It is unwise to free the struct before the ports are even detached.

Otherwise, seems ok, but I would like to see some more positive user 
reports (both ADMA and not) before pushing upstream.

	Jeff


