Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261404AbVACHHE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261404AbVACHHE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 02:07:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbVACHHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 02:07:04 -0500
Received: from boromix.nask.net.pl ([195.187.245.33]:43750 "EHLO
	boromix.nask.net.pl") by vger.kernel.org with ESMTP id S261404AbVACHG7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 02:06:59 -0500
Date: Mon, 3 Jan 2005 08:06:24 +0100 (CET)
From: Mateusz.Blaszczyk@nask.pl
X-X-Sender: mat@boromir
Reply-To: Mateusz.Blaszczyk@nask.pl
To: Peter Osterlund <petero2@telia.com>
cc: axboe@suse.de, linux-kernel@vger.kernel.org,
       Nigel Cunningham <ncunningham@users.sourceforge.net>
Subject: Re: [pktcdvd] Badness in fork.c:91 then Oops
In-Reply-To: <m3acrvh9vs.fsf@telia.com>
Message-ID: <Pine.GSO.4.58.0501030805190.8807@boromir>
References: <Pine.GSO.4.58.0412301854420.2875@boromir> <m3acrvh9vs.fsf@telia.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
VirusProtection: checked - Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Mateusz.Blaszczyk@nask.pl writes:
>
> > PKTCDVD seems to create some badness in kernel/fork, line 91:
> >
> > I loaded pktcdvd manaully end everything was fine
> >
> > Dec 30 08:32:46 localhost kernel: pktcdvd: v0.2.0a 2004-07-14 Jens Axboe (axboe@suse.de) and petero2@telia.com
> >
> > Then I tried to map cd drive using udftools' pktsetup (v.1.0.3b):
> >
> > Dec 30 08:33:27 localhost kernel: cdrom: This disc doesn't have any tracks I recognize!
> > Dec 30 08:33:27 localhost kernel: Badness in __put_task_struct at kernel/fork.c:91
> ...
> > Dec 30 08:05:52 localhost kernel: Software Suspend Core.
> > Dec 30 08:05:52 localhost kernel: Software Suspend text mode support loaded.
> > Dec 30 08:05:52 localhost kernel: Software Suspend LZF Compression Driver registered.
> > Dec 30 08:05:52 localhost kernel: Software Suspend Swap Writer registered.
>
> It's actually the swsusp 2 patches that don't handle the pktcdvd
> driver correctly. The kthread_run() function was changed, but the
> pktcdvd driver wasn't updated accordingly. I think this patch will fix
> the problem.
>
> --- linux/drivers/block/pktcdvd.c.old	2004-12-30 20:11:54.400478672 +0100
> +++ linux/drivers/block/pktcdvd.c	2004-12-30 20:12:09.617165384 +0100
> @@ -2364,7 +2364,7 @@
>  	pkt_init_queue(pd);
>
>  	atomic_set(&pd->cdrw.pending_bios, 0);
> -	pd->cdrw.thread = kthread_run(kcdrwd, pd, "%s", pd->name);
> +	pd->cdrw.thread = kthread_run(kcdrwd, pd, PF_SYNCTHREAD, "%s", pd->name);
>  	if (IS_ERR(pd->cdrw.thread)) {
>  		printk("pktcdvd: can't start kernel thread\n");
>  		ret = -ENOMEM;
>

Thank you , it works now.


-mat

-- 
Pozdrowienia,Regards,Cheers,Grüße,A plus!,
