Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751490AbWCZQrW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490AbWCZQrW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 11:47:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751483AbWCZQrV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 11:47:21 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:28865 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751479AbWCZQrU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 11:47:20 -0500
Date: Sun, 26 Mar 2006 22:14:35 +0530
From: Balbir Singh <balbir@in.ibm.com>
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       netdev <netdev@vger.kernel.org>, Jamal <hadi@cyberus.ca>
Subject: Re: [Patch 8/9] generic netlink utility functions
Message-ID: <20060326164434.GC13362@in.ibm.com>
Reply-To: balbir@in.ibm.com
References: <1142296834.5858.3.camel@elinux04.optonline.net> <1142297705.5858.28.camel@elinux04.optonline.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1142297705.5858.28.camel@elinux04.optonline.net>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2006 at 07:55:05PM -0500, Shailabh Nagar wrote:
> genetlink-utils.patch
> 
> Two utilities for simplifying usage of NETLINK_GENERIC
> interface.
> 
> Signed-off-by: Balbir Singh <balbir@in.ibm.com>
> Signed-off-by: Shailabh Nagar <nagar@watson.ibm.com>
> 
>  include/net/genetlink.h |   20 ++++++++++++++++++++
>  1 files changed, 20 insertions(+)
> 
> Index: linux-2.6.16-rc5/include/net/genetlink.h
> ===================================================================
> --- linux-2.6.16-rc5.orig/include/net/genetlink.h	2006-03-11 07:41:32.000000000 -0500
> +++ linux-2.6.16-rc5/include/net/genetlink.h	2006-03-11 07:41:41.000000000 -0500
> @@ -150,4 +150,24 @@ static inline int genlmsg_unicast(struct
>  	return nlmsg_unicast(genl_sock, skb, pid);
>  }
>  
> +/**
> + * gennlmsg_data - head of message payload
> + * @gnlh: genetlink messsage header
> + */
> +static inline void *genlmsg_data(const struct genlmsghdr *gnlh)
> +{
> +       return ((unsigned char *) gnlh + GENL_HDRLEN);
> +}
> +
> +/**
> + * genlmsg_len - length of message payload
> + * @gnlh: genetlink message header
> + */
> +static inline int genlmsg_len(const struct genlmsghdr *gnlh)
> +{
> +       struct nlmsghdr *nlh = (struct nlmsghdr *)((unsigned char *)gnlh -
> +                                                   NLMSG_HDRLEN);
> +       return (nlh->nlmsg_len - GENL_HDRLEN - NLMSG_HDRLEN);
> +}
> +
>  #endif	/* __NET_GENERIC_NETLINK_H */
> 
>

Jamal,

Does the implementation of these utilities look ok? We use genlmsg_data()
in the delay accounting code but not genlmsg_len(), hence it might not
be very well tested (just reviewed).

Thanks,
Balbir 
