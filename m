Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273067AbTG3RVM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 13:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273070AbTG3RVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 13:21:12 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:53508 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S273067AbTG3RVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 13:21:11 -0400
Subject: Re: [RFC] block layer support for DMA IOMMU bypass mode II
From: James Bottomley <James.Bottomley@steeleye.com>
To: Andi Kleen <ak@suse.de>
Cc: Grant Grundler <grundler@parisc-linux.org>,
       "David S. Miller" <davem@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Jens Axboe <axboe@suse.de>,
       suparna@in.ibm.com, Linux Kernel <linux-kernel@vger.kernel.org>,
       alex_williamson@hp.com, bjorn_helgaas@hp.com
In-Reply-To: <20030730163615.GD17201@wotan.suse.de>
References: <20030708213427.39de0195.ak@suse.de>
	<20030708.150433.104048841.davem@redhat.com>
	<20030708222545.GC6787@dsl2.external.hp.com>
	<20030708.152314.115928676.davem@redhat.com>
	<20030723114006.GA28688@dsl2.external.hp.com>
	<20030728131513.5d4b1bd3.ak@suse.de>
	<20030730044256.GA1974@dsl2.external.hp.com>
	<20030729215118.13a5ac18.davem@redhat.com>
	<20030730160250.GA16960@dsl2.external.hp.com> 
	<20030730163615.GD17201@wotan.suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 30 Jul 2003 12:18:46 -0500
Message-Id: <1059585657.1850.197.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-07-30 at 11:36, Andi Kleen wrote:
> The differences were greater with the mpt fusion driver, maybe it has
> more overhead. Or your IO subsystem is significantly different.

By and large, these results are more like what I expect.

As I've said before, getting SG tables to work efficiently is a core
part of getting an I/O board to function.

There are two places vmerging can help:

1. Reducing the size of the SG table
2. Increasing the length of the I/O for devices with fixed (but small)
SG table lengths.

However, it's important to remember that vmerging comes virtually for
free in the BIO layer, so the only added cost is the programming of the
IOMMU.  This isn't an issue on SPARC, PA-RISC and the like where IOMMU
programming is required to do I/O, it may be something the IOMMU
optional architectures (like IA-64 and AMD-64) should consider, which is
where I entered with the IOMMU bypass patch.

James


