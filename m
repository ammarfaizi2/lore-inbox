Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265464AbRF1BDF>; Wed, 27 Jun 2001 21:03:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265467AbRF1BCz>; Wed, 27 Jun 2001 21:02:55 -0400
Received: from pizda.ninka.net ([216.101.162.242]:30868 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S265464AbRF1BCr>;
	Wed, 27 Jun 2001 21:02:47 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15162.33332.781686.45753@pizda.ninka.net>
Date: Wed, 27 Jun 2001 18:02:44 -0700 (PDT)
To: tom_gall@vnet.ibm.com
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: RFC: Changes for PCI
In-Reply-To: <3B3A64CD.28B72A2A@vnet.ibm.com>
In-Reply-To: <3B3A58FC.2728DAFF@vnet.ibm.com>
	<3B3A5B00.9FF387C9@mandrakesoft.com>
	<3B3A64CD.28B72A2A@vnet.ibm.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Tom Gall writes:
 > Well you have device drivers like the symbios scsi driver for instance that
 > tries to determine if it's seen a card before. It does this by looking at the
 > bus,dev etc numbers...  It's quite reasonable for two different scsi cards to be
 > on the same bus number, same dev number etc yet they are in different PCI
 > domains.
 > 
 > Is this a device driver bug or feature?

As Peter Zaitcev and others have pointed out, they can use simple
pointer comparisons here on the pci_dev struct.

 > Right, one could do that and then all the large machine architectures would have
 > their own implementation for the same problem. That's not necessarily a bad
 > thing, but some commonality I think would be a good thing.

Well, if the claim is that your suggested changes provide this
"commonality", I totally disagree.  Your changes do no more than
provide hooks where no hooks are needed.  The hooks are there,
and are why we have "sysdata" and all the drivers/pci/setup-*.c
buisness.  If ppc64 cannot fit itself into the drivers/pci/setup-*.c
infrastructure, either fix the infrastructure or concede that "our
stuff is too weird to solve with generic code" and do what sparc64
does with driving it's own PCI probing layer.

Later,
David S. Miller
davem@redhat.com
