Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbUDSQWs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 12:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261340AbUDSQWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 12:22:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10377 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261221AbUDSQWq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 12:22:46 -0400
Message-ID: <4083FCC8.70203@pobox.com>
Date: Mon, 19 Apr 2004 12:22:32 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
CC: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: orinoco potentially dereferencing before check
References: <20040416211826.GN20937@redhat.com> <20040417112549.GA32444@zax>
In-Reply-To: <20040417112549.GA32444@zax>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Gibson wrote:
> On Fri, Apr 16, 2004 at 10:18:26PM +0100, Dave Jones wrote:
> 
>>+++ linux-2.6.5/drivers/net/wireless/orinoco_pci.c	2004-04-16 22:17:30.000000000 +0100
>>@@ -275,14 +275,16 @@
>> static void __devexit orinoco_pci_remove_one(struct pci_dev *pdev)
>> {
>> 	struct net_device *dev = pci_get_drvdata(pdev);
>>-	struct orinoco_private *priv = dev->priv;
>>+	struct orinoco_private *priv;
>> 
>> 	if (! dev)
>> 		BUG();
>> 
>>+	priv = dev->priv;
>>+
>> 	unregister_netdev(dev);
>> 
>>-        if (dev->irq)
>>+	if (dev->irq)
>> 		free_irq(dev->irq, dev);
>> 
>> 	if (priv->hw.iobase)
>>-
> 
> 
> Better to just remove the if (! dev) BUG().  I don't believe we've
> ever hit that particular BUG() in debugging, so there's probably not
> much point having it.


done.

	Jeff



