Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311341AbSCLUnK>; Tue, 12 Mar 2002 15:43:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311342AbSCLUm5>; Tue, 12 Mar 2002 15:42:57 -0500
Received: from pizda.ninka.net ([216.101.162.242]:31950 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S311341AbSCLUmg>;
	Tue, 12 Mar 2002 15:42:36 -0500
Date: Tue, 12 Mar 2002 12:39:04 -0800 (PST)
Message-Id: <20020312.123904.78107946.davem@redhat.com>
To: beezly@beezly.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: Sun GEM card looses TX on x86 32bit PCI
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1015965269.1937.22.camel@monkey>
In-Reply-To: <1015887102.2051.4.camel@monkey>
	<20020312.093134.35196670.davem@redhat.com>
	<1015965269.1937.22.camel@monkey>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Beezly <beezly@beezly.org.uk>
   Date: 12 Mar 2002 20:34:29 +0000
   
   I had a quick fiddle around with pci_find_capability(<blah>,
   PCI_CAP_ID_VPD), but it always returns NULL (i.e. no VPD). However, I've
   also noticed that no-one appears to use that macro in any of the kernel
   source. Is there another way to look at the VPD?

The vital product data is stored in the PCI ROM.
pci_find_capability() does not give you the VPD, it is for
capabilities indicated in PCI config space.

The VPD format in the PCI ROM is specified in the PCI-2.x
specification.  To dump out the PCI ROM you'll need to
ioremap() the PCI_ROM_RESOURCE it just like we do the registers.
Then you have to enable the ROM so it will respond (by setting
PCI_ROM_ADDRESS_ENABLE in "PCI_ROM_ADDRESS" in PCI config space).

Then you can use the ioremap() cookie to read the ROM using
readl(cookie + offset).

