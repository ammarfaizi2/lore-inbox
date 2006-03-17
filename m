Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932750AbWCQRNU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932750AbWCQRNU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 12:13:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932741AbWCQRNU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 12:13:20 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:57507 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932740AbWCQRNS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 12:13:18 -0500
Subject: Re: [PATCH: 002/017]Memory hotplug for new nodes v.4.(change name
	old add_memory() to arch_add_memory())
From: Dave Hansen <haveblue@us.ibm.com>
To: Yasunori Goto <y-goto@jp.fujitsu.com>
Cc: Andrew Morton <akpm@osdl.org>, "Luck, Tony" <tony.luck@intel.com>,
       Andi Kleen <ak@suse.de>, Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org, linux-mm <linux-mm@kvack.org>
In-Reply-To: <20060317162757.C63B.Y-GOTO@jp.fujitsu.com>
References: <20060317162757.C63B.Y-GOTO@jp.fujitsu.com>
Content-Type: text/plain
Date: Fri, 17 Mar 2006 09:12:18 -0800
Message-Id: <1142615538.10906.67.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-17 at 17:20 +0900, Yasunori Goto wrote:
> This patch changes name of old add_memory() to arch_add_memory.
> and use node id to get pgdat for the node at NODE_DATA().
> 
> Note: Powerpc's old add_memory() is defined as __devinit. However,
>       add_memory() is usually called only after bootup. 
>       I suppose it may be redundant. But, I'm not sure about powerpc.
>       So, I keep it. (But, __meminit is better than __devinit at least.)

My thoughts when originally designing the API were that the architecture
may be the only bit that actually knows where the memory _is_.  So, we
shouldn't involve the generic code in figuring this out.

You can see the result of this in the next patch because there is a new
function introduced to hide the arch-specific node lookup.  If that was
simply done in the already arch-specific add_memory() function, then you
wouldn't need arch_nid_probe() and its related #ifdefs at all.

-- Dave

