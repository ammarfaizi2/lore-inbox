Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262397AbTKDQsc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 11:48:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262360AbTKDQsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 11:48:32 -0500
Received: from nat9.steeleye.com ([65.114.3.137]:47366 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262356AbTKDQsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 11:48:31 -0500
Subject: Re: virt_to_page/pci_map_page vs. pci_map_single
From: James Bottomley <James.Bottomley@steeleye.com>
To: Matt Porter <mporter@kernel.crashing.org>
Cc: Jes Sorensen <jes@trained-monkey.org>,
       Jamie Wellnitz <Jamie.Wellnitz@emulex.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20031104093556.A24704@home.com>
References: <1067885332.2076.13.camel@mulgrave>
	<yq0znfcjwh1.fsf@trained-monkey.org>  <20031104093556.A24704@home.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 04 Nov 2003 10:47:25 -0600
Message-Id: <1067964447.1792.116.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-11-04 at 10:35, Matt Porter wrote:
> This raises a question for me regarding these rules in 2.4 versus
> 2.6.  While fixing a bug in PPC's 2.4 pci_map_page/pci_map_sg
> implementations I noticed that a scatterlist created by the IDE
> subsystem will pass nents by page struct reference with a
> size > PAGE_SIZE.  Is this a 2.4ism resulting from allowing both
> address and page reference scatterlist entries?  This isn't
> explicitly mentioned in the DMA docs AFAICT.  I'm wondering
> if this is the same expected behavior in 2.6 as well.  If
> pci_map_page() is limited to size <= PAGE_SIZE then I would
> expect pci_map_sg() to be limited as well (and vice versa).

Not really.  By design, the SG interface can handle entries that are
physically contiguous.

If you have a limit on the length of your SG elements (because of the
device hardware, say), you can express this to the block layer with the
blk_queue_max_segment_size() API.

James

