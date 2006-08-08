Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932368AbWHHDsI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932368AbWHHDsI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 23:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932460AbWHHDsH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 23:48:07 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:42432
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932368AbWHHDsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 23:48:07 -0400
Date: Mon, 07 Aug 2006 20:48:10 -0700 (PDT)
Message-Id: <20060807.204810.11384152.davem@davemloft.net>
To: pavlin@icir.org
Cc: linux-kernel@vger.kernel.org, roland@topspin.com
Subject: Re: Bug in the RTM_SETLINK kernel API for setting MAC address
From: David Miller <davem@davemloft.net>
In-Reply-To: <200608080340.k783eOfH076445@possum.icir.org>
References: <200608080340.k783eOfH076445@possum.icir.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavlin Radoslavov <pavlin@icir.org>
Date: Mon, 07 Aug 2006 20:40:24 -0700

> Note that the payload with the MAC address has to be
> "struct sockaddr" (or equivalent) and the length of that payload is
> the equivalent of "sizeof(sa_family) + mac_address_size".

It should just be the MAC address, that's why the kernel side
is coded the way it is.

Where does this sockaddr come from?

I don't see how it could work with the sockaddr there in
2.6.17, as 2.6.17 makes the same exact length check:

		if (ida[IFLA_ADDRESS - 1]->rta_len != RTA_LENGTH(dev->addr_len))
			goto out;
