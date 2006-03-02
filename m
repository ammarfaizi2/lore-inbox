Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752023AbWCBRWX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752023AbWCBRWX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 12:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752027AbWCBRWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 12:22:23 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:35249 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751593AbWCBRWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 12:22:21 -0500
Subject: Re: Question: how to map SCSI data DMA address to virtual address?
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: "Ju, Seokmann" <Seokmann.Ju@lsil.com>,
       "Ju, Seokmann" <Seokmann.Ju@engenio.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
In-Reply-To: <20060302170915.GA31316@infradead.org>
References: <9738BCBE884FDB42801FAD8A7769C2651420C1@NAMAIL1.ad.lsil.com>
	 <20060302170915.GA31316@infradead.org>
Content-Type: text/plain
Date: Thu, 02 Mar 2006 11:22:12 -0600
Message-Id: <1141320132.3238.20.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-02 at 17:09 +0000, Christoph Hellwig wrote:
> For each sg list entry do something like:
> 
> 	buffer = kmap_atomic(sg->page, KM_USER0) + sg->offset;
> 	<access buffer>
> 	kunmap_atomic(buffer - sg->offset, KM_USER0);

Remember too that the data might not necessarily be valid without a
flush depending on where it has come from (or where it is going).  See
the dma_sync_sg_for_device/cpu.

James


