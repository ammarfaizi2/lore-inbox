Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750792AbVKOV2h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbVKOV2h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 16:28:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbVKOV2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 16:28:36 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:13223
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750792AbVKOV2g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 16:28:36 -0500
Date: Tue, 15 Nov 2005 13:28:36 -0800 (PST)
Message-Id: <20051115.132836.41612515.davem@davemloft.net>
To: Markus.Lidel@shadowconnect.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] I2O: SPARC fixes
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <4379AADD.5000600@shadowconnect.com>
References: <4379AADD.5000600@shadowconnect.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Lidel <Markus.Lidel@shadowconnect.com>
Date: Tue, 15 Nov 2005 10:31:09 +0100

> +config I2O_LCT_NOTIFY_ON_CHANGES
> +	bool "Enable LCT notification"
> +	depends on I2O
> +	default y
> +	---help---
> +	  Only say N here if you have a I2O controller from SUN. The SUN
> +	  firmware doesn't support LCT notification on changes. If this option
> +	  is enabled on such a controller the driver will hang up in a endless
> +	  loop. On all other controllers say Y.
> +
> +	  If unsure, say Y.
> +

This should be detected at runtime, and that is easily done.

You can use the PCI device to get at the firmware device
node, and use that to look for a firmware device node property
that identifies it as a card from Sun.

Usually the "name" property has some identifying string in it.
Sometimes there is a property with the string "fcode" in it and you
could look for that as well.
