Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266473AbUIVRK4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266473AbUIVRK4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 13:10:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266465AbUIVRKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 13:10:51 -0400
Received: from fmr04.intel.com ([143.183.121.6]:56006 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S266463AbUIVRKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 13:10:41 -0400
Date: Wed, 22 Sep 2004 10:10:30 -0700
From: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
To: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Cc: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>, len.brown@intel.com,
       acpi-devel@lists.sourceforge.net, lhns-devel@lists.sourceforge.net,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [ACPI] PATCH-ACPI based CPU hotplug[4/6]-Dynamic cpu register/unregister support
Message-ID: <20040922101029.B2631@unix-os.sc.intel.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
References: <20040920092520.A14208@unix-os.sc.intel.com> <20040920094106.F14208@unix-os.sc.intel.com> <20040922173400.4e717946.tokunaga.keiich@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040922173400.4e717946.tokunaga.keiich@jp.fujitsu.com>; from tokunaga.keiich@jp.fujitsu.com on Wed, Sep 22, 2004 at 05:34:00PM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2004 at 05:34:00PM +0900, Keiichiro Tokunaga wrote:
> On Mon, 20 Sep 2004 09:41:07 -0700 Keshavamurthy Anil S wrote:
> > ---
> > Name:topology.patch
> > Status:Tested on 2.6.9-rc2
> > Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
> > Depends:	
> > Version: applies on 2.6.9-rc2	
> > Description:
> > Extends support for dynamic registration and unregistration of the cpu,
> > by implementing and exporting arch_register_cpu()/arch_unregister_cpu().
> > Also combines multiple implementation of topology_init() functions to
> > single topology_init() in case of ia64 architecture.
> > ---
> 
> > +void arch_unregister_cpu(int num)
> > +{
> > +	struct node *parent = NULL;
> > +
> > +#ifdef CONFIG_NUMA
> > +	int node = cpu_to_node(num);
> > +	if (node_online(node))
> > +		parent = &sysfs_nodes[node];
> > +#endif /* CONFIG_NUMA */
> > +
> > +	return unregister_cpu(&sysfs_cpus[num].cpu, parent);
> > +}
> 
> I don't think that the check 'if (node_online(node))' is necessary
> because sysfs_nodes[node] is there no matter if the node is online
> or offline.  sysfs_nodes[] is cleared only when unregister_node()
> is called and it would be always called after unregister_cpu().

Yes, I agree with you. I will remove the check, or simply apply your patch:)
thanks,
Anil
