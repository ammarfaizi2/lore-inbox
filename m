Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751157AbWEZRFG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbWEZRFG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 13:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbWEZRFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 13:05:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42679 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751157AbWEZRFE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 13:05:04 -0400
Date: Fri, 26 May 2006 10:04:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
Cc: linux-kernel@vger.kernel.org, wfg@mail.ustc.edu.cn
Subject: Re: [PATCH 13/33] readahead: state based method - aging accounting
Message-Id: <20060526100426.2faf1367.akpm@osdl.org>
In-Reply-To: <348469542.24469@ustc.edu.cn>
References: <20060524111246.420010595@localhost.localdomain>
	<348469542.24469@ustc.edu.cn>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(hey, I haven't finished reading the last batch yet)

Wu Fengguang <wfg@mail.ustc.edu.cn> wrote:
>
>  /*
>  + * The node's effective length of inactive_list(s).
>  + */
>  +static unsigned long node_free_and_cold_pages(void)
>  +{
>  +	unsigned int i;
>  +	unsigned long sum = 0;
>  +	struct zone *zones = NODE_DATA(numa_node_id())->node_zones;
>  +
>  +	for (i = 0; i < MAX_NR_ZONES; i++)
>  +		sum += zones[i].nr_inactive +
>  +			zones[i].free_pages - zones[i].pages_low;
>  +
>  +	return sum;
>  +}

I guess this should go into page_alloc.c along with all the similar functions.

Is this function well-named?  Why does it have "cold" in the name?
