Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751127AbVIFXHd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbVIFXHd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 19:07:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbVIFXHd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 19:07:33 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:60561
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751121AbVIFXHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 19:07:32 -0400
Date: Tue, 06 Sep 2005 16:07:28 -0700 (PDT)
Message-Id: <20050906.160728.25203864.davem@davemloft.net>
To: kaber@trash.net
Cc: daniele@orlandi.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: proto_unregister sleeps while atomic
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <431E1FE9.7030405@trash.net>
References: <200509070026.34999.daniele@orlandi.com>
	<431E1FE9.7030405@trash.net>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick McHardy <kaber@trash.net>
Date: Wed, 07 Sep 2005 01:02:01 +0200

> You're right, good catch. This patch fixes it by moving the lock
> down to the list-operation which it is supposed to protect.

I think we need to unlink from the list first if you're
going to do it this way.  Otherwise someone can find the
protocol via lookup, and then bogusly try to use the SLAB
cache we're freeing up.

Or does something else prevent this?
