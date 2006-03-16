Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752184AbWCPEbp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752184AbWCPEbp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 23:31:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752165AbWCPEbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 23:31:45 -0500
Received: from yue.linux-ipv6.org ([203.178.140.15]:44811 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S1752184AbWCPEbp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 23:31:45 -0500
Date: Thu, 16 Mar 2006 13:33:49 +0900 (JST)
Message-Id: <20060316.133349.44436898.yoshfuji@linux-ipv6.org>
To: kamezawa.hiroyu@jp.fujitsu.com
Cc: nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org, akpm@osdl.org,
       yoshfuji@linux-ipv6.org
Subject: Re: [PATCH] for_each_possible_cpu [1/19] defines
 for_each_possible_cpu
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20060316131743.d7b716e9.kamezawa.hiroyu@jp.fujitsu.com>
References: <20060316122110.c00f4181.kamezawa.hiroyu@jp.fujitsu.com>
	<4418DEEA.2000008@yahoo.com.au>
	<20060316131743.d7b716e9.kamezawa.hiroyu@jp.fujitsu.com>
Organization: USAGI/WIDE Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20060316131743.d7b716e9.kamezawa.hiroyu@jp.fujitsu.com> (at Thu, 16 Mar 2006 13:17:43 +0900), KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> says:


> cpu_msrs[i].coutners are allocated by for_each_online_cpu().
> and free it by for_each_possible_cpus() without no pointer check.

No...

> -               kfree(cpu_msrs[i].counters);
> +       for_each_possible_cpu(i) {
> +               if (cpu_msrs[i].counters)
> +                       kfree(cpu_msrs[i].counters);

kfree() checks its argument for you.

>                 cpu_msrs[i].counters = NULL;
> -               kfree(cpu_msrs[i].controls);
> +               if (cpu_msrs[i].controls)
> +                       kfree(cpu_msrs[i].controls);
>                 cpu_msrs[i].controls = NULL;

ditto.

--yoshfuji
