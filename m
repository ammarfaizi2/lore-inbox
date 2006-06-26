Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751264AbWFZUwD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbWFZUwD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 16:52:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751265AbWFZUwD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 16:52:03 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:9376 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751264AbWFZUwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 16:52:00 -0400
Subject: Re: [PATCH] riport LADAR driver
From: Arjan van de Ven <arjan@infradead.org>
To: mgross@linux.intel.com
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org,
       mark.gross@intel.com
In-Reply-To: <20060626205525.GA13411@linux.intel.com>
References: <20060622144120.GA5215@linux.intel.com>
	 <1151000401.3120.55.camel@laptopd505.fenrus.org>
	 <20060622231604.GA5208@linux.intel.com>
	 <20060622225239.bf0ccab2.rdunlap@xenotime.net>
	 <20060623224654.GA5204@linux.intel.com>
	 <1151146820.3181.22.camel@laptopd505.fenrus.org>
	 <20060626205525.GA13411@linux.intel.com>
Content-Type: text/plain
Date: Mon, 26 Jun 2006 22:51:49 +0200
Message-Id: <1151355109.3185.88.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> +#define RIPORT_DEBUG
> +
> +#undef pr_debug
> +#ifdef RIPORT_DEBUG
> +#  define pr_debug(fmt, args...) printk( KERN_DEBUG "riport: " fmt, ## args)
> +#else	/*  */
> +#  define pr_debug(fmt, args...)
> +#endif	/*  */



ehhhhh that's not what I meant... if you would just remove these 6
lines.. then sure..
> +	if (!request_region(io + ECP_OFFSET, 3, "riport")) {
> +		release_region(io,3);
> +
> +		pr_debug("request_region 0x%X of 3 bytes fails\n", io + ECP_OFFSET );
> +		*presult = -EBUSY;
> +		goto fail_io2;

this is a double release..

> +
> +fail_dev:
> +	release_region(io + ECP_OFFSET,3);
> +fail_io2:
> +	release_region(io,3);

with this.

> +	current->state = TASK_RUNNING;

please use set_current_state() API for this



