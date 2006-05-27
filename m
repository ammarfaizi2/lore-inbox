Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751409AbWE0GW1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbWE0GW1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 02:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbWE0GW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 02:22:27 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:26261 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1751409AbWE0GW1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 02:22:27 -0400
Message-ID: <348710943.27498@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Sat, 27 May 2006 14:22:34 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/33] readahead: state based method - aging accounting
Message-ID: <20060527062234.GB4991@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060524111246.420010595@localhost.localdomain> <348469542.24469@ustc.edu.cn> <20060526100426.2faf1367.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060526100426.2faf1367.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2006 at 10:04:26AM -0700, Andrew Morton wrote:
> 
> (hey, I haven't finished reading the last batch yet)
> 
> Wu Fengguang <wfg@mail.ustc.edu.cn> wrote:
> >
> >  /*
> >  + * The node's effective length of inactive_list(s).
> >  + */
> >  +static unsigned long node_free_and_cold_pages(void)
> >  +{
> >  +	unsigned int i;
> >  +	unsigned long sum = 0;
> >  +	struct zone *zones = NODE_DATA(numa_node_id())->node_zones;
> >  +
> >  +	for (i = 0; i < MAX_NR_ZONES; i++)
> >  +		sum += zones[i].nr_inactive +
> >  +			zones[i].free_pages - zones[i].pages_low;
> >  +
> >  +	return sum;
> >  +}
> 
> I guess this should go into page_alloc.c along with all the similar functions.

Moved as adviced.

> Is this function well-named?  Why does it have "cold" in the name?

Because it only sums `nr_inactive', leaving out `nr_active'.
