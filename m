Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751293AbWBJQcW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbWBJQcW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 11:32:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbWBJQcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 11:32:22 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:39579 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751275AbWBJQcU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 11:32:20 -0500
Subject: Re: [Lhms-devel] [RFC/PATCH: 002/010] Memory hotplug for new nodes
	with pgdat allocation. (Wait table and zonelists initalization)
From: Dave Hansen <haveblue@us.ibm.com>
To: Yasunori Goto <y-goto@jp.fujitsu.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, Andi Kleen <ak@suse.de>,
       "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>,
       linux-ia64@vger.kernel.org,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       x86-64 Discuss <discuss@x86-64.org>,
       Linux Hotplug Memory Support 
	<lhms-devel@lists.sourceforge.net>
In-Reply-To: <20060210223841.C532.Y-GOTO@jp.fujitsu.com>
References: <20060210223841.C532.Y-GOTO@jp.fujitsu.com>
Content-Type: text/plain
Date: Fri, 10 Feb 2006 08:32:08 -0800
Message-Id: <1139589128.9209.80.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-02-10 at 23:20 +0900, Yasunori Goto wrote:
> 
>  static __meminit
>  void zone_wait_table_init(struct zone *zone, unsigned long
> zone_size_pages)
>  {
> -       int i;
> +       int i, hotadd = (system_state == SYSTEM_RUNNING);
>         struct pglist_data *pgdat = zone->zone_pgdat;
> +       unsigned long allocsize;
>  
>         /*
>          * The per-page waitqueue mechanism uses hashed waitqueues
>          * per zone.
>          */
> +       if (hotadd && (zone_size_pages == PAGES_PER_SECTION))
> +               zone_size_pages = PAGES_PER_SECTION << 2; 

I don't think I understand this calculation.  You online only 4 sections
worth of pages?

-- Dave

