Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264611AbTGBVFa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 17:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264643AbTGBVFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 17:05:30 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:34709
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264611AbTGBVFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 17:05:25 -0400
Subject: Re: [RFC] block layer support for DMA IOMMU bypass mode II
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Grant Grundler <grundler@parisc-linux.org>
Cc: Andi Kleen <ak@suse.de>, James Bottomley <James.Bottomley@SteelEye.com>,
       axboe@suse.de, davem@redhat.com, suparna@in.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       alex_williamson@hp.com, bjorn_helgaas@hp.com
In-Reply-To: <20030702165510.GC11739@dsl2.external.hp.com>
References: <1057077975.2135.54.camel@mulgrave>
	 <20030702015701.6007ac26.ak@suse.de>
	 <20030702165510.GC11739@dsl2.external.hp.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1057180598.20318.32.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 02 Jul 2003 22:16:39 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-07-02 at 17:55, Grant Grundler wrote:
> On Wed, Jul 02, 2003 at 01:57:01AM +0200, Andi Kleen wrote:
> > The K8 IOMMU cannot support this virtually contiguous thing. The reason
> > is that there is no guarantee that an entry in a sglist is a multiple
> > of page size.  And the aperture can only map 4K sized chunks, like 
> > a CPU MMU. So e.g. when you have an sglist with multiple 1K entries there is 
> > no way to get them continuous in IOMMU space (short of copying)
> 
> Can two adjacent IOMMU entries be used to map two 1K buffers?
> Assume the 1st buffer ends on a 4k alignment and the next one
> starts on a 4k alignment.

When I played with optimising merging on some 2.4 I2O and aacraid
controller stuff I found two things

1.	We allocate pages in reverse order so most merges cant occur
2.	If you use a 4K fs as most people do now the issue is irrelevant
3.	Almost every 1K mergable was part of the same 4K page anyway

