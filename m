Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264197AbTGBRXM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 13:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264201AbTGBRXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 13:23:11 -0400
Received: from dsl2.external.hp.com ([192.25.206.7]:53765 "EHLO
	dsl2.external.hp.com") by vger.kernel.org with ESMTP
	id S264197AbTGBRXI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 13:23:08 -0400
Date: Wed, 2 Jul 2003 11:37:33 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: Andi Kleen <ak@suse.de>
Cc: Grant Grundler <grundler@parisc-linux.org>,
       James Bottomley <James.Bottomley@steeleye.com>, axboe@suse.de,
       davem@redhat.com, suparna@in.ibm.com, linux-kernel@vger.kernel.org,
       alex_williamson@hp.com, bjorn_helgaas@hp.com
Subject: Re: [RFC] block layer support for DMA IOMMU bypass mode II
Message-ID: <20030702173733.GE11739@dsl2.external.hp.com>
References: <1057077975.2135.54.camel@mulgrave> <20030702015701.6007ac26.ak@suse.de> <20030702165510.GC11739@dsl2.external.hp.com> <20030702172026.GB32261@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030702172026.GB32261@wotan.suse.de>
User-Agent: Mutt/1.3.28i
X-Home-Page: http://www.parisc-linux.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 02, 2003 at 07:20:26PM +0200, Andi Kleen wrote:
...
> > Can two adjacent IOMMU entries be used to map two 1K buffers?
> > Assume the 1st buffer ends on a 4k alignment and the next one
> > starts on a 4k alignment.
> 
> Yes, it could. But is that situation likely/worth to handle? 

Probably.  It would reduce the number of mappings by 25% (3 instead of 4).
My assumption is two adjecent IOMMU entries have contigious bus addresses.

I was trying to figure out if x86-64 should be setting
BIO_VMERGE_BOUNDARY to 0 or 4k.

It sounds like x86-64 could support "#define BIO_VMERGE_BOUNDARY 4096"
if the IOMMU code will return one DMA address for two SG list entries
in the above example.

hth,
grant
