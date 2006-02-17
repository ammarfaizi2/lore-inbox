Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751563AbWBQPxP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751563AbWBQPxP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 10:53:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751564AbWBQPxO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 10:53:14 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:29099 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751556AbWBQPxN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 10:53:13 -0500
Subject: Re: [PATCH: 004/012] Memory hotplug for new nodes v.2. (pgdat
	alloc caller for ia64)
From: Dave Hansen <haveblue@us.ibm.com>
To: Yasunori Goto <y-goto@jp.fujitsu.com>
Cc: Andrew Morton <akpm@osdl.org>, "Luck, Tony" <tony.luck@intel.com>,
       Andi Kleen <ak@suse.de>,
       "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>,
       Joel Schopp <jschopp@austin.ibm.com>, linux-ia64@vger.kernel.org,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       x86-64 Discuss <discuss@x86-64.org>
In-Reply-To: <20060217211436.4070.Y-GOTO@jp.fujitsu.com>
References: <20060217211436.4070.Y-GOTO@jp.fujitsu.com>
Content-Type: text/plain
Date: Fri, 17 Feb 2006 07:52:37 -0800
Message-Id: <1140191557.21383.79.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-02-17 at 22:28 +0900, Yasunori Goto wrote:
> 
> +       if (node < 0)
> +               node = 0; /* pxm is undefined in DSDT.
> +                            This might be non NUMA case */
> +
> +       if (!node_online(node)){
> +               ret = new_pgdat_init(node, start_pfn, nr_pages);
> +               if (ret)
> +                       return ret;
> +
> +               new_pgdat = 1;
> +       }
> +       pgdat = NODE_DATA(node); 

Now that I've seen this exact code copy-and-pasted into two different
architectures, it begs the question: do we need a common function here?

-- Dave

