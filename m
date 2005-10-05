Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932582AbVJEJHE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932582AbVJEJHE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 05:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932586AbVJEJHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 05:07:04 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:49417 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932582AbVJEJHC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 05:07:02 -0400
Date: Wed, 5 Oct 2005 10:06:52 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: 7eggert@gmx.de
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, Ben Dooks <ben-linux@fluff.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] release_resource() check for NULL resource
Message-ID: <20051005090652.GC7208@flint.arm.linux.org.uk>
Mail-Followup-To: 7eggert@gmx.de, Pekka Enberg <penberg@cs.helsinki.fi>,
	Ben Dooks <ben-linux@fluff.org>,
	"Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org
References: <4TfvY-8ix-27@gated-at.bofh.it> <4Tg8u-Bn-15@gated-at.bofh.it> <4Tv7u-5Hd-15@gated-at.bofh.it> <4TvB0-6wD-3@gated-at.bofh.it> <4TvB7-6wD-5@gated-at.bofh.it> <4TxWv-1xD-37@gated-at.bofh.it> <E1EMvJT-0001Jd-5v@be1.lrz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1EMvJT-0001Jd-5v@be1.lrz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2005 at 12:31:07AM +0200, Bodo Eggert wrote:
> Pekka Enberg <penberg@cs.helsinki.fi> wrote:
> > static int driver_init(void)
> > {
> >      dev->resource1 = request_region(...);
> >      if (!dev->resource1)
> >              goto failed;
> 
> > failed:
> >      driver_release(dev);
> 
> > static void driver_release(struct device * dev)
> > {
> >      release_resource(dev->resource1);
> >      release_resource(dev->resource2);
> 
> If the dev struct* isn't properly initialized, it will try to free a random
> resource.

Fur christ sake, I've made this point several times in this thread and
it still seems to be missed.  (or maybe it's just folks sloppy use of
English.)

release_resource does *not* free anything.  It unregisters it from the
resource tree _only_.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
