Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263317AbSJHX14>; Tue, 8 Oct 2002 19:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263232AbSJHX0D>; Tue, 8 Oct 2002 19:26:03 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:42702 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S263241AbSJHXZq>; Tue, 8 Oct 2002 19:25:46 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Benjamin LaHaise <bcrl@redhat.com>
Date: Wed, 9 Oct 2002 09:31:14 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15779.27330.284336.914423@notabene.cse.unsw.edu.au>
Cc: mingo@redhat.com, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] silence an unnescessary raid5 debugging message
In-Reply-To: message from Benjamin LaHaise on Tuesday October 8
References: <20021008180350.A15858@redhat.com>
X-Mailer: VM 7.07 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday October 8, bcrl@redhat.com wrote:
> Hello Ingo,
> 
> LVM manages to trigger the "raid5: switching cache buffer size" printk 
> quiet voluminously when using a snapshot device.  The following patch 
> disables it by placing it under the debugging PRINTK macro.

This is there as a 'printk' deliberately.  It warns you that what you
are doing isn't really supported and will cause a substantial
performance hit (as all IO to the array is completely serialised
around one of these messages).

If you want to make it PRITNK for yourself, that is fine.  But I would
rather it stayed as printk in the mainstream kernel untill the root
problem is fixed (and I have seen patches that possibly fix the
problem, but I haven't had a chance to look at them).

NeilBrown

> 
> 		-ben
> -- 
> "Do you seek knowledge in time travel?"
> 
> diff -urN linux.orig/drivers/md/raid5.c linux/drivers/md/raid5.c
> --- linux.orig/drivers/md/raid5.c	Mon Feb 25 14:37:58 2002
> +++ linux/drivers/md/raid5.c	Tue Oct  8 17:56:43 2002
> @@ -282,7 +282,7 @@
>  				}
>  
>  				if (conf->buffer_size != size) {
> -					printk("raid5: switching cache buffer size, %d --> %d\n", oldsize, size);
> +					PRINTK("raid5: switching cache buffer size, %d --> %d\n", oldsize, size);
>  					shrink_stripe_cache(conf);
>  					if (size==0) BUG();
>  					conf->buffer_size = size;
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
