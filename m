Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314057AbSEIRwl>; Thu, 9 May 2002 13:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314061AbSEIRwk>; Thu, 9 May 2002 13:52:40 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:2825 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S314057AbSEIRwj>;
	Thu, 9 May 2002 13:52:39 -0400
Date: Thu, 9 May 2002 09:52:34 -0700
From: Greg KH <greg@kroah.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: James Bottomley <James.Bottomley@steeleye.com>, mochel@osdl.org,
        linux-kernel@vger.kernel.org
Subject: [BK PATCH] PCI reorg fix
Message-ID: <20020509165234.GA17627@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200205091647.g49GlkG02757@localhost.localdomain>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Thu, 11 Apr 2002 15:09:41 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

James pointed out that pci_alloc_consistent() and pci_free_consistent()
are allowed to be called, even if CONFIG_PCI is not enabled.  So this
changeset moves these calls back into the arch/i386/kernel directory.

Pull from:  bk://linuxusb.bkbits.net/linux-2.5-pci

As a side note, I don't think that any pci_* function should be able to
be called by non-pci drivers.  Is it worth spending the time now in 2.5
to make these two functions not rely on 'struct pci_dev' and fix up all
of the drivers and architectures and documentation to reflect this?
Possible names would be alloc_consistent() and free_consistent()?

thanks,

greg k-h



ChangeSet@1.557, 2002-05-09 10:35:57-07:00, greg@kroah.com
  moved the pci_alloc_consistent() and pci_free_consistent() functions back
  into arch/i386/kernel as they are needed even if CONFIG_PCI is not enabled.

 arch/i386/pci/dma.c        |   37 -------------------------------------
 arch/i386/kernel/Makefile  |    2 +-
 arch/i386/kernel/pci-dma.c |   37 +++++++++++++++++++++++++++++++++++++
 arch/i386/pci/Makefile     |    2 +-
 4 files changed, 39 insertions(+), 39 deletions(-)

