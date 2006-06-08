Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964914AbWFHREE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964914AbWFHREE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 13:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964920AbWFHREE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 13:04:04 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:28125 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S964914AbWFHRED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 13:04:03 -0400
Message-ID: <448857AC.2030907@jp.fujitsu.com>
Date: Fri, 09 Jun 2006 02:00:28 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
Cc: akpm@osdl.org, Greg KH <greg@kroah.com>,
       Rajesh Shah <rajesh.shah@intel.com>,
       Grant Grundler <grundler@parisc-linux.org>,
       "bibo,mao" <bibo.mao@intel.com>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 3/4] Make Intel e1000 driver legacy I/O port free
References: <447E91CE.7010705@intel.com> <20060601024611.A32490@unix-os.sc.intel.com> <20060601171559.GA16288@colo.lackof.org> <20060601113625.A4043@unix-os.sc.intel.com> <447FA920.9060509@jp.fujitsu.com> <4484263C.1030508@jp.fujitsu.com> <20060606075812.GB19619@kroah.com> <448643B9.2080805@jp.fujitsu.com> <448644A2.7000208@jp.fujitsu.com> <448818BB.6020503@garzik.org> <44882787.20901@jp.fujitsu.com> <44883858.3090708@garzik.org>
In-Reply-To: <44883858.3090708@garzik.org>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Kenji Kaneshige wrote:
> 
>>No, those tasks are done through pci_enable_device_bars() called from
>>pci_enable_device() actually. In addition, I made small changes to
>>pci_enable_device() and pci_enable_device_bars() in another patch ([PATCH 1/4]).
>>Now pci_enable_device_bars() just call pci_enable_device_bars() like below:
>>
>>int
>>pci_enable_device(struct pci_dev *dev)
>>{
>>        int err = pci_enable_device_bars(dev, (1 << PCI_NUM_RESOURCES) - 1);
>>        if (err)
>>                return err;
>>        return 0;
>>}
> 
> 
> You'll likely break IDE with such a change, which I also NAK.  You can't
> just blindly do everything that pci_enable_device() does in IDE, which
> was the entire reason why pci_enable_device_bars() was added by Alan in
> the first place.
> 

Could you tell me what will be broken by my change? I only moved the
following two lines from pci_enable_device() to pci_enable_device_bars().

       pci_fixup_device(pci_fixup_enable, dev);
       dev->is_enabled = 1;

Thanks,
Kenji Kaneshige

