Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269116AbUJKPl4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269116AbUJKPl4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 11:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269065AbUJKPlX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 11:41:23 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:41141 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S269129AbUJKPkZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 11:40:25 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Mon, 11 Oct 2004 17:14:55 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Michael Geng <linux@MichaelGeng.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: video_usercopy() enforces change of VideoText IOCTLs since 2.6.8
Message-ID: <20041011151455.GC23632@bytesex>
References: <20041007165410.GA2306@t-online.de> <20041008105219.GA24842@bytesex> <20041008140056.72b177d9.akpm@osdl.org> <20041009092801.GC3482@bytesex> <20041009112839.GA2908@t-online.de> <20041009121845.GE3482@bytesex> <20041010085541.GA1642@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041010085541.GA1642@t-online.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +#define VTXIOCGETINFO	_IOR  (0x81,  1, vtx_info_t)
> +#define VTXIOCCLRPAGE	_IOW  (0x81,  2, vtx_pagereq_t)
> +#define VTXIOCCLRFOUND	_IOW  (0x81,  3, vtx_pagereq_t)
> +#define VTXIOCPAGEREQ	_IOW  (0x81,  4, vtx_pagereq_t)
> +#define VTXIOCGETSTAT	_IOW  (0x81,  5, vtx_pagereq_t)
> +#define VTXIOCGETPAGE	_IOW  (0x81,  6, vtx_pagereq_t)
> +#define VTXIOCSTOPDAU	_IOW  (0x81,  7, vtx_pagereq_t)

Hmm, _IOW for VTXIOCGET* looks bogous, is that really correct?

Note that you often need RW for read/get ioctls because even these
often pass data to the driver as well (for example the vtx page number
you want query the status for).  Please double-check that.  Otherwise
the patch looks ok to me.

  Gerd

-- 
return -ENOSIG;
