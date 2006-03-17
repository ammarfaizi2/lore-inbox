Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030240AbWCQR7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030240AbWCQR7P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 12:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030242AbWCQR7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 12:59:15 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:9940 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030238AbWCQR7O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 12:59:14 -0500
Subject: Re: [PATCH: 012/017]Memory hotplug for new nodes v.4.(rebuild
	zonelists after online pages)
From: Dave Hansen <haveblue@us.ibm.com>
To: Yasunori Goto <y-goto@jp.fujitsu.com>
Cc: Andrew Morton <akpm@osdl.org>, "Luck, Tony" <tony.luck@intel.com>,
       Andi Kleen <ak@suse.de>, Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org, linux-mm <linux-mm@kvack.org>
In-Reply-To: <20060317163612.C64F.Y-GOTO@jp.fujitsu.com>
References: <20060317163612.C64F.Y-GOTO@jp.fujitsu.com>
Content-Type: text/plain
Date: Fri, 17 Mar 2006 09:58:17 -0800
Message-Id: <1142618297.10906.97.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-17 at 17:22 +0900, Yasunori Goto wrote:
> +++ pgdat8/mm/memory_hotplug.c  2006-03-17 13:53:40.712581399 +0900
> @@ -123,6 +123,7 @@ int online_pages(unsigned long pfn, unsi
>         unsigned long flags;
>         unsigned long onlined_pages = 0;
>         struct zone *zone;
> +       int need_refresh_zonelist = 0; 

I'd make this "need_to_rebuild_zonelists" or "need_zonelists_rebuild".
I think those sound a little bit better.

Plus, it makes even more sense when you see:

       if (need_to_rebuild_zonelists)
               build_all_zonelists();

if the names all match up.

-- Dave

