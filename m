Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030289AbVHPShm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030289AbVHPShm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 14:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030291AbVHPShm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 14:37:42 -0400
Received: from dsl027-180-204.sfo1.dsl.speakeasy.net ([216.27.180.204]:22756
	"EHLO outer-richmond.davemloft.net") by vger.kernel.org with ESMTP
	id S1030289AbVHPShl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 14:37:41 -0400
Date: Tue, 16 Aug 2005 11:37:28 -0700 (PDT)
Message-Id: <20050816.113728.44187103.davem@davemloft.net>
To: alan@lxorguk.ukuu.org.uk
Cc: kern@sibbald.com, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: blocking read on socket repeatedly returns EAGAIN
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <1124200991.17555.33.camel@localhost.localdomain>
References: <200508161519.39719.kern@sibbald.com>
	<1124200991.17555.33.camel@localhost.localdomain>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Tue, 16 Aug 2005 15:03:11 +0100

> You are describing behaviour as expected with nonblocking set. That
> suggests to me that something or someone set or inherited the nonblock
> flag on that socket. Is the strange behaviour specific to the latest
> kernel ?

He could be receiving a signal Alan, look at tcp_recvmsg(),
it returns -EAGAIN and always has when a signal is delivered
to the reading process.
