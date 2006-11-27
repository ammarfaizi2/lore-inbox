Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758609AbWK0Xbz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758609AbWK0Xbz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 18:31:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758608AbWK0Xbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 18:31:55 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:54441 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1758606AbWK0Xbz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 18:31:55 -0500
Message-ID: <456B7560.2020301@garzik.org>
Date: Mon, 27 Nov 2006 18:31:44 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org,
       Nicolas.Mailhot@LaPoste.net
Subject: Re: [PATCH -mm] sata_nv: fix ATAPI in ADMA mode
References: <4569F703.8010209@shaw.ca> <20061127151541.16a93d49.akpm@osdl.org>
In-Reply-To: <20061127151541.16a93d49.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Sun, 26 Nov 2006 14:20:19 -0600
> Robert Hancock <hancockr@shaw.ca> wrote:
> 
>>  static irqreturn_t nv_adma_interrupt(int irq, void *dev_instance)
>>  {
>>  	struct ata_host *host = dev_instance;
>>  	int i, handled = 0;
>> +	u32 notifier_clears[2];
>>  
>>  	spin_lock(&host->lock);
>>  
>>  	for (i = 0; i < host->n_ports; i++) {
>>  		struct ata_port *ap = host->ports[i];
>> +		notifier_clears[i] = 0;
> 
> Promise us that n_ports will never exceed 2?

ADMA spec is only defined for two channels, at least.

	Jeff



