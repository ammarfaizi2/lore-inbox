Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932206AbVIMUWX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbVIMUWX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 16:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932239AbVIMUWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 16:22:23 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:23430
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932206AbVIMUWW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 16:22:22 -0400
Date: Tue, 13 Sep 2005 13:22:13 -0700 (PDT)
Message-Id: <20050913.132213.01982680.davem@davemloft.net>
To: torvalds@osdl.org
Cc: akropel1@rochester.rr.com, nkiesel@tbdnetworks.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.13.1 locks machine after some time, 2.6.12.5 work fine
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.58.0509130850550.3351@g5.osdl.org>
References: <20050913120255.A16713@mail.kroptech.com>
	<Pine.LNX.4.58.0509130850550.3351@g5.osdl.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@osdl.org>
Date: Tue, 13 Sep 2005 08:55:31 -0700 (PDT)

> >         /* Reset expansion ROM address decode enable */
> >         pci_read_config_word(ha->pdev, PCI_ROM_ADDRESS, &w);
> >         w &= ~PCI_ROM_ADDRESS_ENABLE;
> >         pci_write_config_word(ha->pdev, PCI_ROM_ADDRESS, w);
 ...
> So the above probably works fine, especially since it's just disabling the 
> ROM (ie we don't end up caring at all about the upper bits even if they 
> did get the wrong value). But it's definitely bad practice, and there are 
> probably cards (for which that driver is irrelevant, of course ;) where 
> doing something like the above might not work at all.

I think for consistency the above driver case should still be fixed,
however.  This way when people try to audit the tree for
PCI_ROM_ADDRESS config space accesses, they won't come across this
same instance again and again.
