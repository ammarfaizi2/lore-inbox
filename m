Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262283AbTKRJqy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 04:46:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262129AbTKRJqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 04:46:54 -0500
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:32775 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262283AbTKRJqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 04:46:53 -0500
Date: Tue, 18 Nov 2003 09:46:52 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: DMA_NONE data_direction in scsi
Message-ID: <20031118094651.A14904@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0311172013230.2258-100000@poirot.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0311172013230.2258-100000@poirot.grange>; from g.liakhovetski@gmx.de on Mon, Nov 17, 2003 at 08:25:19PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 17, 2003 at 08:25:19PM +0100, Guennadi Liakhovetski wrote:
> While trying to fix tmscsim for 2.6, I've arrived at the Oops below, which
> is caused by the BUG_ON() in dma_map_page(). In the backtrace below,
> data_direction is set to DMA_BIDIRECTIONAL in sd_revalidate_disk(),
> 
>                 sreq->sr_data_direction = DMA_BIDIRECTIONAL;
> 
> , but already in sd_spinup_disk() it is reset to DMA_NONE:
> 
>                         SRpnt->sr_data_direction = DMA_NONE;
> 
> So, the question is: is this the correct behaviour, and, if so - how is
> the driver supposed to map this request - which direction to pass to
> dma_map_*?

DMA_NONE means there's nothing to map.

