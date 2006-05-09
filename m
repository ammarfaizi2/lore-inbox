Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751283AbWEIQIH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbWEIQIH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 12:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbWEIQIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 12:08:06 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:45896 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751283AbWEIQIF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 12:08:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=A/a0WPaYqnErH7T8RKELku9rHIvgKTTlbi7A8EcLRaA5NVuFgP6gEVsdyrlEYLizzG8F3lM4D5ZP2AshBXIxtVL3ROBi162zRv5GK9kZ3+yPKxfyDX2nGU9ZnorK0exHdIjNUIkpeD8TvzwRtiEPponhNYC325Q7SuHfv6yu15Y=
Date: Tue, 9 May 2006 20:06:35 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: Re: [RFC PATCH 33/35] Add the Xenbus sysfs and virtual device hotplug driver.
Message-ID: <20060509160635.GB7237@mipter.zuzino.mipt.ru>
References: <20060509084945.373541000@sous-sol.org> <20060509085200.826853000@sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060509085200.826853000@sous-sol.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

This should go to lib/

