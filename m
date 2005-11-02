Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965293AbVKBWBH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965293AbVKBWBH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 17:01:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965292AbVKBWBG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 17:01:06 -0500
Received: from [194.90.237.34] ([194.90.237.34]:53219 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S965293AbVKBWBF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 17:01:05 -0500
Date: Thu, 3 Nov 2005 00:03:58 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Roland Dreier <rolandd@cisco.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [PATCH/RFC v2] IB: Add SCSI RDMA Protocol (SRP) initiator
Message-ID: <20051102220358.GA27132@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <52r79y91jz.fsf_-_@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52r79y91jz.fsf_-_@cisco.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Roland!
Quoting Roland Dreier <rolandd@cisco.com>:
> +static int srp_init_qp(struct srp_target_port *target,
> +		       struct ib_qp *qp)
> +{
> +	struct ib_qp_attr *attr;
> +	int ret;
> +
> +	attr = kmalloc(sizeof *attr, GFP_KERNEL);
> +	if (!attr)
> +		return -ENOMEM;
> +
> +	ret = ib_find_cached_pkey(target->srp_host->dev,
> +				  target->srp_host->port,
> +				  be16_to_cpu(target->path.pkey),
> +				  &attr->pkey_index);
> +	if (ret)
> +		return ret;
> +
> +	attr->qp_state        = IB_QPS_INIT;
> +	attr->qp_access_flags = (IB_ACCESS_REMOTE_READ |
> +				    IB_ACCESS_REMOTE_WRITE);
> +	attr->port_num        = target->srp_host->port;
> +
> +	return ib_modify_qp(qp, attr,
> +			    IB_QP_STATE		|
> +			    IB_QP_PKEY_INDEX	|
> +			    IB_QP_ACCESS_FLAGS	|
> +			    IB_QP_PORT);
> +}

This seems to leak sizeof *attr bytes if ib_find_cached_pkey
returns an error.

-- 
MST
