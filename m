Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268680AbUJDV5k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268680AbUJDV5k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 17:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268698AbUJDV51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 17:57:27 -0400
Received: from host217-42-111-215.range217-42.btcentralplus.com ([217.42.111.215]:3535
	"EHLO worthy.swandive.local") by vger.kernel.org with ESMTP
	id S268680AbUJDVws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 17:52:48 -0400
Message-ID: <4161C61C.6020004@btinternet.com>
Date: Mon, 04 Oct 2004 22:52:28 +0100
From: Grant Wilson <gww@btinternet.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040927)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: s.rivoir@gts.it, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc3-mm2
References: <20041004020207.4f168876.akpm@osdl.org>	<4161462A.5040806@gts.it>	<20041004121805.2bffcd99.akpm@osdl.org>	<4161BCCB.4080302@btinternet.com>	<20041004143253.50a82050.akpm@osdl.org> <20041004143953.10e6d764.akpm@osdl.org>
In-Reply-To: <20041004143953.10e6d764.akpm@osdl.org>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
[snip]

> You could try these instead:
> 
> --- 25/include/linux/netfilter_ipv4/ip_conntrack.h~conntrack-preempt-safety-fix	Mon Oct  4 14:36:19 2004
> +++ 25-akpm/include/linux/netfilter_ipv4/ip_conntrack.h	Mon Oct  4 14:37:02 2004
> @@ -311,10 +311,11 @@ struct ip_conntrack_stat
>  	unsigned int expect_delete;
>  };
>  
> -#define CONNTRACK_STAT_INC(count)				\
> -	do {							\
> -		per_cpu(ip_conntrack_stat, get_cpu()).count++;	\
> -		put_cpu();					\
> +#define CONNTRACK_STAT_INC(count)					\
> +	do {								\
> +		preempt_disable();					\
> +		per_cpu(ip_conntrack_stat, smp_processor_id()).count++;	\
> +		preempt_disable();	
                 ^^^^^^^^^^^^^^^^^^
Should this not be preempt_enable();   ?

Cheers,
Grant
