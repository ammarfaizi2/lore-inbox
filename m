Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750721AbWCIRxI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbWCIRxI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 12:53:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750758AbWCIRxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 12:53:08 -0500
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:26236 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1750721AbWCIRxH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 12:53:07 -0500
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: rolandd@cisco.com, gregkh@suse.de, akpm@osdl.org, davem@davemloft.net,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 18 of 20] ipath - kbuild infrastructure
X-Message-Flag: Warning: May contain useful information
References: <ac5354bb50d515de2a5c.1141922831@localhost.localdomain>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 09 Mar 2006 09:53:04 -0800
In-Reply-To: <ac5354bb50d515de2a5c.1141922831@localhost.localdomain> (Bryan O'Sullivan's message of "Thu,  9 Mar 2006 08:47:11 -0800")
Message-ID: <ada4q27ld33.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 09 Mar 2006 17:53:06.0017 (UTC) FILETIME=[51A50510:01C643A2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > +	depends on 64BIT && (PCIEPORTBUS || X86_HT)

Why do you depend on X86_HT?  I think you got confused: the HT stands
for hyperthreading, not hypertransport.  In fact if you compile a
kernel optimized for K8, X86_HT is disabled.

And why do you depend on PCIEPORTBUS?  I don't see you using anything
from the pcie_port_service stuff.

I think the correct thing for you to depend on is just "PCI", and
build your whole driver (both pe800 and ht400) unconditionally.
There's no special hypertransport or generic PCIe support config
that you can test.

 > --- /dev/null	Thu Jan  1 00:00:00 1970 +0000
 > +++ b/drivers/infiniband/hw/ipath/Makefile	Thu Mar  9 08:46:47 2006 -0800

I've been suggesting that new files be called "Kbuild", since Sam has
deprecated the "Makefile" name.

 > +ipath_core-y :=
 > +
 > +ipath_core-y += ipath_copy.o
 > +ipath_core-y += ipath_diag.o
 > +ipath_core-y += ipath_driver.o
 > +ipath_core-y += ipath_file_ops.o
 > +ipath_core-y += ipath_i2c.o
 > +ipath_core-y += ipath_init_chip.o
 > +ipath_core-y += ipath_intr.o
 > +ipath_core-y += ipath_layer.o
 > +ipath_core-y += ipath_sma.o
 > +ipath_core-y += ipath_stats.o
 > +ipath_core-y += ipath_sysfs.o
 > +ipath_core-y += ipath_user_pages.o

This is a very strange style.  I would just put all the ipath_core-y
stuff on one or two lines.

 - R.
