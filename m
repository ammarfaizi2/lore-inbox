Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267189AbUI0SxA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267189AbUI0SxA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 14:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267186AbUI0SxA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 14:53:00 -0400
Received: from fmr03.intel.com ([143.183.121.5]:25233 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S267184AbUI0Sw5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 14:52:57 -0400
Date: Mon, 27 Sep 2004 11:52:44 -0700
From: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
To: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Cc: anil.s.keshavamurthy@intel.com, len.brown@intel.com,
       acpi-devel@lists.sourceforge.net, lhns-devel@lists.sourceforge.net,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][1/4] Add unregister_node() to drivers/base/node.c
Message-ID: <20040927115244.A30443@unix-os.sc.intel.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
References: <20040920092520.A14208@unix-os.sc.intel.com> <20040920094719.H14208@unix-os.sc.intel.com> <20040924012301.000007c6.tokunaga.keiich@jp.fujitsu.com> <20040924013123.000067cd.tokunaga.keiich@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040924013123.000067cd.tokunaga.keiich@jp.fujitsu.com>; from tokunaga.keiich@jp.fujitsu.com on Fri, Sep 24, 2004 at 01:31:23AM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2004 at 01:31:23AM +0900, Keiichiro Tokunaga wrote:
> 
> -int __init register_node(struct node *node, int num, struct node *parent)
> +int register_node(struct node *node, int num, struct node *parent)

__devinit please

> +void  unregister_node(struct node *node, struct node *parent)

unregister_node is required only for hotplug case. Please hide this function
under suitable #ifdef's, say this is only required if CONFIG_HOTPLUG is enabled.

> +	sysdev_remove_file(&node->sysdev, &attr_cpumap);
> +	sysdev_remove_file(&node->sysdev, &attr_meminfo);

add sysdev_remove_file(&node->sysdev, &attr_numastat);

> +EXPORT_SYMBOL(node_online_map);
Why do you need this in this patch?
