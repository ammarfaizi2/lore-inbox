Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbWEOWto@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbWEOWto (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 18:49:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750709AbWEOWto
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 18:49:44 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:9617
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750708AbWEOWtn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 18:49:43 -0400
Date: Mon, 15 May 2006 15:49:39 -0700 (PDT)
Message-Id: <20060515.154939.28171388.davem@davemloft.net>
To: mark1smi@us.ibm.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: send(), sendmsg(), sendto() not thread-safe
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <OFE8460E54.0C8D85D8-ON8525716F.0074F22F-8825716F.0076D537@us.ibm.com>
References: <OFE8460E54.0C8D85D8-ON8525716F.0074F22F-8825716F.0076D537@us.ibm.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark A Smith <mark1smi@us.ibm.com>
Date: Mon, 15 May 2006 14:39:06 -0700

> I discovered that in some cases, send(), sendmsg(), and sendto() are not
> thread-safe. Although the man page for these functions does not specify
> whether these functions are supposed to be thread-safe, my reading of the
> POSIX/SUSv3 specification tells me that they should be. I traced the
> problem to tcp_sendmsg(). I was very curious about this issue, so I wrote
> up a small page to describe in more detail my findings. You can find it at:
> http://www.almaden.ibm.com/cs/people/marksmith/sendmsg.html .

I don't understand why the desire is so high to ensure that
individual threads get "atomic" writes, you can't even ensure
that in the general case.

Only sloppy programs that don't do their own internal locking hit into
issues in this area.

>From your findings, the vast majority of systems you investigated do
not provide "atomic" thread safe write semantics over TCP sockets.
And frankly, BSD defines BSD socket semantics here not some wording in
the POSIX standards.

Finally, this discussion belongs on the networking development mailing
list, netdev@vger.kernel.org, not linux-kernel.
