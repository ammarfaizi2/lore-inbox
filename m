Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932476AbWCXMJQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932476AbWCXMJQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 07:09:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932503AbWCXMJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 07:09:15 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:16277 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932476AbWCXMJP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 07:09:15 -0500
Subject: Re: [RFC][PATCH 3/10] 64 bit resources drivers ide changes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: vgoyal@in.ibm.com
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Morton Andrew Morton <akpm@osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>, galak@kernel.crashing.org,
       gregkh@suse.de, bcrl@kvack.org, Dave Jiang <dave.jiang@gmail.com>,
       arjan@infradead.org, Maneesh Soni <maneesh@in.ibm.com>,
       Murali <muralim@in.ibm.com>
In-Reply-To: <20060323200227.GG7175@in.ibm.com>
References: <20060323195752.GD7175@in.ibm.com>
	 <20060323195944.GE7175@in.ibm.com> <20060323200119.GF7175@in.ibm.com>
	 <20060323200227.GG7175@in.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 24 Mar 2006 12:15:01 +0000
Message-Id: <1143202502.18986.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2006-03-23 at 15:02 -0500, Vivek Goyal wrote:
>  		pci_write_config_dword(dev, PCI_ROM_ADDRESS, dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);
> -		printk(KERN_INFO "%s: ROM enabled at 0x%08lx\n", name, dev->resource[PCI_ROM_RESOURCE].start);
> +		printk(KERN_INFO "%s: ROM enabled at 0x%016llx\n", name,
> +			(unsigned long long)dev->resource[PCI_ROM_RESOURCE].start);

NAK - if the resource is 64bit then the pci_write_config_dword is also
insufficient. Ditto for each other example.

We actually know the PCI resources for these are 32bit so this change
shouldn't be needed. You might want to stick a (u32) or (unsigned long)
cast in and leave it at that.

As far as I can tell all the ROM whacking code is bogus anyway

