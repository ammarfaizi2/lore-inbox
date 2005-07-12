Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262452AbVGLXBo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262452AbVGLXBo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 19:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262448AbVGLW7M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 18:59:12 -0400
Received: from mailgw.voltaire.com ([212.143.27.70]:6883 "EHLO
	mailgw.voltaire.com") by vger.kernel.org with ESMTP id S262465AbVGLW64
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 18:58:56 -0400
Subject: Re: [PATCH 0/29v2] InfiniBand core update
From: Hal Rosenstock <halr@voltaire.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org, rolandd@cisco.com
In-Reply-To: <20050712153859.7b757c4a.akpm@osdl.org>
References: <1121110249.4389.4984.camel@hal.voltaire.com>
	 <20050711170548.31605e23.akpm@osdl.org>
	 <1121136330.4389.5093.camel@hal.voltaire.com>
	 <20050711201117.72539977.akpm@osdl.org>
	 <1121206549.4382.10.camel@hal.voltaire.com>
	 <20050712153859.7b757c4a.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1121208717.4382.61.camel@hal.voltaire.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 12 Jul 2005 18:51:58 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-07-12 at 18:38, Andrew Morton wrote:
> OK, well the timing of a merge is mainly up to you guys, especially as the
> subsystem is pretty raw and you're the only people who use it ;)
> 
> Two things from a quick scan:
> 
> a) In many places the patch does
> 
> 	if (p)
> 		kfree(p);
> 
>    But kfree(0) is permitted.  The cleanup police will be after you at
>    some stage - it'd be best to fix those things up immediately.

I'll/We'll work on eradicating these and pushing a patch for this
upstream.

> b) The patch exports a ton of symbols to non-GPL modules:
> 
> +EXPORT_SYMBOL(ib_create_ah_from_wc);
> +EXPORT_SYMBOL(ib_modify_mad);
> +EXPORT_SYMBOL(ib_create_send_mad);
> +EXPORT_SYMBOL(ib_free_send_mad);
> +EXPORT_SYMBOL(ib_coalesce_recv_mad);
> +EXPORT_SYMBOL(ib_sa_service_rec_query);
> +EXPORT_SYMBOL(ib_create_cm_id);
> +EXPORT_SYMBOL(ib_destroy_cm_id);
> +EXPORT_SYMBOL(ib_cm_listen);
> +EXPORT_SYMBOL(ib_send_cm_req);
> +EXPORT_SYMBOL(ib_send_cm_rep);
> +EXPORT_SYMBOL(ib_send_cm_rtu);
> +EXPORT_SYMBOL(ib_send_cm_dreq);
> +EXPORT_SYMBOL(ib_send_cm_drep);
> +EXPORT_SYMBOL(ib_send_cm_rej);
> +EXPORT_SYMBOL(ib_send_cm_mra);
> +EXPORT_SYMBOL(ib_send_cm_lap);
> +EXPORT_SYMBOL(ib_send_cm_apr);
> +EXPORT_SYMBOL(ib_send_cm_sidr_req);
> +EXPORT_SYMBOL(ib_send_cm_sidr_rep);
> +EXPORT_SYMBOL(ib_cm_establish);
> +EXPORT_SYMBOL(ib_cm_init_qp_attr);
> 
>    Why?

I think that is because OpenIB has a dual GPL/BSD license.

-- Hal

