Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262126AbVBQMrz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262126AbVBQMrz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 07:47:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262136AbVBQMry
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 07:47:54 -0500
Received: from postino4.roma1.infn.it ([141.108.26.24]:29084 "EHLO
	postino4.roma1.infn.it") by vger.kernel.org with ESMTP
	id S262126AbVBQMrl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 07:47:41 -0500
Message-ID: <4214926B.3030707@roma1.infn.it>
Date: Thu, 17 Feb 2005 13:47:39 +0100
From: Davide Rossetti <davide.rossetti@roma1.infn.it>
User-Agent: Mozilla Thunderbird  (X11/20041216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: rmmod while module is in use
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira Milter 1.0.6; VAE 6.29.0.5; VDF 6.29.0.133
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

maybe RTFM...
a module:
- char device driver for..
- a PCI device

any clue as to how to protect from module unloading while there is still 
some process opening it??? have I to sleep in the remove_one() pci 
driver function till last process closes its file descriptor???

static void __devexit apedev_remove_one(struct pci_dev *pdev)
{
    ApeDev* apedev = pci_get_drvdata(pdev);

    if(test_bit(APEDEV_FLAG_OPEN, &apedev->flags)) {
        PERROR("still open flag on!!! (flags=0x%08x)\n", apedev->flags);

        // sleep here till it gets closed...

    }
    ...
}

static struct pci_driver apedev_driver = {
    .name     =  DEVNAME,
    .id_table =  apedev_pci_tbl,
    .probe    =  apedev_init_one,
    .remove   =  __devexit_p(apedev_remove_one),
};

