Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265256AbTGHTdJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 15:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265257AbTGHTdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 15:33:09 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:29077
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S265256AbTGHTdH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 15:33:07 -0400
Date: Tue, 8 Jul 2003 15:47:44 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Andi Kleen <ak@suse.de>
Cc: "David S. Miller" <davem@redhat.com>, alan@lxorguk.ukuu.org.uk,
       grundler@parisc-linux.org, James.Bottomley@SteelEye.com, axboe@suse.de,
       suparna@in.ibm.com, linux-kernel@vger.kernel.org,
       alex_williamson@hp.com, bjorn_helgaas@hp.com
Subject: Re: [RFC] block layer support for DMA IOMMU bypass mode II
Message-ID: <20030708194744.GD17115@gtf.org>
References: <20030702235619.GA21567@wotan.suse.de> <1057263988.21508.18.camel@dhcp22.swansea.linux.org.uk> <20030703212415.GA30277@wotan.suse.de> <20030707.191438.71104854.davem@redhat.com> <20030708213427.39de0195.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030708213427.39de0195.ak@suse.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 08, 2003 at 09:34:27PM +0200, Andi Kleen wrote:
> Overflow is typically deadly because the API does not allow proper
> error handling and most drivers don't check for it. That's especially
> risky for block devices: while pci_map_sg can at least return an error
> not everybody checks for it and when you get an overflow the next
> super block write with such an unchecked error will destroy the file 
> system.

Personally, I've always thought we were kidding ourselves by not doing
the error checking you describe.  From my somewhat-narrow perspective of
network drivers and the libata storage driver, you have to deal with
atomic allocations _anyway_ ...  so why not make sure IOMMU overflow
properly fails at the pci_map_foo level?

	Jeff



