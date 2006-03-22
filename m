Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751120AbWCVIx0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbWCVIx0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 03:53:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbWCVIx0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 03:53:26 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:55263 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751120AbWCVIxZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 03:53:25 -0500
Subject: Re: [RFC PATCH 33/35] Add the Xenbus sysfs and virtual device
	hotplug driver.
From: Arjan van de Ven <arjan@infradead.org>
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xensource.com,
       virtualization@lists.osdl.org, Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
In-Reply-To: <20060322063807.597300000@sorel.sous-sol.org>
References: <20060322063040.960068000@sorel.sous-sol.org>
	 <20060322063807.597300000@sorel.sous-sol.org>
Content-Type: text/plain
Date: Wed, 22 Mar 2006 09:53:20 +0100
Message-Id: <1143017601.2955.33.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +
> +extern struct semaphore xenwatch_mutex;

you know, there is this thing called "struct mutex", please use that
instead; don't add new deprecated semaphore's when using them as mutex


> +#define streq(a, b) (strcmp((a), (b)) == 0)

ehhh why?


> +EXPORT_SYMBOL(xenbus_register_frontend);

please consider _GPL


> +static void xenbus_dev_free(struct xenbus_device *xendev)
> +{
> +	kfree(xendev);
> +}

why this wrapper ?

> +
> +/* Simplified asprintf. */
> +char *kasprintf(const char *fmt, ...)
> +{
> +	va_list ap;
> +	unsigned int len;
> +	char *p, dummy[1];
> +
> +	va_start(ap, fmt);
> +	/* FIXME: vsnprintf has a bug, NULL should work */
> +	len = vsnprintf(dummy, 0, fmt, ap);
> +	va_end(ap);
> +
> +	p = kmalloc(len + 1, GFP_KERNEL);
> +	if (!p)
> +		return NULL;
> +	va_start(ap, fmt);
> +	vsprintf(p, fmt, ap);
> +	va_end(ap);
> +	return p;
> +}

this should take a gfp mask most likely



> +
> +		/* We don't refcnt properly, so set reserved on page.
> +		 * (this allocation is permanent) */
> +		SetPageReserved(virt_to_page(page));

you may want to reconsider this given the "recent" vm changes


> +	down(&xs_state.request_mutex);

please use a real mutex instead



