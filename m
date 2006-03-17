Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751244AbWCQSBe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbWCQSBe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 13:01:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbWCQSBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 13:01:33 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:28907 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751244AbWCQSBc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 13:01:32 -0500
Subject: Re: [PATCH: 017/017]Memory hotplug for new nodes
	v.4.(arch_register_node() for ia64)
From: Dave Hansen <haveblue@us.ibm.com>
To: Yasunori Goto <y-goto@jp.fujitsu.com>
Cc: Andrew Morton <akpm@osdl.org>, "Luck, Tony" <tony.luck@intel.com>,
       Andi Kleen <ak@suse.de>, Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org, linux-mm <linux-mm@kvack.org>
In-Reply-To: <20060317163911.C659.Y-GOTO@jp.fujitsu.com>
References: <20060317163911.C659.Y-GOTO@jp.fujitsu.com>
Content-Type: text/plain
Date: Fri, 17 Mar 2006 10:00:34 -0800
Message-Id: <1142618434.10906.99.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-17 at 17:23 +0900, Yasunori Goto wrote:
> +++ pgdat8/arch/ia64/kernel/topology.c	2006-03-16 16:06:27.000000000 +0900
> @@ -65,6 +65,21 @@ EXPORT_SYMBOL(arch_register_cpu);
>  EXPORT_SYMBOL(arch_unregister_cpu);
>  #endif /*CONFIG_HOTPLUG_CPU*/
>  
> +#ifdef CONFIG_NUMA
> +int arch_register_node(int num)
> +{
> +	if (sysfs_nodes[num].sysdev.id == num)
> +		return 0;
> +
> +	return register_node(&sysfs_nodes[num], num, 0);
> +}
> +
> +void arch_unregister_node(int num)
> +{
> +	unregister_node(&sysfs_nodes[num]);
> +	sysfs_nodes[num].sysdev.id = -1;
> +}
> +#endif

I don't have a real problem with you cluttering up ia64 code, but if
these are useful, why don't we put them in generic code?  They seem
quite arch-independent to me.

-- Dave

