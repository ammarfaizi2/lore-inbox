Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267330AbUJNWYm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267330AbUJNWYm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 18:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267986AbUJNWPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 18:15:12 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:38667 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S267374AbUJNWIG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 18:08:06 -0400
Date: Thu, 14 Oct 2004 23:08:02 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: __attribute__((unused))
Message-ID: <20041014230802.C28649@flint.arm.linux.org.uk>
Mail-Followup-To: David Woodhouse <dwmw2@infradead.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20041014220243.B28649@flint.arm.linux.org.uk> <1097791496.5788.2034.camel@baythorne.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1097791496.5788.2034.camel@baythorne.infradead.org>; from dwmw2@infradead.org on Thu, Oct 14, 2004 at 11:04:56PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2004 at 11:04:56PM +0100, David Woodhouse wrote:
> On Thu, 2004-10-14 at 22:02 +0100, Russell King wrote:
> > Hi,
> > 
> > I notice that module.h contains stuff like:
> > 
> > #define MODULE_GENERIC_TABLE(gtype,name)                        \
> > extern const struct gtype##_id __mod_##gtype##_table            \
> >   __attribute__ ((unused, alias(__stringify(name))))
> > 
> > and even:
> > 
> > #define __MODULE_INFO(tag, name, info)                                    \
> > static const char __module_cat(name,__LINE__)[]                           \
> >   __attribute_used__                                                      \
> >   __attribute__((section(".modinfo"),unused)) = __stringify(tag) "=" info
> > 
> > My understanding is that we shouldn't be using __attribute__((unused))
> > in either of these - can someone confirm.
> 
> Since the structure in question isn't explicitly referenced from
> elsewhere, the compiler may feel free to omit it. Since we want the
> compiler to emit it, not omit it, we use "unused" to say "yes, I know it
> looks unused; please emit it anyway". Later compilers use "used" to say
> "I use it really; please emit it anyway", meaning much the same thing.

It's the "later compilers" which I'm worried about here - I think they
defined "unused" to mean "this really really isn't used and you can
discard it".  Hence my concern with the above.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
