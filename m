Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751243AbWCVNvS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbWCVNvS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 08:51:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbWCVNvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 08:51:18 -0500
Received: from cantor.suse.de ([195.135.220.2]:17298 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751243AbWCVNvR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 08:51:17 -0500
From: Andi Kleen <ak@suse.de>
To: Yasunori Goto <y-goto@jp.fujitsu.com>
Subject: Re: [PATCH: 003/017]Memory hotplug for new nodes v.4.(get node id at probe memory)
Date: Wed, 22 Mar 2006 14:17:55 +0100
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, "Luck, Tony" <tony.luck@intel.com>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org, linux-mm <linux-mm@kvack.org>
References: <20060317162835.C63D.Y-GOTO@jp.fujitsu.com>
In-Reply-To: <20060317162835.C63D.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603221417.55462.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 17 March 2006 09:20, Yasunori Goto wrote:
> When CONFIG_NUMA && CONFIG_ARCH_MEMORY_PROBE, nid should be defined
> before calling add_memory(nid, start, size).

Seems a bit weird to have the node number assignment somewhere
hidden in memory hotadd. It would be probably cleaner to have
a separate step for this.

> +#if defined(CONFIG_NUMA) && defined(CONFIG_ARCH_MEMORY_PROBE)
> +extern int arch_nid_probe(u64 start);

Instead of adding such ugly ifdefs better just add stubs to all the
architectures that support memory hotplug. There are not that many
anyways.

-Andi

> +#else
> +static inline int arch_nid_probe(u64 start)
> +{
> +	return 0;
> +}
> +#endif
> +
