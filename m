Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751296AbWG2QUi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbWG2QUi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 12:20:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbWG2QUi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 12:20:38 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:54157 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751296AbWG2QUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 12:20:37 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <44CB8A30.2080809@s5r6.in-berlin.de>
Date: Sat, 29 Jul 2006 18:17:52 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: nhorman@tuxdriver.com
CC: bcollins@debian.org, kernel-janitors@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [KJ] audit return code handling for kernel_thread [8/11]
References: <200607282007.k6SK7v9j009670@ra.tuxdriver.com>
In-Reply-To: <200607282007.k6SK7v9j009670@ra.tuxdriver.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

nhorman@tuxdriver.com wrote:
> --- a/drivers/ieee1394/nodemgr.c
> +++ b/drivers/ieee1394/nodemgr.c
> @@ -426,7 +426,8 @@ static ssize_t fw_set_rescan(struct bus_
>  	 * something stupid and spawn this a lot of times, but that's
>  	 * root's fault. */
>  	if (state == 1)
> -		kernel_thread(nodemgr_rescan_bus_thread, NULL, CLONE_KERNEL);
> +		if (kernel_thread(nodemgr_rescan_bus_thread, NULL, CLONE_KERNEL) < 0)
> +			printk(KERN_WARNING "Could not start 1394 bus rescan thread\n");
>  
>  	return count;
>  }

Thanks, but (a) we don't need the warnig and (b) we even don't need to 
spawn a thread at this point. This call to kernel_thread has been 
removed from git-ieee1394 and -mm earlier this month.
http://www.kernel.org/git/?p=linux/kernel/git/bcollins/linux1394-2.6.git;a=commitdiff_plain;h=40fd89cc54a8a67c81b5aa40b22c4f40b39e47b9
http://marc.theaimsgroup.com/?l=linux-mm-commits&m=115189722112717
-- 
Stefan Richter
-=====-=-==- -=== ===-=
http://arcgraph.de/sr/
