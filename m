Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965259AbVKBVcx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965259AbVKBVcx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 16:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965258AbVKBVcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 16:32:52 -0500
Received: from mx01.stofanet.dk ([212.10.10.11]:59789 "EHLO mx01.stofanet.dk")
	by vger.kernel.org with ESMTP id S965254AbVKBVcw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 16:32:52 -0500
Message-ID: <43692FBB.1000409@stud.feec.vutbr.cz>
Date: Wed, 02 Nov 2005 22:29:31 +0100
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bill Moss <bmoss@CLEMSON.EDU>
CC: linville@tuxdriver.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.13] airo.c: remove delay in airo_get_scan
References: <200511020347.jA23lvi9028538@localhost.localdomain>
In-Reply-To: <200511020347.jA23lvi9028538@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Moss wrote:
> Remove 3 second delay in airo_get_scan. Testing shows this delay is unnecessary. Users of NetworkManager
> find this delay make NetworkManager slow to connect.
> 
> --- a/drivers/net/wireless/airo.c	2005-11-01 21:21:04.000000000 -0500
> +++ b/drivers/net/wireless/airo.c	2005-11-01 21:22:41.000000000 -0500
> @@ -6918,7 +6918,7 @@
>  	/* When we are associated again, the scan has surely finished.
>  	 * Just in case, let's make sure enough time has elapsed since
>  	 * we started the scan. - Javier */
> -	if(ai->scan_timestamp && time_before(jiffies,ai->scan_timestamp+3*HZ)) {
> +	if(ai->scan_timestamp && time_before(jiffies,ai->scan_timestamp)) {
>  		/* Important note : we don't want to block the caller
>  		 * until results are ready for various reasons.
>  		 * First, managing wait queues is complex and racy
> 
> Signed-off-by: Bill Moss <bmoss@clemson.edu>

With this change, the time_before() test can't possibly succeed, can it? 
In that case, why not remove the if and its body completely?

Michal
