Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932144AbWC3MLR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932144AbWC3MLR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 07:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932188AbWC3MLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 07:11:17 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:3000 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S932144AbWC3MLQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 07:11:16 -0500
Date: Thu, 30 Mar 2006 05:11:14 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Akinobu Mita <mita@miraclelinux.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       Corey Minyard <minyard@mvista.com>, Ben Collins <bcollins@debian.org>,
       Roland Dreier <rolandd@cisco.com>,
       Alasdair Kergon <dm-devel@redhat.com>, Gerd Knorr <kraxel@bytesex.org>,
       Paul Mackerras <paulus@samba.org>, Frank Pavlic <fpavlic@de.ibm.com>,
       Andrew Vasquez <linux-driver@qlogic.com>,
       Mikael Starvik <starvik@axis.com>, Greg Kroah-Hartman <greg@kroah.com>
Subject: Re: [patch 7/8] drivers: use list_move()
Message-ID: <20060330121114.GF13590@parisc-linux.org>
References: <20060330081605.085383000@localhost.localdomain> <20060330081731.173381000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060330081731.173381000@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2006 at 04:16:12PM +0800, Akinobu Mita wrote:
>  drivers/scsi/ncr53c8xx.c                       |    3 +--

> Index: 2.6-git/drivers/scsi/ncr53c8xx.c
> ===================================================================
> --- 2.6-git.orig/drivers/scsi/ncr53c8xx.c
> +++ 2.6-git/drivers/scsi/ncr53c8xx.c
> @@ -5118,8 +5118,7 @@ static void ncr_ccb_skipped(struct ncb *
>  		cp->host_status &= ~HS_SKIPMASK;
>  		cp->start.schedule.l_paddr = 
>  			cpu_to_scr(NCB_SCRIPT_PHYS (np, select));
> -		list_del(&cp->link_ccbq);
> -		list_add_tail(&cp->link_ccbq, &lp->skip_ccbq);
> +		list_move_tail(&cp->link_ccbq, &lp->skip_ccbq);
>  		if (cp->queued) {
>  			--lp->queuedccbs;
>  		}

ACK.  Thanks!
