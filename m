Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161172AbWASC3e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161172AbWASC3e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 21:29:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161173AbWASC3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 21:29:34 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:54678
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1161172AbWASC3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 21:29:34 -0500
Date: Wed, 18 Jan 2006 18:29:35 -0800 (PST)
Message-Id: <20060118.182935.80593235.davem@davemloft.net>
To: greearb@candelatech.com
Cc: trond.myklebust@fys.uio.no, linux-kernel@vger.kernel.org
Subject: Re: Can you specify a local IP or Interface to be used on a per
 NFS mount basis?
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <43CEF7A6.30802@candelatech.com>
References: <43CECB00.40405@candelatech.com>
	<1137631728.13076.1.camel@lade.trondhjem.org>
	<43CEF7A6.30802@candelatech.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>
Date: Wed, 18 Jan 2006 18:21:26 -0800

> When a socket is created, you can optionally bind to local IP,
> interface and/or IP-Port.  Somewhere, NFS is opening a socket I
> assume?  So, is there a way to ask it to bind?

Things like net/sunrpc/xprtsock.c:xs_bindresvport() will bind,
but to a specific port.  It leaves the address field all zeros
which makes the kernel pick a default.

net/sunrpc/svcsock.c does something similar, you can get it
to use a particular port but it uses INADDR_ANY for the
address during the bind().
