Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313078AbSDSVr0>; Fri, 19 Apr 2002 17:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313090AbSDSVrZ>; Fri, 19 Apr 2002 17:47:25 -0400
Received: from pizda.ninka.net ([216.101.162.242]:6075 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S313078AbSDSVrY>;
	Fri, 19 Apr 2002 17:47:24 -0400
Date: Fri, 19 Apr 2002 14:38:39 -0700 (PDT)
Message-Id: <20020419.143839.15920500.davem@redhat.com>
To: peterson@austin.ibm.com
Cc: anton@au.ibm.com, paulus@ozlabs.au.ibm.com, mj@suse.cz,
        linux-kernel@vger.kernel.org
Subject: Re: PowerPC Linux and PCI
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3CC08DFF.787F6E54@austin.ibm.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: James L Peterson <peterson@austin.ibm.com>
   Date: Fri, 19 Apr 2002 16:37:03 -0500

   if (pci_read_config_dword(temp, PCI_VENDOR_ID, &l))
     return NULL;
        ....
     memcpy(dev, temp, sizeof(*dev));
    dev->vendor = l & 0xffff;
    dev->device = (l >> 16) & 0xffff;
   
   It seems to me this is incorrect for a big-endian machine
   (like PowerPC).  If we read the two 16-bit parts out of the
   first 32-bit part, we will end up with:

pci_read_config_dword should do the byte swapping on &l for
the caller, fix your pci_{read,write}_config_*() arch implementation.

