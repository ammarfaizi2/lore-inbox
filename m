Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266304AbUHROYX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266304AbUHROYX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 10:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266427AbUHROYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 10:24:23 -0400
Received: from penguin.cohaesio.net ([212.97.129.34]:47006 "EHLO
	mail.cohaesio.net") by vger.kernel.org with ESMTP id S266304AbUHROYU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 10:24:20 -0400
From: Anders Saaby <as@cohaesio.com>
Organization: Cohaesio A/S
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: oom-killer 2.6.8.1
Date: Wed, 18 Aug 2004 16:24:24 +0200
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
References: <200408181455.42279.as@cohaesio.com> <20040818140550.GY11200@holomorphy.com>
In-Reply-To: <20040818140550.GY11200@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408181624.25131.as@cohaesio.com>
X-OriginalArrivalTime: 18 Aug 2004 14:24:20.0242 (UTC) FILETIME=[0D116F20:01C4852F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 18 August 2004 16:05, William Lee Irwin III wrote:
> On Wed, Aug 18, 2004 at 02:55:42PM +0200, Anders Saaby wrote:
> > This is a high-volume NFS server running almost no user-space
> > applications. It serves a handfull of web server NFS clients from a
> > ~700G XFS filesystem. The machine has about 2.5 GB of RAM and 4G of
> > swap (which is almost not in use - i may use 5-10 MB total tops).
> > CONFIG_HIGHMEM and CONFIG_HIGHMEM4G enabled, SMP enabled, preempt
> > disabled. Today the OOM killer kicked in - it seemed that swap was almost
> > unused at the time (which is strange, as that should prevent the OOM
> > killer from kicking in).
> > Relevant part of the syslog follows (syslogd was killed too eventually):
>
> This seems to have been meant to resolve laptop_mode issues, but looks
> like it didn't get applied. I'm not convinced it will help given that
> you appear to have a vanilla ZONE_NORMAL slab OOM (858MB slab), but you
> never know. Capturing /proc/slabinfo data may be more helpful.
>
>
> Index: oom-2.6.8-rc1/mm/vmscan.c
> ===================================================================
> --- oom-2.6.8-rc1.orig/mm/vmscan.c	2004-07-14 06:17:13.876343912 -0700
> +++ oom-2.6.8-rc1/mm/vmscan.c	2004-07-14 06:22:15.986416200 -0700
> @@ -417,7 +417,8 @@
>  				goto keep_locked;
>  			if (!may_enter_fs)
>  				goto keep_locked;
> -			if (laptop_mode && !sc->may_writepage)
> +			if (laptop_mode && !sc->may_writepage &&
> +							!PageSwapCache(page))
>  				goto keep_locked;
>
>  			/* Page is dirty, try to write it out here */

laptop_mode is not set on this server <- :-)

- So I guess this is not relevant for my setup?

/Saaby
