Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932228AbWC1VH4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932228AbWC1VH4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 16:07:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932215AbWC1VHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 16:07:55 -0500
Received: from smtp.osdl.org ([65.172.181.4]:64667 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932213AbWC1VHy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 16:07:54 -0500
Date: Tue, 28 Mar 2006 13:07:36 -0800
From: Andrew Morton <akpm@osdl.org>
To: Yasunori Goto <y-goto@jp.fujitsu.com>
Cc: tony.luck@intel.com, ak@suse.de, len.brown@intel.com,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       linux-ia64@vger.kernel.org, discuss@x86-64.org
Subject: Re: [Patch:001/004]Unify pxm_to_node id ver.3.(generic code)
Message-Id: <20060328130736.5a4273d9.akpm@osdl.org>
In-Reply-To: <20060328191250.CC48.Y-GOTO@jp.fujitsu.com>
References: <20060328183058.CC46.Y-GOTO@jp.fujitsu.com>
	<20060328191250.CC48.Y-GOTO@jp.fujitsu.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yasunori Goto <y-goto@jp.fujitsu.com> wrote:
>
> +/* Proximity bitmap length */
>  +#ifdef CONFIG_NR_NODES_CHANGABLE
>  +#define MAX_PXM_DOMAINS CONFIG_NR_NODES
>  +#else
>  +#define MAX_PXM_DOMAINS (256)
>  +#endif

I don't think we need CONFIG_NR_NODES_CHANGABLE (it is spelled
"changeable", btw).

If the architecture wants to support changing of CONFIG_NR_NODES then it
can permit CONFIG_NR_NODES to be changed in its Kconfig implementation.

If the architecture doesn't want to permit changing of CONFIG_NR_NODES
then it should simply hardwire CONFIG_NR_NODES to the chosen value in
its Kconfig.

So all architectures which use acpi_numa must implement CONFIG_NR_NODES.

In fact, it would probably make sense to require that all NUMA-supporting
archtectures implement CONFIG_NR_NODES.

Also, we already have NODES_SHIFT defined in include/asm-*/numnodes.h. 
What's the relationship between that and CONFIG_NR_NODES?  It seems that we
want to derive NODES_SHIFT from CONFIG_NR_NODES.

Was ia64's CONFIG_IA64_NR_NODES the best choice?  Should ia64 instead have
made NODES_SHIFT Kconfigurable, and derived its max-nr_nodes from that?

It's all a bit of a pickle.


I guess for now a suitable approach would be to make all numa-using
architectures define CONFIG_NR_NODES, and to leave that rather
unpleasant-looking code in include/asm-ia64/numnodes.h as it is.

