Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750831AbWC3Ug5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbWC3Ug5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 15:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbWC3Ug5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 15:36:57 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:58816 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750831AbWC3Ug4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 15:36:56 -0500
Date: Thu, 30 Mar 2006 22:36:33 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: rdreier@cisco.com, linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 12 of 16] ipath - infiniband RC protocol support
Message-ID: <20060330203633.GA29023@elf.ucw.cz>
References: <patchbomb.1143674603@chalcedony.internal.keyresearch.com> <2fe2c58d0de99a067ae1.1143674615@chalcedony.internal.keyresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fe2c58d0de99a067ae1.1143674615@chalcedony.internal.keyresearch.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This is an implementation of the Infiniband RC ("reliable connection")
> protocol.

> +/* cut down ridiculously long IB macro names */
> +#define OP(x) IB_OPCODE_RC_##x

Heh... what about fixing those names in the first place?

> +	/* GRH header size in 32-bit words. */
> +	qp->s_hdrwords += 10;
> +	qp->s_hdr.u.l.grh.version_tclass_flow =
> +		cpu_to_be32((6 << 28) |
> +			    (grh->traffic_class << 20) |
> +			    grh->flow_label);
> +	qp->s_hdr.u.l.grh.paylen =
> +		cpu_to_be16(((qp->s_hdrwords - 12) + nwords +
> +			     SIZE_OF_CRC) << 2);
> +	/* next_hdr is defined by C8-7 in ch. 8.4.1 */
> +	qp->s_hdr.u.l.grh.next_hdr = 0x1B;
> +	qp->s_hdr.u.l.grh.hop_limit = grh->hop_limit;
> +	/* The SGID is 32-bit aligned. */
> +	qp->s_hdr.u.l.grh.sgid.global.subnet_prefix = dev->gid_prefix;
> +	qp->s_hdr.u.l.grh.sgid.global.interface_id =
> +		ipath_layer_get_guid(dev->dd);
> +	qp->s_hdr.u.l.grh.dgid = grh->dgid;

Don't know about you, but it looks like perl code to
me. qp->s_hdr.u.l.grh.next_hdr ?

> +	/* Check for a constructed packet to be sent. */
> +	if (qp->s_hdrwords != 0) {
> +		/*
> +		 * If no PIO bufs are available, return.  An interrupt will
> +		 * call ipath_ib_piobufavail() when one is available.
> +		 */
> +		_VERBS_INFO("h %u %p\n", qp->s_hdrwords, &qp->s_hdr);
> +		_VERBS_INFO("d %u %p %u %p %u %u %u %u\n",  qp->s_cur_size,

Info on verbs, or verbose info? Why does it start with _ ? What is
wrong with printk?
								Pavel
-- 
Picture of sleeping (Linux) penguin wanted...
