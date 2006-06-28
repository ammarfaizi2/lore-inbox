Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030383AbWF1RKc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030383AbWF1RKc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 13:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030361AbWF1RKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 13:10:31 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:26282 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1422669AbWF1RK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 13:10:29 -0400
Date: Wed, 28 Jun 2006 18:10:27 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Li Yang-r58472 <LeoLi@freescale.com>
Cc: "'Paul Mackerras'" <paulus@samba.org>, linuxppc-dev@ozlabs.org,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       Chu hanjin-r52514 <Hanjin.Chu@freescale.com>,
       Gridish Shlomi-RM96313 <gridish@freescale.com>,
       Phillips Kim-R1AAHA <Kim.Phillips@freescale.com>
Subject: Re: [PATCH 4/7] powerpc: Add QE library qe_lib--ucc support
Message-ID: <20060628171027.GC7162@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Li Yang-r58472 <LeoLi@freescale.com>,
	'Paul Mackerras' <paulus@samba.org>, linuxppc-dev@ozlabs.org,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
	Chu hanjin-r52514 <Hanjin.Chu@freescale.com>,
	Gridish Shlomi-RM96313 <gridish@freescale.com>,
	Phillips Kim-R1AAHA <Kim.Phillips@freescale.com>
References: <9FCDBA58F226D911B202000BDBAD467306E04FD5@zch01exm40.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9FCDBA58F226D911B202000BDBAD467306E04FD5@zch01exm40.ap.freescale.net>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +int ucc_set_qe_mux_mii_mng(int ucc_num)
> +{
> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> +	out_be32(&qe_immr->qmx.cmxgcr,
> +		 ((in_be32(&qe_immr->qmx.cmxgcr) &
> +		   ~QE_CMXGCR_MII_ENET_MNG) |
> +		  (ucc_num << QE_CMXGCR_MII_ENET_MNG_SHIFT)));
> +	local_irq_restore(flags);

Using local_irq_save to protect hardware access is wrong.  Please use
spinlocks.

