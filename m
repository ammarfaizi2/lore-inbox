Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263997AbSJJUm5>; Thu, 10 Oct 2002 16:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263998AbSJJUm5>; Thu, 10 Oct 2002 16:42:57 -0400
Received: from ns.suse.de ([213.95.15.193]:56837 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S263997AbSJJUm4>;
	Thu, 10 Oct 2002 16:42:56 -0400
To: Kevin Corry <corryk@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EVMS core (3/9) discover.c
References: <02101014305502.17770@boiler.suse.lists.linux.kernel> <02101014352905.17770@boiler.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 10 Oct 2002 22:48:42 +0200
In-Reply-To: Kevin Corry's message of "10 Oct 2002 22:20:58 +0200"
Message-ID: <p73n0pmow9h.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin Corry <corryk@us.ibm.com> writes:

> +	list_for_each_entry(plugin, &plugin_head, headers) {
> +		if (GetPluginType(plugin->id) == EVMS_DEVICE_MANAGER) {
> +			spin_unlock(&plugin_lock);
> +			DISCOVER(plugin, disk_list);
> +			spin_lock(&plugin_lock);
> +		}

How do you know "plugin" and its successors are still valid when retaking 
the spinlock? Looks like you need a reference count on the object here.

Similar with other functions.

> +
> +	if (!gd) {
> +		gd = alloc_disk();
> +		BUG_ON(!gd);


BUG_ON ? Can't this fail for legal reasons?


-Andi
