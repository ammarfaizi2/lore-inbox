Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030275AbWBMXWb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030275AbWBMXWb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 18:22:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030277AbWBMXWb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 18:22:31 -0500
Received: from sv1.valinux.co.jp ([210.128.90.2]:42691 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S1030275AbWBMXWa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 18:22:30 -0500
Date: Tue, 14 Feb 2006 08:22:29 +0900
From: KUROSAWA Takahiro <kurosawa@valinux.co.jp>
To: vatsa@in.ibm.com
Cc: linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net,
       balbir@in.ibm.com
Subject: Re: [ckrm-tech] [PATCH 2/2] connect the CPU resource controller to
 CKRM
In-Reply-To: <20060213143922.GB12279@in.ibm.com>
References: <20060209061142.2164.35994.sendpatchset@debian>
	<20060209061152.2164.64958.sendpatchset@debian>
	<20060213143922.GB12279@in.ibm.com>
X-Mailer: Sylpheed version 2.2.0beta8 (GTK+ 2.8.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20060213232229.EAAB274005@sv1.valinux.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Feb 2006 20:09:22 +0530
Srivatsa Vaddagiri <vatsa@in.ibm.com> wrote:

> > +		/* FALL THROUGH */
> > +	case CPU_UP_PREPARE:
> 	     ^^^^^^^^^^^^^^
> 		This should be done at CPU_ONLINE time (since the new CPU won't
> be in the cpu_online_map yet)?

> --- kernel/ckrm/ckrm_cpu.c.org	2006-01-31 11:37:46.000000000 +0530
> +++ kernel/ckrm/ckrm_cpu.c	2006-01-31 11:39:30.000000000 +0530
> @@ -295,7 +295,7 @@ static int __devinit ckrm_cpu_notify(str
>  		}
>  		ckrm_unlock_hier(cls);
>  		/* FALL THROUGH */
> -	case CPU_UP_PREPARE:
> +	case CPU_ONLINE:
>  		grcd.cpus = cpu_online_map;
>  		grcd.numcpus = cpus_weight(cpu_online_map);
>  		break;

Your fix seems correct.
I'll apply your patch, thanks for the fix!

-- 
KUROSAWA, Takahiro
