Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263796AbTIHX74 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 19:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263819AbTIHX74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 19:59:56 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18923 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263796AbTIHX7z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 19:59:55 -0400
Message-ID: <3F5D17EA.4010502@pobox.com>
Date: Mon, 08 Sep 2003 19:59:38 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: fedor@karpelevitch.net, abz@frogfoot.net, linux-kernel@vger.kernel.org
Subject: Re: possibly bug in 8139cp? (WAS Re: BUG: 2.4.23-pre3 + ifconfig)
References: <20030904180554.GA21536@oasis.frogfoot.net>	<200309071217.03470.fedor@karpelevitch.net>	<20030907191552.GA26123@oasis.frogfoot.net>	<200309080943.26254.fedor@karpelevitch.net>	<20030908172641.GB21226@gtf.org> <20030908133220.66676107.akpm@osdl.org>
In-Reply-To: <20030908133220.66676107.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> diff -puN include/linux/netdevice.h~ifdown-lockup-fix include/linux/netdevice.h
> --- 25/include/linux/netdevice.h~ifdown-lockup-fix	Mon Sep  8 13:20:28 2003
> +++ 25-akpm/include/linux/netdevice.h	Mon Sep  8 13:20:34 2003
> @@ -854,7 +854,7 @@ static inline void netif_rx_complete(str
>  
>  static inline void netif_poll_disable(struct net_device *dev)
>  {
> -	while (test_and_set_bit(__LINK_STATE_RX_SCHED, &dev->state)) {
> +	while (test_bit(__LINK_STATE_RX_SCHED, &dev->state)) {
>  		/* No hurry. */
>  		current->state = TASK_INTERRUPTIBLE;
>  		schedule_timeout(1);
> 


no that breaks other things.

	Jeff



