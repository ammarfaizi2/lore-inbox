Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265705AbSL1Uzr>; Sat, 28 Dec 2002 15:55:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265713AbSL1Uzr>; Sat, 28 Dec 2002 15:55:47 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:63244 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S265705AbSL1Uzp>; Sat, 28 Dec 2002 15:55:45 -0500
Date: Sat, 28 Dec 2002 14:02:17 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: James Bottomley <James.Bottomley@steeleye.com>
cc: Rik van Riel <riel@conectiva.com.br>, Tomas Szepe <szepe@pinerecords.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Samuel Flory <sflory@rackable.com>, Janet Morgan <janetmor@us.ibm.com>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] aic7xxx bouncing over 4G 
Message-ID: <775808112.1041109337@aslan.scsiguy.com>
In-Reply-To: <200212282016.gBSKGrF03354@localhost.localdomain>
References: <200212282016.gBSKGrF03354@localhost.localdomain>
X-Mailer: Mulberry/3.0.0b9 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> gibbs@scsiguy.com said:
>> That hasn't applied since 6.2.10 or so.  2.5.X is still using 6.2.4. 
> 
> The bug report is against 2.5.53 which has 6.2.24 in it, so it still
> needs  fixing.  At a cursory glance at the code, it looks like you don't
> call  scsi_set_pci_device early enough in the detect routine.

I don't see how this enters into it.  The dma mask should be set on
the PCI device in aic7xxx_osm_pci.c just after we enable the device
and set it as a bus master.  The pci device is setup in the host
structure as it is allocated and before it is registered with the
SCSI subsystem.  I can't imagine that the merge function (and thereby
the bounce limit) is selected before the host is even registered.
My guess is that the original call to setup the PCI mask is not happening
due to either a logic bug in ahc_linux_get_memsize() or the logic that
interprets its response in aic7xxx_osm_pci.c.

I'm not in front of a Linux system to debug this, so all I can do is
inspect the code right now.  Perhaps someone with an affected machine
can toss in a few printks and figure this out?

--
Justin

