Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753927AbWKHChy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753927AbWKHChy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 21:37:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753931AbWKHChy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 21:37:54 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:29325 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1753927AbWKHChy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 21:37:54 -0500
Date: Wed, 8 Nov 2006 11:40:38 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Christoph Hellwig <hch@lst.de>
Cc: davem@davemloft.net, hch@lst.de, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, linux-mm@kvack.org
Subject: Re: [PATCH 2/3] add dev_to_node()
Message-Id: <20061108114038.59831f9d.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20061104225629.GA31437@lst.de>
References: <20061030141501.GC7164@lst.de>
	<20061030.143357.130208425.davem@davemloft.net>
	<20061104225629.GA31437@lst.de>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I have a question.

On Sat, 4 Nov 2006 23:56:29 +0100
Christoph Hellwig <hch@lst.de> wrote:
> Index: linux-2.6/include/linux/device.h
> ===================================================================
> --- linux-2.6.orig/include/linux/device.h	2006-10-29 16:02:38.000000000 +0100
> +++ linux-2.6/include/linux/device.h	2006-11-02 12:47:17.000000000 +0100
> @@ -347,6 +347,9 @@
>  					   BIOS data),reserved for device core*/
>  	struct dev_pm_info	power;
>  
> +#ifdef CONFIG_NUMA
> +	int		numa_node;	/* NUMA node this device is close to */
> +#endif

> +	dev->dev.numa_node = pcibus_to_node(bus);

Does this "node" is guaranteed to be online ?

if node is not online, NODE_DATA(node) is NULL or not initialized.
Then, alloc_pages_node() at el. will panic.

I wonder there are no code for creating NODE_DATA() for device-only-node.

-Kame

