Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbWEIQ26@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbWEIQ26 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 12:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbWEIQ26
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 12:28:58 -0400
Received: from ns.suse.de ([195.135.220.2]:7327 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750702AbWEIQ25 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 12:28:57 -0400
From: Andi Kleen <ak@suse.de>
To: virtualization@lists.osdl.org
Subject: Re: [RFC PATCH 33/35] Add the Xenbus sysfs and virtual device hotplug driver.
Date: Tue, 9 May 2006 18:28:31 +0200
User-Agent: KMail/1.9.1
Cc: Alexey Dobriyan <adobriyan@gmail.com>, Chris Wright <chrisw@sous-sol.org>,
       xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org,
       Ian Pratt <ian.pratt@xensource.com>
References: <20060509084945.373541000@sous-sol.org> <20060509085200.826853000@sous-sol.org> <20060509160635.GB7237@mipter.zuzino.mipt.ru>
In-Reply-To: <20060509160635.GB7237@mipter.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605091828.31686.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 May 2006 18:06, Alexey Dobriyan wrote:
> > +/* Simplified asprintf. */
> > +char *kasprintf(const char *fmt, ...)
> > +{
> > +	va_list ap;
> > +	unsigned int len;
> > +	char *p, dummy[1];
> > +
> > +	va_start(ap, fmt);
> > +	/* FIXME: vsnprintf has a bug, NULL should work */
> > +	len = vsnprintf(dummy, 0, fmt, ap);
> > +	va_end(ap);
> > +
> > +	p = kmalloc(len + 1, GFP_KERNEL);
> > +	if (!p)
> > +		return NULL;
> > +	va_start(ap, fmt);
> > +	vsprintf(p, fmt, ap);
> > +	va_end(ap);
> > +	return p;
> > +}
> 
> This should go to lib/

First for kernel usage I think it should have a maximum length parameter
to avoid dumb code from being easily exploited.

And the bug should be fixed in vsnprintf instead of being worked
around.

-Andi
