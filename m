Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319294AbSIKTHE>; Wed, 11 Sep 2002 15:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319295AbSIKTHE>; Wed, 11 Sep 2002 15:07:04 -0400
Received: from rrzs2.rz.uni-regensburg.de ([132.199.1.2]:28052 "EHLO
	rrzs2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id <S319294AbSIKTHD>; Wed, 11 Sep 2002 15:07:03 -0400
Date: Wed, 11 Sep 2002 21:11:06 +0200
From: Christian Guggenberger 
	<christian.guggenberger@physik.uni-regensburg.de>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org, hch@infradead.org
Subject: Re: 2.4.20pre5aa2
Message-ID: <20020911211106.G13655@pc9391.uni-regensburg.de>
References: <20020911201602.A13655@pc9391.uni-regensburg.de> <20020911194447.A7073@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20020911194447.A7073@infradead.org>; from hch@infradead.org on Mit, Sep 11, 2002 at 20:44:47 +0200
X-Mailer: Balsa 1.2.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am 11 Sep 2002 20:44:47 schrieb(en) Christoph Hellwig:
> Could you please try the following patch from Andrea?
> 
> --- 2.4.20pre5aa3/fs/xfs/pagebuf/page_buf.c.~1~	Wed Sep 11
> 05:17:46 2002
> +++ 2.4.20pre5aa3/fs/xfs/pagebuf/page_buf.c	Wed Sep 11 06:00:35
> 2002
> @@ -2055,9 +2055,9 @@ pagebuf_iodone_daemon(
>  	spin_unlock_irq(&current->sigmask_lock);
> 
>  	/* Migrate to the right CPU */
> -	current->cpus_allowed = 1UL << cpu;
> -	while (smp_processor_id() != cpu)
> -		schedule();
> +	set_cpus_allowed(current, 1UL << cpu);
> +	if (cpu() != cpu)
> +		BUG();
> 
>  	sprintf(current->comm, "pagebuf_io_CPU%d", bind_cpu);
>  	INIT_LIST_HEAD(&pagebuf_iodone_tq[cpu]);
> 
> 

andrea,

I applied your patch to page_buf.c (but not the ext3/reiserfs stuff, 
because there's no need for me) and now everything seems to work fine!

thank you!
Christian
ge
