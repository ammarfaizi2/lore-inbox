Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262050AbUKDC7C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbUKDC7C (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 21:59:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261646AbUKDC65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 21:58:57 -0500
Received: from fw.osdl.org ([65.172.181.6]:19379 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262050AbUKDC6M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 21:58:12 -0500
Date: Wed, 3 Nov 2004 18:57:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Robert.Picco@hp.com, venkatesh.pallipadi@intel.com,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       clameter@sgi.com
Subject: Re: [PATCH] fix HPET time_interpolator registration
Message-Id: <20041103185721.743d9317.akpm@osdl.org>
In-Reply-To: <200411031024.43782.bjorn.helgaas@hp.com>
References: <200411031024.43782.bjorn.helgaas@hp.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
>
>  Fixup after mid-air collision between Christoph adding time_interpolator.mask,
>  and me removing a static time_interpolator struct from hpet.
> 
>  Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> 
>  ===== drivers/char/hpet.c 1.14 vs edited =====
>  --- 1.14/drivers/char/hpet.c	2004-11-02 07:40:42 -07:00
>  +++ edited/drivers/char/hpet.c	2004-11-03 10:05:26 -07:00
>  @@ -712,6 +712,7 @@
>   	ti->addr = &hpetp->hp_hpet->hpet_mc;
>   	ti->frequency = hpet_time_div(hpets->hp_period);
>   	ti->drift = ti->frequency * HPET_DRIFT / 1000000;
>  +	ti->mask = 0xffffffffffffffffLL;
>   
>   	hpetp->hp_interpolator = ti;
>   	register_time_interpolator(ti);
> 

ti->mask is u64, and on some architectures u64 is `long'.  Compilers might
whine about this.   I'll make it

	ti->mask = -1;

which just works.

