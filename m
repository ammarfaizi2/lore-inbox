Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932375AbVJLANW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932375AbVJLANW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 20:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932380AbVJLANW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 20:13:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41100 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932375AbVJLANV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 20:13:21 -0400
Date: Tue, 11 Oct 2005 17:13:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org
Subject: Re: [PATCH] ppc64: Thermal control for SMU based machines
Message-Id: <20051011171315.2fe087e7.akpm@osdl.org>
In-Reply-To: <1128404215.31063.32.camel@gaston>
References: <1128404215.31063.32.camel@gaston>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
> +#define BUILD_SHOW_FUNC_FIX(name, data)				\
> +static ssize_t show_##name(struct device *dev,                  \
> +			   struct device_attribute *attr,       \
> +			   char *buf)	                        \
> +{								\
> +	ssize_t r;						\
> +        s32 val = 0;                                            \
> +        data->ops->get_value(data, &val);                       \
> +	r = sprintf(buf, "%d.%03d", FIX32TOPRINT(val)); 	\
> +	return r;						\
> +}                                                               \
> +static DEVICE_ATTR(name,S_IRUGO,show_##name, NULL);
> +
> +
> +#define BUILD_SHOW_FUNC_INT(name, data)				\
> +static ssize_t show_##name(struct device *dev,                  \
> +			   struct device_attribute *attr,       \
> +			   char *buf)	                        \
> +{								\
> +        s32 val = 0;                                            \
> +        data->ops->get_value(data, &val);                       \
> +	return sprintf(buf, "%d", val);  			\
> +}                                                               \

Someone needs a tab key ;)
