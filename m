Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263917AbUCZDlY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 22:41:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263919AbUCZDlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 22:41:24 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36320 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263900AbUCZDlQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 22:41:16 -0500
Message-ID: <4063A64D.2000901@pobox.com>
Date: Thu, 25 Mar 2004 22:41:01 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: andersen@codepoet.org
CC: linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [sata] Promise PATA port on PDC2037x SATA
References: <40638943.9010206@pobox.com> <20040326031619.GA1755@codepoet.org>
In-Reply-To: <20040326031619.GA1755@codepoet.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for testing.

Is your PCI id listed in this function?

static int pdc_pata_possible(struct pci_dev *pdev)
{
         if (pdev->device == 0x3375)
                 return 1;
         return 0;
}

If yes, hrm.  :)

If no, just unconditionally return 1 there and see if you get the 
message in pdc_host_init():

         /* check for PATA port on PDC20375 */
         if (pdc_pata_possible(pdev)) {
                 tmp = readl(mmio + PDC_PCI_CTL);
                 if (tmp & PDC_HAS_PATA)
                         printk(KERN_INFO DRV_NAME "(%s): sorry, PATA 
port not supported yet\n",
                                pci_name(pdev));
         }


