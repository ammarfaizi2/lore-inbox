Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030299AbVLXLie@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030299AbVLXLie (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Dec 2005 06:38:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030544AbVLXLie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Dec 2005 06:38:34 -0500
Received: from main.gmane.org ([80.91.229.2]:37054 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030299AbVLXLid (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Dec 2005 06:38:33 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Thomas Backlund <tmb@mandriva.org>
Subject: Re: [PATCH] add missing memory barriers to ipc/sem.c
Date: Sat, 24 Dec 2005 13:38:35 +0200
Message-ID: <dojbve$5bq$1@sea.gmane.org>
References: <43AC80E5.6050906@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ndn243.bob.fi
User-Agent: Thunderbird 1.5 (Windows/20051201)
In-Reply-To: <43AC80E5.6050906@colorfullife.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:
> Hi Linus,
> 
> Two smp_wmb() statements are missing in the sysv sem code: This could 
> cause stack corruptions.
> The attached patch adds them.
> 
> Signed-Off-By: Manfred Spraul <manfred@colorfullife.com>
> 
> 
> ------------------------------------------------------------------------
> 
> --- 2.6/ipc/sem.c	2005-12-19 01:36:54.000000000 +0100
> +++ build-2.6/ipc/sem.c	2005-12-23 23:25:17.000000000 +0100
> @@ -381,6 +381,7 @@
>  			/* hands-off: q will disappear immediately after
>  			 * writing q->status.
>  			 */
> +			smb_wmb();

Typo? Shouldn't it be smp_wmb();

>  			q->status = error;
>  			q = n;
>  		} else {
> @@ -461,6 +462,7 @@
>  		n = q->next;
>  		q->status = IN_WAKEUP;
>  		wake_up_process(q->sleeper); /* doesn't sleep */
> +		smp_wmb();
>  		q->status = -EIDRM;	/* hands-off q */
>  		q = n;
>  	}

