Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262716AbUKEQai@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262716AbUKEQai (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 11:30:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262721AbUKEQai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 11:30:38 -0500
Received: from cantor.suse.de ([195.135.220.2]:37763 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261247AbUKEQa0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 11:30:26 -0500
To: Jack Steiner <steiner@sgi.com>
Cc: Takayoshi Kochi <t-kochi@bq.jp.nec.com>, ak@suse.de,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Externalize SLIT table
References: <20041103205655.GA5084@sgi.com>
	<20041104.105908.18574694.t-kochi@bq.jp.nec.com>
	<20041104040713.GC21211@wotan.suse.de>
	<20041104.135721.08317994.t-kochi@bq.jp.nec.com>
	<20041105160808.GA26719@sgi.com>
From: Andreas Schwab <schwab@suse.de>
X-Yow: Here is my refrigerator full of FLANK STEAK...and over there is my
 UPHOLSTERED CANOE...I don't know WHY I OWN them!!
Date: Fri, 05 Nov 2004 17:26:10 +0100
In-Reply-To: <20041105160808.GA26719@sgi.com> (Jack Steiner's message of
 "Fri, 5 Nov 2004 10:08:08 -0600")
Message-ID: <jevfcknty5.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jack Steiner <steiner@sgi.com> writes:

> @@ -111,6 +111,21 @@ static ssize_t node_read_numastat(struct
>  }
>  static SYSDEV_ATTR(numastat, S_IRUGO, node_read_numastat, NULL);
>  
> +static ssize_t node_read_distance(struct sys_device * dev, char * buf)
> +{
> +	int nid = dev->id;
> +	int len = 0;
> +	int i;
> +
> +	for (i = 0; i < numnodes; i++)
> +		len += sprintf(buf + len, "%s%d", i ? " " : "", node_distance(nid, i));

Can this overflow the space allocated for buf?

> @@ -58,6 +59,31 @@ static inline void register_cpu_control(
>  }
>  #endif /* CONFIG_HOTPLUG_CPU */
>  
> +#ifdef CONFIG_NUMA
> +static ssize_t cpu_read_distance(struct sys_device * dev, char * buf)
> +{
> +	int nid = cpu_to_node(dev->id);
> +	int len = 0;
> +	int i;
> +
> +	for (i = 0; i < num_possible_cpus(); i++)
> +		len += sprintf(buf + len, "%s%d", i ? " " : "", 
> +			node_distance(nid, cpu_to_node(i)));

Or this?

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
