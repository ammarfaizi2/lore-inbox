Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932134AbWCTJ7A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134AbWCTJ7A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 04:59:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932089AbWCTJ7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 04:59:00 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:18816 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751079AbWCTJ66 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 04:58:58 -0500
Date: Mon, 20 Mar 2006 18:57:39 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH: 017/017]Memory hotplug for new nodes v.4.(arch_register_node() for ia64)
Cc: Andrew Morton <akpm@osdl.org>, "Luck, Tony" <tony.luck@intel.com>,
       Andi Kleen <ak@suse.de>, Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org, linux-mm <linux-mm@kvack.org>
In-Reply-To: <1142618434.10906.99.camel@localhost.localdomain>
References: <20060317163911.C659.Y-GOTO@jp.fujitsu.com> <1142618434.10906.99.camel@localhost.localdomain>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060320183634.7E9C.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, 2006-03-17 at 17:23 +0900, Yasunori Goto wrote:
> > +++ pgdat8/arch/ia64/kernel/topology.c	2006-03-16 16:06:27.000000000 +0900
> > @@ -65,6 +65,21 @@ EXPORT_SYMBOL(arch_register_cpu);
> >  EXPORT_SYMBOL(arch_unregister_cpu);
> >  #endif /*CONFIG_HOTPLUG_CPU*/
> >  
> > +#ifdef CONFIG_NUMA
> > +int arch_register_node(int num)
> > +{
> > +	if (sysfs_nodes[num].sysdev.id == num)
> > +		return 0;
> > +
> > +	return register_node(&sysfs_nodes[num], num, 0);
> > +}
> > +
> > +void arch_unregister_node(int num)
> > +{
> > +	unregister_node(&sysfs_nodes[num]);
> > +	sysfs_nodes[num].sysdev.id = -1;
> > +}
> > +#endif
> 
> I don't have a real problem with you cluttering up ia64 code, but if
> these are useful, why don't we put them in generic code?  They seem
> quite arch-independent to me.

I'm not sure they can be common code.

Current i386's code treats "parent node" in arch_register_node(). 
But, IA64 doesn't need it.

Bye.

-- 
Yasunori Goto 


