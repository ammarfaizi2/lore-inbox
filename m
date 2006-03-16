Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751930AbWCPJME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751930AbWCPJME (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 04:12:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752231AbWCPJME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 04:12:04 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:56545 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751930AbWCPJMC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 04:12:02 -0500
Date: Thu, 16 Mar 2006 10:11:51 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Shaohua Li <shaohua.li@intel.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH]swsusp: drain high mem pages
Message-ID: <20060316091151.GC1729@elf.ucw.cz>
References: <1142481202.26706.15.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1142481202.26706.15.camel@sli10-desk.sh.intel.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Čt 16-03-06 11:53:22, Shaohua Li wrote:
> Highmem could be in pcp list as well.

This explains some strangeness I was seeing before.

OTOH it is nothing but ugly these days, so this is not urgent for 2.6.16.

ACK.
								Pavel

> Signed-off-by: Shaohua Li<shaohua.li@intel.com>
> ---
> 
>  linux-2.6.15-root/kernel/power/snapshot.c |    1 +
>  1 files changed, 1 insertion(+)
> 
> diff -puN kernel/power/snapshot.c~drain_highmem kernel/power/snapshot.c
> --- linux-2.6.15/kernel/power/snapshot.c~drain_highmem	2006-03-14 13:38:16.000000000 +0800
> +++ linux-2.6.15-root/kernel/power/snapshot.c	2006-03-14 14:13:30.000000000 +0800
> @@ -120,6 +120,7 @@ int save_highmem(void)
>  	int res = 0;
>  
>  	pr_debug("swsusp: Saving Highmem\n");
> +	drain_local_pages();
>  	for_each_zone (zone) {
>  		if (is_highmem(zone))
>  			res = save_highmem_zone(zone);
> _
> 

-- 
220: * This program is distributed in the hope that it will be useful,
