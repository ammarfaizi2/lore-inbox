Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288946AbSAISK4>; Wed, 9 Jan 2002 13:10:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288949AbSAISKq>; Wed, 9 Jan 2002 13:10:46 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:19208 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S288946AbSAISKf>;
	Wed, 9 Jan 2002 13:10:35 -0500
Date: Wed, 9 Jan 2002 19:10:22 +0100
From: Jens Axboe <axboe@suse.de>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bounce buffer usage
Message-ID: <20020109191022.J19814@suse.de>
In-Reply-To: <20020108084200.B19380@suse.de> <Pine.LNX.4.33L2.0201090844550.9139-100000@dragon.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L2.0201090844550.9139-100000@dragon.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09 2002, Randy.Dunlap wrote:
> | The results look very promising, although I'm a bit surprised that 2.5
> | is actually that much quicker :-)
> 
> I was too.  When I have the bounce accounting straightened out,
> I'll run each test multiple times.

Good

> | +++ mm/highmem.c
> | @@ -409,7 +409,9 @@
> |                         vfrom = kmap(from->bv_page) + from->bv_offset;
> |                         memcpy(vto, vfrom, to->bv_len);
> |                         kunmap(from->bv_page);
> | -               }
> | +                       bounced_write++;
> | +               } else
> | +                       bounced_read++;
> |         }
> |
> | Of course those are all bounces, not just (or only) swap bounces. Also
> | note that the above is not SMP safe.
> 
> Is this the only place that kstat (kernel_stat) counters
> are not SMP safe...?

Haven't looked at the other stats, the i/o stats are protected by the
queue_lock though.

-- 
Jens Axboe

