Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272929AbTG3O0l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 10:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272914AbTG3OXT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 10:23:19 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:38663 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S272894AbTG3OVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 10:21:17 -0400
Subject: Re: [RFC] block layer support for DMA IOMMU bypass mode II
From: James Bottomley <James.Bottomley@steeleye.com>
To: Grant Grundler <grundler@parisc-linux.org>
Cc: Andi Kleen <ak@suse.de>, davem@redhat.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Jens Axboe <axboe@suse.de>,
       suparna@in.ibm.com, Linux Kernel <linux-kernel@vger.kernel.org>,
       alex_williamson@hp.com, bjorn_helgaas@hp.com
In-Reply-To: <20030730044256.GA1974@dsl2.external.hp.com>
References: <20030708213427.39de0195.ak@suse.de>
	<20030708.150433.104048841.davem@redhat.com>
	<20030708222545.GC6787@dsl2.external.hp.com>
	<20030708.152314.115928676.davem@redhat.com>
	<20030723114006.GA28688@dsl2.external.hp.com>
	<20030728131513.5d4b1bd3.ak@suse.de> 
	<20030730044256.GA1974@dsl2.external.hp.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 30 Jul 2003 09:20:52 -0500
Message-Id: <1059574857.1849.7.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-07-29 at 23:42, Grant Grundler wrote:
> On Mon, Jul 28, 2003 at 01:15:13PM +0200, Andi Kleen wrote:
> > Run it with 100-500 users (reaim -f workfile... -s 100 -e 500 -i 100) 
> 
> jejb was wondering if 4k pages would cause different behaviors becuase
> of file system vs page size (4k vs 16k).  ia64 uses 16k by default.
> I've rebuilt the kernel with 4k page size and VMERGE != 0.
> The substantially worse performance feels like a rat hole because
> of 4x pressure on CPU TLB.

OK, I admit it, it was a rat hole.  Provided reaim uses large files, we
should only get block<->page fragmentation at the edges, and obviously,
reaim has to use large files otherwise it's not testing the virtual
merging properly...

James


