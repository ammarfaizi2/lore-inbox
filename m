Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964850AbWFHOq5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964850AbWFHOq5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 10:46:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964852AbWFHOq5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 10:46:57 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:5580 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964850AbWFHOq4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 10:46:56 -0400
Message-ID: <44883858.3090708@garzik.org>
Date: Thu, 08 Jun 2006 10:46:48 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
CC: akpm@osdl.org, Greg KH <greg@kroah.com>,
       Rajesh Shah <rajesh.shah@intel.com>,
       Grant Grundler <grundler@parisc-linux.org>,
       "bibo,mao" <bibo.mao@intel.com>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 3/4] Make Intel e1000 driver legacy I/O port free
References: <447E91CE.7010705@intel.com> <20060601024611.A32490@unix-os.sc.intel.com> <20060601171559.GA16288@colo.lackof.org> <20060601113625.A4043@unix-os.sc.intel.com> <447FA920.9060509@jp.fujitsu.com> <4484263C.1030508@jp.fujitsu.com> <20060606075812.GB19619@kroah.com> <448643B9.2080805@jp.fujitsu.com> <448644A2.7000208@jp.fujitsu.com> <448818BB.6020503@garzik.org> <44882787.20901@jp.fujitsu.com>
In-Reply-To: <44882787.20901@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kenji Kaneshige wrote:
> No, those tasks are done through pci_enable_device_bars() called from
> pci_enable_device() actually. In addition, I made small changes to
> pci_enable_device() and pci_enable_device_bars() in another patch ([PATCH 1/4]).
> Now pci_enable_device_bars() just call pci_enable_device_bars() like below:
> 
> int
> pci_enable_device(struct pci_dev *dev)
> {
>         int err = pci_enable_device_bars(dev, (1 << PCI_NUM_RESOURCES) - 1);
>         if (err)
>                 return err;
>         return 0;
> }

You'll likely break IDE with such a change, which I also NAK.  You can't
just blindly do everything that pci_enable_device() does in IDE, which
was the entire reason why pci_enable_device_bars() was added by Alan in
the first place.

	Jeff


