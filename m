Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965165AbWEaV0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965165AbWEaV0r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 17:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965163AbWEaV0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 17:26:47 -0400
Received: from fmr18.intel.com ([134.134.136.17]:40098 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S965161AbWEaV0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 17:26:45 -0400
Message-ID: <447E0A12.5090209@ichips.intel.com>
Date: Wed, 31 May 2006 14:26:42 -0700
From: Sean Hefty <mshefty@ichips.intel.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steve Wise <swise@opengridcomputing.com>
CC: rdreier@cisco.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [PATCH 2/2] iWARP Core Changes.
References: <20060531182650.3308.81538.stgit@stevo-desktop> <20060531182654.3308.41372.stgit@stevo-desktop>
In-Reply-To: <20060531182654.3308.41372.stgit@stevo-desktop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mainly nits...

Steve Wise wrote:
> -static int copy_addr(struct rdma_dev_addr *dev_addr, struct net_device *dev,
> +int copy_addr(struct rdma_dev_addr *dev_addr, struct net_device *dev,
>  		     unsigned char *dst_dev_addr)

Might want to rename this to something like rdma_copy_addr if you're going to 
export it.

> +static int cma_iw_handler(struct iw_cm_id *iw_id, struct iw_cm_event *iw_event)
> +{
> +	struct rdma_id_private *id_priv = iw_id->context;
> +	enum rdma_cm_event_type event = 0;
> +	struct sockaddr_in *sin;
> +	int ret = 0;
> +
> +	atomic_inc(&id_priv->dev_remove);
> +
> +	switch (iw_event->event) {
> +	case IW_CM_EVENT_CLOSE:
> +		event = RDMA_CM_EVENT_DISCONNECTED;
> +		break;
> +	case IW_CM_EVENT_CONNECT_REPLY:
> +		sin = (struct sockaddr_in*)&id_priv->id.route.addr.src_addr;
> +		*sin = iw_event->local_addr;
> +		sin = (struct sockaddr_in*)&id_priv->id.route.addr.dst_addr;

spacing nit - (struct sockaddr_in *) &id_priv->...

> +struct net_device *ip_dev_find(u32 ip);

Just include header file with definition.

> +	sin = (struct sockaddr_in*)&new_cm_id->route.addr.src_addr;
> +	*sin = iw_event->local_addr;
> +	sin = (struct sockaddr_in*)&new_cm_id->route.addr.dst_addr;

same spacing nit...  appears in a couple other places as well.

> +static inline union ib_gid* iw_addr_get_sgid(struct rdma_dev_addr* rda)
> +{
> +	return (union ib_gid*)rda->src_dev_addr;
> +}
> +
> +static inline union ib_gid* iw_addr_get_dgid(struct rdma_dev_addr* rda)
> +{
> +	return (union ib_gid*)rda->dst_dev_addr;
> +}

spacing nits

> +struct iw_cm_verbs;
>  struct ib_device {
>  	struct device                *dma_device;
>  
> @@ -846,6 +873,8 @@ struct ib_device {
>  
>  	u32                           flags;
>  
> +	struct iw_cm_verbs*           iwcm;
> +

'*' placement nit

- Sean
