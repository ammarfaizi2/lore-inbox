Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750997AbWHMLw6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750997AbWHMLw6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 07:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751015AbWHMLw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 07:52:58 -0400
Received: from stinky.trash.net ([213.144.137.162]:48568 "EHLO
	stinky.trash.net") by vger.kernel.org with ESMTP id S1751000AbWHMLw5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 07:52:57 -0400
Message-ID: <44DF129A.6060607@trash.net>
Date: Sun, 13 Aug 2006 13:52:58 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Akinobu Mita <mita@miraclelinux.com>
CC: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, akpm@osdl.org,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] fix use after free in netlink_kernel_create()
References: <20060813101535.GA8703@miraclelinux.com>
In-Reply-To: <20060813101535.GA8703@miraclelinux.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Akinobu Mita wrote:
> This patch invalidates nl_table by setting NULL when netlink
> initialization failed. Otherwise netlink_kernel_create() would
> access nl_table which has already been freed.


Quite a few users of netlink_kernel_create will panic when creating
the socket fails (rtnetlink for example, which is always present),
so you might as well call panic here directly.

