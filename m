Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263845AbUEGXH1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263845AbUEGXH1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 19:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263840AbUEGXH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 19:07:27 -0400
Received: from moraine.clusterfs.com ([66.246.132.190]:34714 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S263845AbUEGXHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 19:07:25 -0400
Date: Fri, 7 May 2004 17:07:22 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Zhenmin Li <zli4@cs.uiuc.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OPERA] Another potential error detected by static analysis tool (2.6.4)
Message-ID: <20040507230722.GH9641@schnapps.adilger.int>
Mail-Followup-To: Zhenmin Li <zli4@cs.uiuc.edu>,
	linux-kernel@vger.kernel.org
References: <20040507001407.GK9037@lorien.prodam> <001101c43481$d49756d0$76f6ae80@Turandot>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001101c43481$d49756d0$76f6ae80@Turandot>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 07, 2004  17:22 -0500, Zhenmin Li wrote:
> Version: 2.6.4
> Files:
> /arch/alpha/kernel/irq.c
> 
> --- 539,547 ----
>   #ifdef CONFIG_SMP
>         if (i == 0) {
>                 seq_puts(p, "           ");
> !               for (i = 0; i < NR_CPUS; i++)
> !                       if (cpu_online(i))
> !                               seq_printf(p, "CPU%d       ", i);
>                 seq_putc(p, '\n');
>         }
>   #endif
> 
> 
> Maybe change to:
> *** 539,547 ****
>   #ifdef CONFIG_SMP
>         if (i == 0) {
>                 seq_puts(p, "           ");
> !               for (j = 0; j < NR_CPUS; j++)
> !                       if (cpu_online(j))
> !                               seq_printf(p, "CPU%d       ", j);
>                 seq_putc(p, '\n');
>         }
>   #endif

The real bug is that someone used "i" for something meaningful other than
a loop counter.  In addition to your change, this should be fixed to call
that variable "irq" or something more useful ;-).

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

