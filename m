Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316503AbSFEWdv>; Wed, 5 Jun 2002 18:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316533AbSFEWdt>; Wed, 5 Jun 2002 18:33:49 -0400
Received: from pizda.ninka.net ([216.101.162.242]:23948 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316503AbSFEWd0>;
	Wed, 5 Jun 2002 18:33:26 -0400
Date: Wed, 05 Jun 2002 15:29:59 -0700 (PDT)
Message-Id: <20020605.152959.98861473.davem@redhat.com>
To: ink@jurassic.park.msu.ru
Cc: mochel@osdl.org, anton@samba.org, linux-kernel@vger.kernel.org
Subject: Re: [2.5.19] Oops during PCI scan on Alpha
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020605182316.B3437@jurassic.park.msu.ru>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
   Date: Wed, 5 Jun 2002 18:23:16 +0400

   On Tue, Jun 04, 2002 at 03:03:33PM -0700, Patrick Mochel wrote:
   > -subsys_initcall(pci_driver_init);
   > +postcore_initcall(pci_driver_init);
   
   Fine, but my main objection was to pci_driver_init being an initcall
   in general, no matter in what level. With current code we may have
   pci_bus_type registered on a machine without PCI bus.
   Real life example: jensen running generic alpha kernel.
   
Ok, then we should have pci_driver_init called from the beginning
of pcibios_init if PCI controllers are found.
