Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758595AbWK0XQp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758595AbWK0XQp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 18:16:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758598AbWK0XQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 18:16:44 -0500
Received: from smtp.osdl.org ([65.172.181.25]:40675 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1758594AbWK0XQn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 18:16:43 -0500
Date: Mon, 27 Nov 2006 15:15:41 -0800
From: Andrew Morton <akpm@osdl.org>
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>, Nicolas.Mailhot@LaPoste.net
Subject: Re: [PATCH -mm] sata_nv: fix ATAPI in ADMA mode
Message-Id: <20061127151541.16a93d49.akpm@osdl.org>
In-Reply-To: <4569F703.8010209@shaw.ca>
References: <4569F703.8010209@shaw.ca>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Nov 2006 14:20:19 -0600
Robert Hancock <hancockr@shaw.ca> wrote:

>  static irqreturn_t nv_adma_interrupt(int irq, void *dev_instance)
>  {
>  	struct ata_host *host = dev_instance;
>  	int i, handled = 0;
> +	u32 notifier_clears[2];
>  
>  	spin_lock(&host->lock);
>  
>  	for (i = 0; i < host->n_ports; i++) {
>  		struct ata_port *ap = host->ports[i];
> +		notifier_clears[i] = 0;

Promise us that n_ports will never exceed 2?
