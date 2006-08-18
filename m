Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964938AbWHRXd3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964938AbWHRXd3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 19:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964940AbWHRXd3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 19:33:29 -0400
Received: from ns1.coraid.com ([65.14.39.133]:5484 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S964938AbWHRXd2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 19:33:28 -0400
Date: Fri, 18 Aug 2006 18:23:29 -0400
From: "Ed L. Cashin" <ecashin@coraid.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, Greg K-H <greg@kroah.com>
Subject: Re: [PATCH 2.6.18-rc4] aoe [06/13]: clean up printks via macros
Message-ID: <20060818222328.GS29988@coraid.com>
References: <E1GE8K3-0008Jn-00@kokone.coraid.com> <6dc082092248e90db76de47c0bd5bd6c@coraid.com> <200608182129.46571.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608182129.46571.arnd@arndb.de>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2006 at 09:29:45PM +0200, Arnd Bergmann wrote:
> On Friday 18 August 2006 19:39, Ed L. Cashin wrote:
> > 
> > +#define xprintk(L, fmt, arg...) printk(L "aoe: " "%s: " fmt, __func__, ## arg) 
> > +#define iprintk(fmt, arg...) xprintk(KERN_INFO, fmt, ## arg)
> > +#define eprintk(fmt, arg...) xprintk(KERN_ERR, fmt, ## arg)
> > +#define dprintk(fmt, arg...) xprintk(KERN_DEBUG, fmt, ## arg)
> > +
> 
> Can't you use the dev_{info,error,dbg}() functions instead?

That's a good thought, but I don't think so.  The dev_* macros don't
add the function name to the printed message, and we don't have a
struct device pointer in all our contexts.  Even if we did, it would
be kind of forced to do that just to try to get the prefix "aoe: " and
the function name into the printks, which the new macros do nicely.

-- 
  Ed L Cashin <ecashin@coraid.com>
