Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262781AbTI2Boc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 21:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262785AbTI2Boc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 21:44:32 -0400
Received: from intra.cyclades.com ([64.186.161.6]:62407 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S262781AbTI2Boa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 21:44:30 -0400
Date: Fri, 26 Sep 2003 05:45:10 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@dhcp-107.cyclades.de
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] linux-2.4.23-pre5_nrcpus-fix_A1
In-Reply-To: <1064441207.3855.368.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.44.0309260544580.5671-100000@dhcp-107.cyclades.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 24 Sep 2003, john stultz wrote:

> On Tue, 2003-09-23 at 17:59, john stultz wrote:
> > Marcelo, all,
> > 	This is a backported patch from 2.5 that fixes array overflows and
> > memory corruption when booting on boxes with more processors then
> > CONFIG_NR_CPUS. 
> > 
> 
> Marcelo, All,
> 	James Cleverdon pointed out that I had a printk formatting typo in the
> last revision of this patch ( "0x%d" - doh!).
> 
> Anyway, this revision corrects the error, changing 0x%d -> 0x%x.
> 
> thanks
> -john
> 
> diff -Nru a/arch/i386/kernel/mpparse.c b/arch/i386/kernel/mpparse.c
> --- a/arch/i386/kernel/mpparse.c	Wed Sep 24 15:02:51 2003
> +++ b/arch/i386/kernel/mpparse.c	Wed Sep 24 15:02:51 2003
> @@ -229,6 +229,11 @@
>  		boot_cpu_logical_apicid = logical_apicid;
>  	}
>  
> +	if (num_processors >= NR_CPUS){
> +		printk(KERN_WARNING "NR_CPUS limit of %i reached. Cannot "
> +			"boot CPU(apicid 0x%x).\n", NR_CPUS, m->mpc_apicid);
> +		return;
> +	}
>  	num_processors++;
>  
>  	if (m->mpc_apicid > MAX_APICS) {

Applied thanks.







