Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030235AbWAGAew@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030235AbWAGAew (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 19:34:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030237AbWAGAew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 19:34:52 -0500
Received: from waste.org ([64.81.244.121]:44418 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1030235AbWAGAev (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 19:34:51 -0500
Date: Fri, 6 Jan 2006 18:28:18 -0600
From: Matt Mackall <mpm@selenic.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
Subject: Re: [patch 5/7]  uninline capable()
Message-ID: <20060107002818.GB23554@waste.org>
References: <1136543825.2940.8.camel@laptopd505.fenrus.org> <1136544160.2940.20.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1136544160.2940.20.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2006 at 11:42:40AM +0100, Arjan van de Ven wrote:
> Subject: uninline capable()
> From: Ingo Molnar <mingo@elte.hu>
> 
> uninline capable(). Saves 2K of kernel text on a generic .config, and 1K
> on a tiny config. In addition it makes the use of capable more consistent
> between CONFIG_SECURITY and !CONFIG_SECURITY
> 
> Signed-off-by: Ingo Molnar <mingo@elte.hu>

You forgot your sign-off.

> +#ifndef CONFIG_SECURITY
> +int capable(int cap)
> +{
> +        if (cap_raised(current->cap_effective, cap)) {
> +	       current->flags |= PF_SUPERPRIV;
> +	       return 1;

Tabs, please. 

> +        }
> +        return 0;
> +}
> +EXPORT_SYMBOL(capable);
> +#endif
> +

Also, I wonder if kernel/sys.c is really the best place for this. I'd
think security/std.c or the like would be preferable.

-- 
Mathematics is the supreme nostalgia of our time.
