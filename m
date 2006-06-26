Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932077AbWFZRqk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbWFZRqk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 13:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbWFZRqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 13:46:40 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:19587 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932077AbWFZRqj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 13:46:39 -0400
Subject: Re: linux-2.6.17.1: undefined reference to `online_page'
From: Dave Hansen <haveblue@us.ibm.com>
To: Yasunori Goto <y-goto@jp.fujitsu.com>
Cc: Toralf Foerster <toralf.foerster@gmx.de>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>,
       Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <20060626163235.A022.Y-GOTO@jp.fujitsu.com>
References: <200606251704_MC3-1-C36D-5D33@compuserve.com>
	 <20060626163235.A022.Y-GOTO@jp.fujitsu.com>
Content-Type: text/plain
Date: Mon, 26 Jun 2006 10:46:32 -0700
Message-Id: <1151343992.10877.34.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-26 at 16:39 +0900, Yasunori Goto wrote:
> 
> ===================================================================
> --- linux-2.6.17.orig/mm/Kconfig        2006-06-26 14:19:11.000000000
> +0900
> +++ linux-2.6.17/mm/Kconfig     2006-06-26 14:19:53.000000000 +0900
> @@ -115,7 +115,7 @@ config SPARSEMEM_EXTREME
>  # eventually, we can have this option just 'select SPARSEMEM'
>  config MEMORY_HOTPLUG
>         bool "Allow for memory hot-add"
> -       depends on SPARSEMEM && HOTPLUG && !SOFTWARE_SUSPEND
> +       depends on SPARSEMEM && HOTPLUG && !SOFTWARE_SUSPEND
> && !(X86_32 && !HIGHMEM)
>  
>  comment "Memory hotplug is currently incompatible with Software
> Suspend"
>         depends on SPARSEMEM && HOTPLUG && SOFTWARE_SUSPEND 

I think it makes a lot more sense to just disable sparsemem when !
HIGHMEM.  Plus, we can do all of that in the arch-specific Kconfigs and
not litter the generic ones with this stuff.

-- Dave

