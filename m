Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264178AbTGBQjL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 12:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264192AbTGBQjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 12:39:11 -0400
Received: from dsl2.external.hp.com ([192.25.206.7]:37125 "EHLO
	dsl2.external.hp.com") by vger.kernel.org with ESMTP
	id S264178AbTGBQjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 12:39:09 -0400
Date: Wed, 2 Jul 2003 10:53:33 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: Andi Kleen <ak@suse.de>
Cc: "David S. Miller" <davem@redhat.com>, James.Bottomley@steeleye.com,
       axboe@suse.de, suparna@in.ibm.com, linux-kernel@vger.kernel.org,
       alex_williamson@hp.com, bjorn_helgaas@hp.com
Subject: Re: [RFC] block layer support for DMA IOMMU bypass mode II
Message-ID: <20030702165333.GB11739@dsl2.external.hp.com>
References: <1057077975.2135.54.camel@mulgrave> <20030702015701.6007ac26.ak@suse.de> <20030701.170323.59686965.davem@redhat.com> <20030702022244.030a8acc.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030702022244.030a8acc.ak@suse.de>
User-Agent: Mutt/1.3.28i
X-Home-Page: http://www.parisc-linux.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 02, 2003 at 02:22:44AM +0200, Andi Kleen wrote:
> > What do you mean?  You map only one 4K chunk, and this is used
> > for all the sub-1K mappings.
> 
> How should this work when the 1K mappings are spread all over memory?

It couldn't merge in this case.

> Maybe I'm missing something but from James description it sounds like the 
> block layer assumes that it can pass in a sglist with arbitary elements 
> and get it back remapped to continuous DMA addresses.

In the x86-64 case, If the 1k elements are not physically contigous,
I think most of them would get their own mapping.

For x86-64, if an entry ends on a 4k alignment and the next one starts
on a 4k alignment, could those be merged into one DMA segment that uses
two adjacent mapping entries?

Anyway, using a 4k FS block size (eg ext2) would be more efficient
by allowing a 1:1 of SG elements and DMA mappings.

grant

