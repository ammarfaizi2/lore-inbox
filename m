Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264665AbUIIOOw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264665AbUIIOOw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 10:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264704AbUIIOOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 10:14:51 -0400
Received: from the-village.bc.nu ([81.2.110.252]:31914 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S264665AbUIIOON (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 10:14:13 -0400
Subject: Re: [PATCH] missing pci_disable_device()
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: Greg KH <greg@kroah.com>, akpm@osdl.org, bjorn.helgaas@hp.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41403075.1010103@jp.fujitsu.com>
References: <413D0E4E.1000200@jp.fujitsu.com>
	 <1094550581.9150.8.camel@localhost.localdomain>
	 <413E7925.1010801@jp.fujitsu.com>
	 <1094647195.11723.5.camel@localhost.localdomain>
	 <413FF05B.8090505@jp.fujitsu.com> <20040909062009.GD10428@kroah.com>
	 <41403075.1010103@jp.fujitsu.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094735472.14640.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 09 Sep 2004 14:11:13 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-09-09 at 11:29, Kenji Kaneshige wrote:
> > 	dev_warn(&pci_dev->dev, "Device was removed without properly "
> > 				"calling pci_disable_device(), please fix.\n");
> > 	WARN_ON(1);
> > 

"This may need fixing" would be better than "please fix" as it may be
a wrong warning

> I changed my patch based on your feedback. But I have one
> concern about putting "WARN_ON(1);". I'm worrying that people
> might be surprised if stack dump is shown on their console,
> especially if the broken driver handles many devices.

You could put

#ifdef CONFIG_DEBUG_KERNEL

#endif

around that section, then only users selecting kernel debugging would
be bothered by it.

