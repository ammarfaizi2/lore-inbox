Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752020AbWCBRJU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752020AbWCBRJU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 12:09:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752018AbWCBRJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 12:09:20 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:58311 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1752017AbWCBRJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 12:09:19 -0500
Date: Thu, 2 Mar 2006 17:09:15 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "Ju, Seokmann" <Seokmann.Ju@lsil.com>
Cc: "Ju, Seokmann" <Seokmann.Ju@engenio.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: Question: how to map SCSI data DMA address to virtual address?
Message-ID: <20060302170915.GA31316@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Ju, Seokmann" <Seokmann.Ju@lsil.com>,
	"Ju, Seokmann" <Seokmann.Ju@engenio.com>,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <9738BCBE884FDB42801FAD8A7769C2651420C1@NAMAIL1.ad.lsil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9738BCBE884FDB42801FAD8A7769C2651420C1@NAMAIL1.ad.lsil.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2006 at 09:53:06AM -0700, Ju, Seokmann wrote:
> Hi,
> 
> In the 'scsi_cmnd' structure, there are two entries holding address
> information for data to be transferred. One is 'request_buffer' and the
> other one is 'buffer'.
> In case of 'use_sg' is non-zero, those entries indicates the address of
> the scatter-gather table.
> 
> Is there way to get virtual address (so that the data could be accessed
> by the driver) of the actual data in the case of 'use_sg' is non-zero?

For each sg list entry do something like:

	buffer = kmap_atomic(sg->page, KM_USER0) + sg->offset;
	<access buffer>
	kunmap_atomic(buffer - sg->offset, KM_USER0);
