Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030459AbWFJRr6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030459AbWFJRr6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 13:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030461AbWFJRr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 13:47:58 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:30085 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030459AbWFJRr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 13:47:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=VhDi/Zl2TtaV6SGqgaYYM3yzSjaY4uVg+w98zKLwg0VTQxk/3QDN2UFuicjqWyhCl00c1WegSc4t97MGLMBQN8s4F0QDA/X0lXFHnHQBN4CIOzc8kGIbUHP+cjtn8TyPd+84FHoDZte8Zc2WggijtvuFHMcKB4zWlxznq9s6FBg=
Date: Sat, 10 Jun 2006 21:47:57 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@osdl.org,
       promise_linux@promise.com
Subject: Re: [PATCH] Promise 'stex' driver
Message-ID: <20060610174757.GB7268@martell.zuzino.mipt.ru>
References: <20060610160852.GA15316@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060610160852.GA15316@havoc.gtf.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 10, 2006 at 12:08:52PM -0400, Jeff Garzik wrote:
> --- /dev/null
> +++ b/drivers/scsi/stex.c

> +static inline void stex_gettime(u32 *time)

__le32 *time

> +{
> +	struct timeval tv;
> +	do_gettimeofday(&tv);
> +
> +	*time = cpu_to_le32(tv.tv_sec & 0xffffffff);
> +	*(time + 1) = cpu_to_le32((tv.tv_sec >> 16) >> 16);
> +}

> +static void
> +stex_send_cmd(struct st_hba *hba, struct req_msg *req, u16 tag)
> +{
> +	req->tag = cpu_to_le16(tag);
> +	req->task_attr = TASK_ATTRIBUTE_SIMPLE;
> +	req->task_manage = 0; /* not supported yet */
> +	req->payload_sz = (u8)(sizeof(struct req_msg)/sizeof(u32));

sparse warns here. Is this OK?

drivers/scsi/stex.c:442:47: warning: cast truncates bits from constant value (106 becomes 6)

