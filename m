Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261542AbUKDDxM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261542AbUKDDxM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 22:53:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261591AbUKDDxL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 22:53:11 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:23498 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261542AbUKDDw7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 22:52:59 -0500
Date: Wed, 3 Nov 2004 19:52:49 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Andrew Morton <akpm@osdl.org>
cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Robert.Picco@hp.com,
       venkatesh.pallipadi@intel.com, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: [PATCH] fix HPET time_interpolator registration
In-Reply-To: <20041103185721.743d9317.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0411031951110.3414@schroedinger.engr.sgi.com>
References: <200411031024.43782.bjorn.helgaas@hp.com> <20041103185721.743d9317.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Nov 2004, Andrew Morton wrote:

> Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
> >
> >  Fixup after mid-air collision between Christoph adding time_interpolator.mask,
> >  and me removing a static time_interpolator struct from hpet.
> >
> >  Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> >
> >  ===== drivers/char/hpet.c 1.14 vs edited =====
> >  --- 1.14/drivers/char/hpet.c	2004-11-02 07:40:42 -07:00
> >  +++ edited/drivers/char/hpet.c	2004-11-03 10:05:26 -07:00
> >  @@ -712,6 +712,7 @@
> >   	ti->addr = &hpetp->hp_hpet->hpet_mc;
> >   	ti->frequency = hpet_time_div(hpets->hp_period);
> >   	ti->drift = ti->frequency * HPET_DRIFT / 1000000;
> >  +	ti->mask = 0xffffffffffffffffLL;
> >
> >   	hpetp->hp_interpolator = ti;
> >   	register_time_interpolator(ti);
> >
>
> ti->mask is u64, and on some architectures u64 is `long'.  Compilers might
> whine about this.   I'll make it
>
> 	ti->mask = -1;
>
> which just works.

Hmmm... How do you then specify a 64 bit mask without running into issues
with the compilers?
