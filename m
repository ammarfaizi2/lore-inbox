Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264531AbUE0Nw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264531AbUE0Nw4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 09:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264561AbUE0Nwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 09:52:54 -0400
Received: from [213.146.154.40] ([213.146.154.40]:61607 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S264531AbUE0Nvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 09:51:35 -0400
Date: Thu, 27 May 2004 14:51:34 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Takao Indoh <indou.takao@soft.fujitsu.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [3/4] [PATCH]Diskdump - yet another crash dump function
Message-ID: <20040527135134.GC15356@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Takao Indoh <indou.takao@soft.fujitsu.com>,
	linux-kernel@vger.kernel.org
References: <1CC443CDA50AF2indou.takao@soft.fujitsu.com> <1FC443E79D3948indou.takao@soft.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1FC443E79D3948indou.takao@soft.fujitsu.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +/******************************** Disk dump ***********************************/
> +#if defined(CONFIG_DISKDUMP) || defined(CONFIG_DISKDUMP_MODULE)
> +#undef  add_timer
> +#define add_timer       diskdump_add_timer
> +#undef  del_timer_sync
> +#define del_timer_sync  diskdump_del_timer
> +#undef  del_timer
> +#define del_timer       diskdump_del_timer
> +#undef  mod_timer
> +#define mod_timer       diskdump_mod_timer
> +
> +#define tasklet_schedule        diskdump_tasklet_schedule
> +#endif

Yikes.  No way in hell we'll place code like this in drivers.  This needs
to be handled in common code.

