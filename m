Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932434AbVHKU0c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932434AbVHKU0c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 16:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932438AbVHKU0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 16:26:32 -0400
Received: from wproxy.gmail.com ([64.233.184.197]:32657 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932434AbVHKU0b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 16:26:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=qT1mvoodvrMWJnDF8b7Ys9q1ypnq4eZ9pg9SRy6CrQ/crlKUSdB3bnixO38X/2a/otOkhTHAVsr7UzXTE7weLQUIbTHr7uVoxKVPeqC3/ZzNZKP7funfLjRv95iv2RUQMHs7m77Na9LHQX8Tx/LSN/1omcpG2FdOYP4GYajAQ8c=
Date: Fri, 12 Aug 2005 00:34:55 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: linux-kernel@vger.kernel.org, James Morris <jmorris@namei.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch][-mm] selinux:  Reduce memory use by avtab
Message-ID: <20050811203455.GA16409@mipter.zuzino.mipt.ru>
References: <1123788744.7810.115.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1123788744.7810.115.camel@moss-spartans.epoch.ncsc.mil>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2005 at 03:32:24PM -0400, Stephen Smalley wrote:
> This patch improves memory use by SELinux by both reducing the avtab
> node size and reducing the number of avtab nodes.

> +int avtab_read_item(void *fp, u32 vers, struct avtab *a,
> +	            int (*insertf)(struct avtab *a, struct avtab_key *k,
> +				   struct avtab_datum *d, void *p),
> +		    void *p)
> +{
> +	u16 buf16[4],

__le16

> +	u32 buf32[7],

__le32

> +		items2 = le32_to_cpu(buf32[0]);

> +	key.source_type = le16_to_cpu(buf16[items++]);

> +static int cond_read_av_list(struct policydb *p, void *fp, struct cond_av_list **ret_list, struct cond_av_list *other)
> +{

> +	u32 buf[1]

__le32

> +	len = le32_to_cpu(buf[0]);

Stephen, "[PATCH] selinux: endian annotations" you ACKed in June is hopelessly
lost or thoroughly queued for inclusion?

