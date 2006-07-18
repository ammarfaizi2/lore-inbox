Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932394AbWGRUl6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932394AbWGRUl6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 16:41:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932391AbWGRUl6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 16:41:58 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:17344
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932337AbWGRUl5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 16:41:57 -0400
Date: Tue, 18 Jul 2006 13:42:19 -0700 (PDT)
Message-Id: <20060718.134219.48395353.davem@davemloft.net>
To: chrisw@sous-sol.org
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, jeremy@goop.org, ak@suse.de,
       akpm@osdl.org, rusty@rustcorp.com.au, zach@vmware.com,
       ian.pratt@xensource.com, Christian.Limpach@cl.cam.ac.uk,
       netdev@vger.kernel.org
Subject: Re: [RFC PATCH 32/33] Add the Xen virtual network device driver.
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060718091958.414414000@sous-sol.org>
References: <20060718091807.467468000@sous-sol.org>
	<20060718091958.414414000@sous-sol.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Wright <chrisw@sous-sol.org>
Date: Tue, 18 Jul 2006 00:00:32 -0700

> +#ifdef CONFIG_XEN_BALLOON
> +#include <xen/balloon.h>
> +#endif

Let's put the ifdefs in xen/balloon.h not in the files
including it.

> +#ifdef CONFIG_XEN_BALLOON
> +	/* Tell the ballon driver what is going on. */
> +	balloon_update_driver_allowance(i);
> +#endif

Similarly let's define empty do-nothing functions in
xen/balloon.h when the config option isn't set so we
don't need to crap up the C sources with these ifdefs.
